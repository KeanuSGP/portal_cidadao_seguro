from django.db import transaction
from django.shortcuts import get_object_or_404
from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied, ValidationError
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import OrderingFilter
from rest_framework.permissions import IsAuthenticated, IsAdminUser

from .models import UnidadeAtendimento, SolicitacaoZeladoria, HistoricoSolicitacao, AnexoSolicitacao
from .permissions import PodeConsultarUnidades, PermissaoSolicitacao, is_admin, is_servidor
from .serializers import (UnidadeAtendimentoSerializer, SolicitacaoLeituraSerializer,
    SolicitacaoCriacaoSerializer, SolicitacaoAtualizacaoSerializer, HistoricoSolicitacaoSerializer, AnexoSolicitacaoSerializer)
from .services import registrar_criacao, cancelar_solicitacao, alterar_status


class UnidadeAtendimentoViewSet(viewsets.ModelViewSet):
    queryset = UnidadeAtendimento.objects.all()
    serializer_class = UnidadeAtendimentoSerializer
    search_fields = ["nome", "descricao", "codigo"]
    ordering_fields = ["nome"]
    ordering = ["nome"]

    def get_permissions(self):
        if self.action in ["list", "retrieve"]:
            return [PodeConsultarUnidades()]

        return [IsAuthenticated(), IsAdminUser()]


class SolicitacaoViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated, PermissaoSolicitacao]
    http_method_names = ["get", "post", "patch", "head", "options"]
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_fields = ["status", "servico", "unidade_atual"]
    ordering_fields = ["criado_em", "atualizado_em", "status"]
    ordering = ["-criado_em"]

    def get_queryset(self):
        qs = SolicitacaoZeladoria.objects.select_related("solicitante", "responsavel", "servico", "unidade_atual")
        user = self.request.user
        if is_admin(user) or is_servidor(user):
            return qs
        return qs.filter(solicitante=user)

    def get_serializer_class(self):
        if self.action == "create":
            return SolicitacaoCriacaoSerializer
        return SolicitacaoLeituraSerializer

    @transaction.atomic
    def perform_create(self, serializer):
        solicitacao = serializer.save(solicitante=self.request.user)
        registrar_criacao(solicitacao, self.request.user)

    def partial_update(self, request, *args, **kwargs):
        solicitacao = self.get_object()
        if not (is_admin(request.user) or is_servidor(request.user)):
            raise PermissionDenied("Somente servidores autorizados podem editar solicitações.")
        campos_permitidos = {"descricao", "respostas_adicionais", "unidade_atual", "responsavel"}
        if not set(request.data.keys()).issubset(campos_permitidos):
            raise ValidationError("A atualização contém campos não permitidos. Altere o status pelo endpoint próprio.")
        serializer = SolicitacaoAtualizacaoSerializer(solicitacao, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        HistoricoSolicitacao.objects.create(solicitacao=solicitacao, ator=request.user,
            acao=HistoricoSolicitacao.Acao.ALTERACAO_DADOS, comentario="Dados da solicitação atualizados.")
        return Response(SolicitacaoLeituraSerializer(solicitacao).data)

    @action(detail=True, methods=["post"])
    def cancelar(self, request, pk=None):
        solicitacao = self.get_object()
        if not (is_admin(request.user) or is_servidor(request.user)) and solicitacao.solicitante_id != request.user.id:
            raise PermissionDenied("Você não pode cancelar esta solicitação.")
        try:
            cancelar_solicitacao(solicitacao, request.user, request.data.get("comentario", ""))
        except ValueError as exc:
            raise ValidationError(str(exc))
        return Response(SolicitacaoLeituraSerializer(solicitacao).data)

    @action(detail=True, methods=["post"], url_path="alterar-status")
    def alterar_status_action(self, request, pk=None):
        if not (is_admin(request.user) or is_servidor(request.user)):
            raise PermissionDenied("Somente servidores podem alterar o status.")
        solicitacao = self.get_object()
        novo_status = request.data.get("status")
        if not novo_status:
            raise ValidationError({"status": "Este campo é obrigatório."})
        try:
            alterar_status(solicitacao, request.user, novo_status, request.data.get("comentario", ""))
        except ValueError as exc:
            raise ValidationError(str(exc))
        return Response(SolicitacaoLeituraSerializer(solicitacao).data)

    @action(detail=True, methods=["get"])
    def historico(self, request, pk=None):
        solicitacao = self.get_object()
        qs = solicitacao.historico.select_related("ator", "unidade_origem", "unidade_destino", "responsavel_anterior", "responsavel_novo")
        return Response(HistoricoSolicitacaoSerializer(qs, many=True).data)

    @action(detail=True, methods=["get", "post"], parser_classes=[MultiPartParser, FormParser])
    def anexos(self, request, pk=None):
        solicitacao = self.get_object()
        if request.method == "GET":
            return Response(AnexoSolicitacaoSerializer(solicitacao.anexos.all(), many=True, context={"request": request}).data)
        if not request.FILES.get("arquivo"):
            raise ValidationError({"arquivo": "Envie um arquivo de imagem no campo arquivo."})
        serializer = AnexoSolicitacaoSerializer(data={"arquivo": request.FILES["arquivo"]}, context={"request": request})
        serializer.is_valid(raise_exception=True)
        serializer.save(solicitacao=solicitacao)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

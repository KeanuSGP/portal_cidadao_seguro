from rest_framework.viewsets import ModelViewSet

from .models import ModuloPortal, Tema, Assunto, ServicoCatalogo
from .permissions import LeituraPublicaEscritaAdmin
from .serializers import (
    ModuloPortalSerializer,
    TemaSerializer,
    AssuntoSerializer,
    ServicoCatalogoSerializer,
)


class ModuloPortalViewSet(ModelViewSet):
    queryset = ModuloPortal.objects.all()
    serializer_class = ModuloPortalSerializer
    permission_classes = [LeituraPublicaEscritaAdmin]
    search_fields = ["nome", "descricao", "codigo"]
    ordering_fields = ["nome", "ordem", "criado_em"]
    filterset_fields = ["ativo"]


class TemaViewSet(ModelViewSet):
    queryset = Tema.objects.select_related("modulo").all()
    serializer_class = TemaSerializer
    permission_classes = [LeituraPublicaEscritaAdmin]
    search_fields = ["nome", "descricao", "codigo"]
    ordering_fields = ["nome", "ordem"]
    filterset_fields = ["ativo", "modulo"]


class AssuntoViewSet(ModelViewSet):
    queryset = Assunto.objects.select_related("tema", "tema__modulo").all()
    serializer_class = AssuntoSerializer
    permission_classes = [LeituraPublicaEscritaAdmin]
    search_fields = ["nome", "descricao", "codigo"]
    ordering_fields = ["nome", "ordem"]
    filterset_fields = ["ativo", "tema"]


class ServicoCatalogoViewSet(ModelViewSet):
    queryset = ServicoCatalogo.objects.select_related(
        "assunto", "assunto__tema", "assunto__tema__modulo"
    ).all()
    serializer_class = ServicoCatalogoSerializer
    permission_classes = [LeituraPublicaEscritaAdmin]
    search_fields = ["nome", "descricao", "instrucoes", "codigo"]
    ordering_fields = ["nome", "ordem", "prazo_estimado_dias", "criado_em"]
    filterset_fields = ["ativo", "assunto"]

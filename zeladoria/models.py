import uuid

from django.conf import settings
from django.db import models

from catalogo.mixins import CodigoAutomaticoModel
from catalogo.models import ServicoCatalogo


class UnidadeAtendimento(CodigoAutomaticoModel):

    nome = models.CharField(max_length=150)

    descricao = models.TextField(
        blank=True,
        default="",
    )

    ativo = models.BooleanField(default=True)

    criado_em = models.DateTimeField(
        auto_now_add=True,
    )

    servicos = models.ManyToManyField(
    "catalogo.ServicoCatalogo",
    through="UnidadeServico",
    related_name="unidades_atendimento",
    blank=True
)

    class Meta:
        db_table = "zeladoria_unidadeatendimento"
        ordering = ["nome"]

    def __str__(self):
        return self.nome


class SolicitacaoZeladoria(models.Model):

    class Status(models.TextChoices):
        RECEBIDA = "RECEBIDA", "Recebida"
        EM_ANALISE = "EM_ANALISE", "Em análise"
        EM_ATENDIMENTO = "EM_ATENDIMENTO", "Em atendimento"
        PENDENTE = "PENDENTE", "Pendente"
        CONCLUIDA = "CONCLUIDA", "Concluída"
        CANCELADA = "CANCELADA", "Cancelada"

    protocolo = models.UUIDField(
        default=uuid.uuid4,
        unique=True,
        editable=False,
    )

    solicitante = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name="solicitacoes",
    )

    responsavel = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="solicitacoes_responsaveis",
    )

    servico = models.ForeignKey(
        ServicoCatalogo,
        on_delete=models.PROTECT,
        related_name="solicitacoes",
    )

    unidade_atual = models.ForeignKey(
        UnidadeAtendimento,
        on_delete=models.PROTECT,
        null=True,
        blank=True,
        related_name="solicitacoes",
    )

    descricao = models.TextField()

    respostas_adicionais = models.JSONField(
        default=dict,
        blank=True,
    )

    formulario_versao = models.PositiveIntegerField(default=1)

    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.RECEBIDA,
    )

    logradouro = models.CharField(
        max_length=200,
        blank=True,
        default="",
    )

    numero = models.CharField(
        max_length=20,
        blank=True,
        default="",
    )

    complemento = models.CharField(
        max_length=150,
        blank=True,
        default="",
    )

    bairro = models.CharField(
        max_length=100,
        blank=True,
        default="",
    )

    cep = models.CharField(
        max_length=8,
        blank=True,
        default="",
    )

    ponto_referencia = models.CharField(
        max_length=200,
        blank=True,
        default="",
    )

    latitude = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        null=True,
        blank=True,
    )

    longitude = models.DecimalField(
        max_digits=9,
        decimal_places=6,
        null=True,
        blank=True,
    )

    criado_em = models.DateTimeField(auto_now_add=True)

    atualizado_em = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "zeladoria_solicitacaozeladoria"
        ordering = ["-criado_em"]

        indexes = [
            models.Index(
                fields=["solicitante", "-criado_em"],
                name="idx_solicitante_criacao",
            ),
            models.Index(
                fields=["status", "-criado_em"],
                name="idx_status_criacao",
            ),
            models.Index(
                fields=["unidade_atual", "status"],
                name="idx_unidade_status",
            ),
        ]

    def __str__(self):
        return str(self.protocolo)


class HistoricoSolicitacao(models.Model):

    class Acao(models.TextChoices):
        CRIACAO = "CRIACAO", "Criação"
        ALTERACAO_DADOS = "ALTERACAO_DADOS", "Alteração de dados"
        ALTERACAO_STATUS = "ALTERACAO_STATUS", "Alteração de status"
        ATRIBUICAO = "ATRIBUICAO", "Atribuição"
        ENCAMINHAMENTO = "ENCAMINHAMENTO", "Encaminhamento"
        CANCELAMENTO = "CANCELAMENTO", "Cancelamento"
        CONCLUSAO = "CONCLUSAO", "Conclusão"

    solicitacao = models.ForeignKey(
        SolicitacaoZeladoria,
        on_delete=models.PROTECT,
        related_name="historico",
    )

    ator = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="acoes_solicitacoes",
    )

    acao = models.CharField(
        max_length=30,
        choices=Acao.choices,
    )

    status_anterior = models.CharField(
        max_length=20,
        choices=SolicitacaoZeladoria.Status.choices,
        blank=True,
        default="",
    )

    status_novo = models.CharField(
        max_length=20,
        choices=SolicitacaoZeladoria.Status.choices,
        blank=True,
        default="",
    )

    unidade_origem = models.ForeignKey(
        UnidadeAtendimento,
        on_delete=models.PROTECT,
        null=True,
        blank=True,
        related_name="historicos_origem",
    )

    unidade_destino = models.ForeignKey(
        UnidadeAtendimento,
        on_delete=models.PROTECT,
        null=True,
        blank=True,
        related_name="historicos_destino",
    )

    responsavel_anterior = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="historicos_responsavel_anterior",
    )

    responsavel_novo = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="historicos_responsavel_novo",
    )

    comentario = models.TextField(
        blank=True,
        default="",
    )

    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "zeladoria_historicosolicitacao"
        ordering = ["criado_em"]

    def __str__(self):
        return f"{self.acao} - {self.solicitacao}"


class AnexoSolicitacao(models.Model):

    solicitacao = models.ForeignKey(
        SolicitacaoZeladoria,
        on_delete=models.PROTECT,
        related_name="anexos",
    )

    enviado_por = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="anexos_enviados",
    )

    arquivo = models.ImageField(
        upload_to="zeladoria/anexos/%Y/%m/",
    )

    nome_original = models.CharField(max_length=255)

    tipo_conteudo = models.CharField(
        max_length=100,
        blank=True,
        default="",
    )

    tamanho_bytes = models.PositiveBigIntegerField()

    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "zeladoria_anexosolicitacao"
        ordering = ["criado_em"]

    def __str__(self):
        return self.nome_original


class UnidadeServico(models.Model):
    unidade = models.ForeignKey(
        UnidadeAtendimento,
        on_delete=models.CASCADE,
        related_name="servicos_vinculados"
    )

    servico = models.ForeignKey(
        "catalogo.ServicoCatalogo",
        on_delete=models.PROTECT,
        related_name="unidades_vinculadas"
    )

    prazo_atendimento_dias = models.PositiveIntegerField(
        null=True,
        blank=True
    )

    ativo = models.BooleanField(default=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=["unidade", "servico"],
                name="unique_unidade_servico"
            )
        ]

    def __str__(self):
        return f"{self.unidade} - {self.servico}"
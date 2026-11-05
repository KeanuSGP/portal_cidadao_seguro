from django.db import models

from .mixins import CodigoAutomaticoModel


class ModuloPortal(CodigoAutomaticoModel):

    nome = models.CharField(max_length=150)

    descricao = models.TextField(
        blank=True,
        default="",
    )

    ativo = models.BooleanField(default=True)

    ordem = models.PositiveIntegerField(default=0)

    criado_em = models.DateTimeField(
        auto_now_add=True,
    )

    atualizado_em = models.DateTimeField(
        auto_now=True,
    )

    class Meta:
        db_table = "catalogo_moduloportal"
        ordering = ["ordem", "nome"]

    def __str__(self):
        return self.nome


class Tema(CodigoAutomaticoModel):

    modulo = models.ForeignKey(
        ModuloPortal,
        on_delete=models.PROTECT,
        related_name="temas",
    )

    nome = models.CharField(max_length=150)

    descricao = models.TextField(
        blank=True,
        default="",
    )

    ativo = models.BooleanField(default=True)

    ordem = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = "catalogo_tema"
        ordering = ["ordem", "nome"]

    def __str__(self):
        return self.nome


class Assunto(CodigoAutomaticoModel):

    tema = models.ForeignKey(
        Tema,
        on_delete=models.PROTECT,
        related_name="assuntos",
    )

    nome = models.CharField(max_length=150)

    descricao = models.TextField(
        blank=True,
        default="",
    )

    ativo = models.BooleanField(default=True)

    ordem = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = "catalogo_assunto"
        ordering = ["ordem", "nome"]

    def __str__(self):
        return self.nome


class ServicoCatalogo(CodigoAutomaticoModel):

    assunto = models.ForeignKey(
        Assunto,
        on_delete=models.PROTECT,
        related_name="servicos",
    )

    nome = models.CharField(max_length=200)

    descricao = models.TextField()

    instrucoes = models.TextField(
        blank=True,
        default="",
    )

    prazo_estimado_dias = models.PositiveIntegerField(
        null=True,
        blank=True,
    )

    formulario_config = models.JSONField(
        default=dict,
        blank=True,
    )

    versao_formulario = models.PositiveIntegerField(
        default=1,
    )

    ativo = models.BooleanField(default=True)

    ordem = models.PositiveIntegerField(default=0)

    criado_em = models.DateTimeField(
        auto_now_add=True,
    )

    atualizado_em = models.DateTimeField(
        auto_now=True,
    )

    class Meta:
        db_table = "catalogo_servicocatalogo"
        ordering = ["ordem", "nome"]

    def __str__(self):
        return self.nome
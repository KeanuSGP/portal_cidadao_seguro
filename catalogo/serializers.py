from rest_framework import serializers

from .models import ModuloPortal, Tema, Assunto, ServicoCatalogo


class ModuloPortalSerializer(serializers.ModelSerializer):
    class Meta:
        model = ModuloPortal
        fields = ["id", "codigo", "nome", "descricao", "ativo", "ordem", "criado_em", "atualizado_em"]
        read_only_fields = ["id", "codigo", "criado_em", "atualizado_em"]


class TemaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tema
        fields = ["id", "codigo", "modulo", "nome", "descricao", "ativo", "ordem"]
        read_only_fields = ["id", "codigo"]


class AssuntoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assunto
        fields = ["id", "codigo", "tema", "nome", "descricao", "ativo", "ordem"]
        read_only_fields = ["id", "codigo"]


class ServicoCatalogoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServicoCatalogo
        fields = [
            "id", "codigo", "assunto", "nome", "descricao", "instrucoes",
            "prazo_estimado_dias", "formulario_config", "versao_formulario",
            "ativo", "ordem", "criado_em", "atualizado_em",
        ]
        read_only_fields = ["id", "codigo", "criado_em", "atualizado_em"]

from rest_framework import serializers
from .models import UnidadeAtendimento, SolicitacaoZeladoria, HistoricoSolicitacao, AnexoSolicitacao
from catalogo.models import ServicoCatalogo


class UnidadeAtendimentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UnidadeAtendimento
        fields = ["id", "codigo", "nome", "descricao", "ativo", "criado_em"]
        read_only_fields = ["id", "codigo", "criado_em"]


class AnexoSolicitacaoSerializer(serializers.ModelSerializer):
    enviado_por = serializers.StringRelatedField(read_only=True)
    class Meta:
        model = AnexoSolicitacao
        fields = ["id", "arquivo", "nome_original", "tipo_conteudo", "tamanho_bytes", "enviado_por", "criado_em"]
        read_only_fields = ["id", "nome_original", "tipo_conteudo", "tamanho_bytes", "enviado_por", "criado_em"]

    def create(self, validated_data):
        arquivo = validated_data["arquivo"]
        request = self.context["request"]
        validated_data.update({
            "enviado_por": request.user,
            "nome_original": arquivo.name[:255],
            "tipo_conteudo": getattr(arquivo, "content_type", "") or "",
            "tamanho_bytes": arquivo.size,
        })
        return super().create(validated_data)


class HistoricoSolicitacaoSerializer(serializers.ModelSerializer):
    ator = serializers.StringRelatedField(read_only=True)
    class Meta:
        model = HistoricoSolicitacao
        fields = ["id", "acao", "ator", "status_anterior", "status_novo", "unidade_origem", "unidade_destino", "responsavel_anterior", "responsavel_novo", "comentario", "criado_em"]
        read_only_fields = fields


class SolicitacaoLeituraSerializer(serializers.ModelSerializer):
    solicitante = serializers.StringRelatedField(read_only=True)
    responsavel = serializers.StringRelatedField(read_only=True)
    servico_nome = serializers.CharField(source="servico.nome", read_only=True)
    unidade_nome = serializers.CharField(source="unidade_atual.nome", read_only=True)
    class Meta:
        model = SolicitacaoZeladoria
        fields = ["id", "protocolo", "solicitante", "responsavel", "servico", "servico_nome", "unidade_atual", "unidade_nome", "descricao", "respostas_adicionais", "formulario_versao", "status", "logradouro", "numero", "complemento", "bairro", "cep", "ponto_referencia", "latitude", "longitude", "criado_em", "atualizado_em"]
        read_only_fields = fields


class SolicitacaoCriacaoSerializer(serializers.ModelSerializer):
    class Meta:
        model = SolicitacaoZeladoria
        fields = ["id", "protocolo", "servico", "descricao", "respostas_adicionais", "formulario_versao", "logradouro", "numero", "complemento", "bairro", "cep", "ponto_referencia", "latitude", "longitude", "criado_em", "status"]
        read_only_fields = ["id", "protocolo", "criado_em", "status"]

    def validate_servico(self, value):
        if not value.ativo:
            raise serializers.ValidationError("Este serviço não está disponível para solicitações.")
        if not value.assunto.ativo or not value.assunto.tema.ativo or not value.assunto.tema.modulo.ativo:
            raise serializers.ValidationError("Este serviço está indisponível no momento.")
        return value

    def validate_cep(self, value):
        value = value.replace("-", "").strip()
        if value and (len(value) != 8 or not value.isdigit()):
            raise serializers.ValidationError("Informe um CEP com 8 dígitos.")
        return value

    def validate(self, attrs):
        lat, lon = attrs.get("latitude"), attrs.get("longitude")
        if (lat is None) != (lon is None):
            raise serializers.ValidationError("Informe latitude e longitude juntas.")
        if lat is not None and not (-90 <= lat <= 90):
            raise serializers.ValidationError({"latitude": "Latitude deve estar entre -90 e 90."})
        if lon is not None and not (-180 <= lon <= 180):
            raise serializers.ValidationError({"longitude": "Longitude deve estar entre -180 e 180."})
        return attrs


class SolicitacaoAtualizacaoSerializer(serializers.ModelSerializer):
    class Meta:
        model = SolicitacaoZeladoria
        fields = ["descricao", "respostas_adicionais", "unidade_atual", "responsavel"]

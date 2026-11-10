
from django.test import TestCase
from django.db import IntegrityError, transaction

from zeladoria.models import UnidadeAtendimento, UnidadeServico
from catalogo.models import (
    ModuloPortal,
    Tema,
    Assunto,
    ServicoCatalogo,
)

from unittest.mock import patch

from django.contrib.auth import get_user_model
from rest_framework.test import APIClient

from zeladoria.models import SolicitacaoZeladoria, HistoricoSolicitacao


class UnidadeServicoTestCase(TestCase):

    def setUp(self):
        # Cria a estrutura necessária do catálogo
        modulo = ModuloPortal.objects.create(
            nome="Zeladoria Urbana"
        )

        tema = Tema.objects.create(
            modulo=modulo,
            nome="Vias públicas"
        )

        assunto = Assunto.objects.create(
            tema=tema,
            nome="Conservação de vias"
        )

        self.servico = ServicoCatalogo.objects.create(
            assunto=assunto,
            nome="Reparo de buraco na pista",
            descricao="Solicitação de reparo de buracos."
        )

        self.unidade = UnidadeAtendimento.objects.create(
            nome="Regional Centro"
        )

    def test_criar_vinculo_unidade_servico(self):
        vinculo = UnidadeServico.objects.create(
            unidade=self.unidade,
            servico=self.servico,
            prazo_atendimento_dias=10,
            ativo=True
        )

        self.assertEqual(UnidadeServico.objects.count(), 1)
        self.assertEqual(vinculo.unidade, self.unidade)
        self.assertEqual(vinculo.servico, self.servico)

    def test_consultar_servicos_de_uma_unidade(self):
        UnidadeServico.objects.create(
            unidade=self.unidade,
            servico=self.servico
        )

        self.assertTrue(
            self.unidade.servicos.filter(
                id=self.servico.id
            ).exists()
        )

    def test_consultar_unidades_de_um_servico(self):
        UnidadeServico.objects.create(
            unidade=self.unidade,
            servico=self.servico
        )

        self.assertTrue(
            self.servico.unidades_atendimento.filter(
                id=self.unidade.id
            ).exists()
        )

    def test_vinculo_armazena_atributos_proprios(self):
        UnidadeServico.objects.create(
            unidade=self.unidade,
            servico=self.servico,
            prazo_atendimento_dias=15,
            ativo=False
        )

        vinculo = UnidadeServico.objects.get(
            unidade=self.unidade,
            servico=self.servico
        )

        self.assertEqual(vinculo.prazo_atendimento_dias, 15)
        self.assertFalse(vinculo.ativo)

    def test_impedir_vinculos_duplicados(self):
        UnidadeServico.objects.create(
            unidade=self.unidade,
            servico=self.servico
        )

        with self.assertRaises(IntegrityError):
            with transaction.atomic():
                UnidadeServico.objects.create(
                    unidade=self.unidade,
                    servico=self.servico
                )


class SolicitacaoAtomicidadeTestCase(TestCase):

    def setUp(self):
        modulo = ModuloPortal.objects.create(
            nome="Zeladoria Urbana"
        )

        tema = Tema.objects.create(
            modulo=modulo,
            nome="Vias públicas"
        )

        assunto = Assunto.objects.create(
            tema=tema,
            nome="Conservação de vias"
        )

        self.servico = ServicoCatalogo.objects.create(
            assunto=assunto,
            nome="Reparo de buraco na pista",
            descricao="Solicitação de reparo de buracos."
        )

        Usuario = get_user_model()

        self.usuario = Usuario.objects.create_user(
            email="teste.atomicidade@example.com",
            password="senha-teste-123"
        )

        self.client = APIClient()
        self.client.force_authenticate(user=self.usuario)

        self.url = "/api/zeladoria/solicitacoes/"

        self.payload = {
            "servico": self.servico.id,
            "descricao": "Buraco na via pública.",
            "respostas_adicionais": {
                "gravidade": "alta"
            },
            "logradouro": "Rua de teste",
            "numero": "100",
            "bairro": "Centro",
            "cep": "20000000"
        }

    def test_criacao_registra_solicitacao_e_historico(self):
        response = self.client.post(
            self.url,
            self.payload,
            format="json"
        )

        self.assertEqual(response.status_code, 201)

        self.assertEqual(
            SolicitacaoZeladoria.objects.count(),
            1
        )

        self.assertEqual(
            HistoricoSolicitacao.objects.count(),
            1
        )

    def test_falha_no_historico_reverte_criacao_da_solicitacao(self):
        with patch(
            "zeladoria.views.registrar_criacao",
            side_effect=RuntimeError("Falha simulada no histórico.")
        ):
            with self.assertRaises(RuntimeError):
                self.client.post(
                    self.url,
                    self.payload,
                    format="json"
                )

        self.assertEqual(
            SolicitacaoZeladoria.objects.count(),
            0
        )

        self.assertEqual(
            HistoricoSolicitacao.objects.count(),
            0
        )
        

    def test_impedir_cancelamento_de_solicitacao_concluida(self):
        solicitacao = SolicitacaoZeladoria.objects.create(
            solicitante=self.usuario,
            servico=self.servico,
            descricao="Solicitação já concluída.",
            status=SolicitacaoZeladoria.Status.CONCLUIDA
        )

        historicos_antes = HistoricoSolicitacao.objects.filter(
            solicitacao=solicitacao
        ).count()

        response = self.client.post(
            f"{self.url}{solicitacao.id}/cancelar/",
            {},
            format="json"
        )

        solicitacao.refresh_from_db()

        self.assertEqual(response.status_code, 400)

        self.assertEqual(
            solicitacao.status,
            SolicitacaoZeladoria.Status.CONCLUIDA
        )

        self.assertEqual(
            HistoricoSolicitacao.objects.filter(
                solicitacao=solicitacao
            ).count(),
            historicos_antes
        )
        
        
    def test_filtrar_solicitacoes_por_chave_json(self):
        payload_alta = self.payload.copy()
        payload_alta["respostas_adicionais"] = {
            "gravidade": "alta"
        }

        payload_baixa = self.payload.copy()
        payload_baixa["respostas_adicionais"] = {
            "gravidade": "baixa"
        }

        payload_baixa["descricao"] = "Buraco de pequena dimensão."

        response_alta = self.client.post(
            self.url,
            payload_alta,
            format="json"
        )

        response_baixa = self.client.post(
            self.url,
            payload_baixa,
            format="json"
        )

        self.assertEqual(response_alta.status_code, 201)
        self.assertEqual(response_baixa.status_code, 201)

        response = self.client.get(
            self.url,
            {"respostas_adicionais__gravidade": "alta"}
        )

        self.assertEqual(response.status_code, 200)

        resultados = response.data["results"]

        self.assertEqual(len(resultados), 1)

        self.assertEqual(
            resultados[0]["respostas_adicionais"]["gravidade"],
            "alta"
        )



from django.db import transaction
from .models import HistoricoSolicitacao, SolicitacaoZeladoria


@transaction.atomic
def registrar_criacao(solicitacao, ator):
    HistoricoSolicitacao.objects.create(
        solicitacao=solicitacao,
        ator=ator,
        acao=HistoricoSolicitacao.Acao.CRIACAO,
        status_novo=solicitacao.status,
        comentario="Solicitação registrada.",
    )


@transaction.atomic
def cancelar_solicitacao(solicitacao, ator, comentario=""):
    if solicitacao.status not in [SolicitacaoZeladoria.Status.RECEBIDA, SolicitacaoZeladoria.Status.EM_ANALISE]:
        raise ValueError("Só é possível cancelar solicitações recebidas ou em análise.")
    anterior = solicitacao.status
    solicitacao.status = SolicitacaoZeladoria.Status.CANCELADA
    solicitacao.save(update_fields=["status", "atualizado_em"])
    HistoricoSolicitacao.objects.create(
        solicitacao=solicitacao, ator=ator,
        acao=HistoricoSolicitacao.Acao.CANCELAMENTO,
        status_anterior=anterior, status_novo=solicitacao.status,
        comentario=comentario,
    )


@transaction.atomic
def alterar_status(solicitacao, ator, novo_status, comentario=""):
    if novo_status not in SolicitacaoZeladoria.Status.values:
        raise ValueError("Status informado é inválido.")
    if solicitacao.status in [SolicitacaoZeladoria.Status.CANCELADA, SolicitacaoZeladoria.Status.CONCLUIDA]:
        raise ValueError("Solicitações canceladas ou concluídas não podem mudar de status.")
    anterior = solicitacao.status
    solicitacao.status = novo_status
    solicitacao.save(update_fields=["status", "atualizado_em"])
    acao = HistoricoSolicitacao.Acao.CONCLUSAO if novo_status == SolicitacaoZeladoria.Status.CONCLUIDA else HistoricoSolicitacao.Acao.ALTERACAO_STATUS
    HistoricoSolicitacao.objects.create(
        solicitacao=solicitacao, ator=ator, acao=acao,
        status_anterior=anterior, status_novo=novo_status,
        comentario=comentario,
    )

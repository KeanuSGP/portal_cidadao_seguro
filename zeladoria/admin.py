from django.contrib import admin
from .models import (
    UnidadeAtendimento,
    SolicitacaoZeladoria,
    HistoricoSolicitacao,
    AnexoSolicitacao,
)


admin.site.register(UnidadeAtendimento)
admin.site.register(SolicitacaoZeladoria)
admin.site.register(HistoricoSolicitacao)
admin.site.register(AnexoSolicitacao)
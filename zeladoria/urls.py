from rest_framework.routers import DefaultRouter
from .views import (
    UnidadeAtendimentoViewSet,
    SolicitacaoViewSet,
)

router = DefaultRouter()

router.register("unidades", UnidadeAtendimentoViewSet, basename="unidade")
router.register("solicitacoes", SolicitacaoViewSet, basename="solicitacao")

urlpatterns = router.urls
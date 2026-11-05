from rest_framework.routers import DefaultRouter

from rest_framework.routers import DefaultRouter

app_name = "catalogo"

router = DefaultRouter()

from .views import ModuloPortalViewSet  # mantenha seus imports reais

from .views import (
    ModuloPortalViewSet,
    TemaViewSet,
    AssuntoViewSet,
    ServicoCatalogoViewSet,
)

router.register("modulos", ModuloPortalViewSet, basename="modulo")
router.register("temas", TemaViewSet, basename="tema")
router.register("assuntos", AssuntoViewSet, basename="assunto")
router.register("servicos", ServicoCatalogoViewSet, basename="servico")

urlpatterns = router.urls

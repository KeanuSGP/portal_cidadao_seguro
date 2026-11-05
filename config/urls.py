from django.contrib import admin
from django.urls import path, include

from config.views import api_root

from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularSwaggerView,
    SpectacularRedocView,
)

urlpatterns = [
    path("admin/", admin.site.urls),

    # Página inicial agregadora
    path("api/", api_root, name="api-root"),

    # Aplicações
    path(
        "api/catalogo/",
        include("catalogo.urls", namespace="catalogo"),
    ),
    path("api/zeladoria/", include("zeladoria.urls")),
    path("api/accounts/", include("accounts.urls")),

    # Documentação
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),
    path(
        "swagger/",
        SpectacularSwaggerView.as_view(url_name="schema"),
        name="swagger-ui",
    ),
]
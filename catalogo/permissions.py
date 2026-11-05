from rest_framework.permissions import BasePermission, SAFE_METHODS


class LeituraPublicaEscritaAdmin(BasePermission):
    """Permite consulta pública ao catálogo; alterações somente a administradores."""

    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        return bool(request.user and request.user.is_authenticated and request.user.is_staff)

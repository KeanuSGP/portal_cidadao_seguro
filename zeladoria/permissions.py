from rest_framework.permissions import BasePermission, SAFE_METHODS


def is_admin(user):
    return user.is_superuser or user.groups.filter(name="Administrador").exists()


def is_servidor(user):
    return user.groups.filter(name="Servidor").exists()


class PodeConsultarUnidades(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user and request.user.is_authenticated)


class PermissaoSolicitacao(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user and request.user.is_authenticated)

    def has_object_permission(self, request, view, obj):
        user = request.user
        if is_admin(user) or is_servidor(user):
            return True
        return obj.solicitante_id == user.id

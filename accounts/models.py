from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.db import models


class UsuarioManager(BaseUserManager):
    use_in_migrations = True

    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("O e-mail é obrigatório.")

        email = self.normalize_email(email)

        usuario = self.model(
            email=email,
            **extra_fields
        )

        usuario.set_password(password)
        usuario.save(using=self._db)

        return usuario

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_active", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("is_staff deve ser True.")

        if extra_fields.get("is_superuser") is not True:
            raise ValueError("is_superuser deve ser True.")

        return self.create_user(email, password, **extra_fields)


class Usuario(AbstractUser):
    username = None

    email = models.EmailField(unique=True)

    cpf = models.CharField(
        max_length=11,
        unique=True,
        null=True,
        blank=True
    )

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects = UsuarioManager()

    def __str__(self):
        return self.email
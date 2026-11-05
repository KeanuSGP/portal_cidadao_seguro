import os
import sys
from pathlib import Path

# Adiciona a raiz do projeto ao caminho de importação
BASE_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(BASE_DIR))

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")

import django
django.setup()

from django.contrib.auth import get_user_model

Usuario = get_user_model()

usuarios = [
    {
        "email": "maria.silva@teste.com",
        "first_name": "Maria",
        "last_name": "Silva",
        "cpf": "11111111111",
        "password": "Teste@123",
    },
    {
        "email": "joao.santos@teste.com",
        "first_name": "João",
        "last_name": "Santos",
        "cpf": "22222222222",
        "password": "Teste@123",
    },
    {
        "email": "ana.oliveira@teste.com",
        "first_name": "Ana",
        "last_name": "Oliveira",
        "cpf": "33333333333",
        "password": "Teste@123",
    },
    {
        "email": "pedro.costa@teste.com",
        "first_name": "Pedro",
        "last_name": "Costa",
        "cpf": "44444444444",
        "password": "Teste@123",
    },
    {
        "email": "lucas.mendes@teste.com",
        "first_name": "Lucas",
        "last_name": "Mendes",
        "cpf": "55555555555",
        "password": "Teste@123",
    },
]

for dados in usuarios:
    dados = dados.copy()

    email = dados.pop("email")
    senha = dados.pop("password")

    usuario, criado = Usuario.objects.get_or_create(
        email=email,
        defaults=dados,
    )

    if criado:
        usuario.set_password(senha)
        usuario.save()
        print(f"Usuário criado: {email}")
    else:
        print(f"Usuário já existente: {email}")

print("Finalizado.")
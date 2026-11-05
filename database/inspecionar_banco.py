
import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "db.sqlite3"

TABELAS = [
    "accounts_usuario",
    "zeladoria_unidadeatendimento",
    "catalogo_moduloportal",
    "catalogo_tema",
    "catalogo_assunto",
    "catalogo_servicocatalogo",
    "zeladoria_solicitacaozeladoria",
    "zeladoria_historicosolicitacao",
    "zeladoria_anexosolicitacao",
]

with sqlite3.connect(DB_PATH) as conn:
    cursor = conn.cursor()

    for tabela in TABELAS:
        print(f"\n{'=' * 60}")
        print(f"TABELA: {tabela}")
        print("=" * 60)

        cursor.execute(f'PRAGMA table_info("{tabela}")')

        for coluna in cursor.fetchall():
            cid, nome, tipo, notnull, default, pk = coluna
            print(
                f"Coluna: {nome} | Tipo: {tipo} | "
                f"Obrigatório: {bool(notnull)} | PK: {pk} | "
                f"Default: {default}"
            )

        cursor.execute(f'PRAGMA foreign_key_list("{tabela}")')

        print("\nForeign Keys:")
        for fk in cursor.fetchall():
            print(fk)

        cursor.execute(f'PRAGMA index_list("{tabela}")')

        print("\nÍndices:")
        for indice in cursor.fetchall():
            print(indice)

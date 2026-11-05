INSERT INTO zeladoria_unidadeatendimento
    (codigo, nome, descricao, ativo, criado_em)
SELECT
    'central-zeladoria',
    'Central de Zeladoria',
    'Unidade responsável pelo recebimento e triagem das solicitações de zeladoria urbana.',
    TRUE,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_unidadeatendimento
    WHERE codigo = 'central-zeladoria'
);

INSERT INTO zeladoria_unidadeatendimento
    (codigo, nome, descricao, ativo, criado_em)
SELECT
    'regional-centro',
    'Regional Centro',
    'Unidade responsável pelo atendimento das solicitações na região central.',
    TRUE,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_unidadeatendimento
    WHERE codigo = 'regional-centro'
);

INSERT INTO zeladoria_unidadeatendimento
    (codigo, nome, descricao, ativo, criado_em)
SELECT
    'regional-zona-sul',
    'Regional Zona Sul',
    'Unidade responsável pelo atendimento das solicitações na Zona Sul.',
    TRUE,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_unidadeatendimento
    WHERE codigo = 'regional-zona-sul'
);

INSERT INTO zeladoria_unidadeatendimento
    (codigo, nome, descricao, ativo, criado_em)
SELECT
    'regional-zona-norte',
    'Regional Zona Norte',
    'Unidade responsável pelo atendimento das solicitações na Zona Norte.',
    TRUE,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_unidadeatendimento
    WHERE codigo = 'regional-zona-norte'
);

INSERT INTO zeladoria_unidadeatendimento
    (codigo, nome, descricao, ativo, criado_em)
SELECT
    'regional-zona-oeste',
    'Regional Zona Oeste',
    'Unidade responsável pelo atendimento das solicitações na Zona Oeste.',
    TRUE,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_unidadeatendimento
    WHERE codigo = 'regional-zona-oeste'
);
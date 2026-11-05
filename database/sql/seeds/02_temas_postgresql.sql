-- =====================================================
-- TEMAS: ZELADORIA URBANA
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'zeladoria-vias-publicas',
    'Vias Públicas',
    'Problemas relacionados à conservação e manutenção de vias públicas.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Zeladoria Urbana'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'zeladoria-vias-publicas'
);

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'zeladoria-calcadas',
    'Calçadas e Passeios',
    'Solicitações relacionadas à conservação e acessibilidade de calçadas.',
    TRUE,
    2
FROM catalogo_moduloportal m
WHERE m.nome = 'Zeladoria Urbana'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'zeladoria-calcadas'
);

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'zeladoria-mobiliario-urbano',
    'Mobiliário Urbano',
    'Problemas relacionados a equipamentos e estruturas de uso público.',
    TRUE,
    3
FROM catalogo_moduloportal m
WHERE m.nome = 'Zeladoria Urbana'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'zeladoria-mobiliario-urbano'
);

-- =====================================================
-- TEMAS: ILUMINAÇÃO PÚBLICA
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'iluminacao-lampadas',
    'Lâmpadas e Luminárias',
    'Solicitações relacionadas ao funcionamento de lâmpadas e luminárias públicas.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Iluminação Pública'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'iluminacao-lampadas'
);

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'iluminacao-postes',
    'Postes e Estruturas',
    'Problemas estruturais envolvendo postes e equipamentos de iluminação.',
    TRUE,
    2
FROM catalogo_moduloportal m
WHERE m.nome = 'Iluminação Pública'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'iluminacao-postes'
);

-- =====================================================
-- TEMAS: LIMPEZA URBANA
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'limpeza-coleta',
    'Coleta de Resíduos',
    'Solicitações relacionadas à coleta regular e remoção de resíduos.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Limpeza Urbana'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'limpeza-coleta'
);

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'limpeza-vias',
    'Limpeza de Vias e Espaços Públicos',
    'Problemas relacionados à limpeza de ruas, praças e espaços públicos.',
    TRUE,
    2
FROM catalogo_moduloportal m
WHERE m.nome = 'Limpeza Urbana'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'limpeza-vias'
);

-- =====================================================
-- TEMAS: MEIO AMBIENTE
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'meio-ambiente-arborizacao',
    'Arborização Urbana',
    'Solicitações relacionadas à manutenção e conservação de árvores.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Meio Ambiente'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'meio-ambiente-arborizacao'
);

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'meio-ambiente-fauna',
    'Fauna Urbana',
    'Ocorrências envolvendo animais em áreas urbanas.',
    TRUE,
    2
FROM catalogo_moduloportal m
WHERE m.nome = 'Meio Ambiente'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'meio-ambiente-fauna'
);

-- =====================================================
-- TEMAS: TRANSPORTE
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'transporte-sinalizacao',
    'Sinalização Viária',
    'Problemas relacionados à sinalização horizontal e vertical.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Transporte'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'transporte-sinalizacao'
);

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'transporte-semaforos',
    'Semáforos',
    'Ocorrências relacionadas ao funcionamento de semáforos.',
    TRUE,
    2
FROM catalogo_moduloportal m
WHERE m.nome = 'Transporte'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'transporte-semaforos'
);

-- =====================================================
-- TEMAS: SAÚDE
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'saude-unidades',
    'Unidades de Saúde',
    'Solicitações relacionadas à infraestrutura das unidades de saúde.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Saúde'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'saude-unidades'
);

-- =====================================================
-- TEMAS: ORDENAMENTO URBANO
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'ordenamento-ocupacao',
    'Ocupação Irregular',
    'Ocorrências relacionadas à ocupação irregular de espaços públicos.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Ordenamento Urbano'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'ordenamento-ocupacao'
);

-- =====================================================
-- TEMAS: DEFESA CIVIL
-- =====================================================

INSERT INTO catalogo_tema
    (modulo_id, codigo, nome, descricao, ativo, ordem)
SELECT
    m.id,
    'defesa-civil-riscos',
    'Áreas de Risco',
    'Ocorrências relacionadas a riscos estruturais e geológicos.',
    TRUE,
    1
FROM catalogo_moduloportal m
WHERE m.nome = 'Defesa Civil'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_tema
    WHERE codigo = 'defesa-civil-riscos'
);
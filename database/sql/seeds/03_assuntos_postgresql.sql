-- =====================================================
-- ZELADORIA URBANA
-- =====================================================

-- Tema: Vias Públicas
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'vias-buracos', 'Buracos na Via',
       'Ocorrências de buracos e danos no pavimento.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'zeladoria-vias-publicas'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'vias-buracos'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'vias-pavimentacao', 'Pavimentação',
       'Problemas relacionados à conservação e recuperação do pavimento.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'zeladoria-vias-publicas'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'vias-pavimentacao'
);

-- Tema: Calçadas e Passeios
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'calcadas-danos', 'Calçada Danificada',
       'Calçadas quebradas, desniveladas ou deterioradas.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'zeladoria-calcadas'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'calcadas-danos'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'calcadas-acessibilidade', 'Acessibilidade',
       'Problemas que dificultam a circulação de pedestres.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'zeladoria-calcadas'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'calcadas-acessibilidade'
);

-- Tema: Mobiliário Urbano
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'mobiliario-bancos', 'Bancos Públicos',
       'Solicitações relacionadas a bancos instalados em espaços públicos.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'zeladoria-mobiliario-urbano'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'mobiliario-bancos'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'mobiliario-equipamentos', 'Equipamentos Públicos',
       'Problemas em equipamentos e estruturas de uso coletivo.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'zeladoria-mobiliario-urbano'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'mobiliario-equipamentos'
);

-- =====================================================
-- ILUMINAÇÃO PÚBLICA
-- =====================================================

-- Tema: Lâmpadas e Luminárias
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'lampadas-apagadas', 'Lâmpada Apagada',
       'Pontos de iluminação pública que não estão funcionando.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'iluminacao-lampadas'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'lampadas-apagadas'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'lampadas-intermitentes', 'Lâmpada Intermitente',
       'Luminárias que apresentam funcionamento irregular.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'iluminacao-lampadas'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'lampadas-intermitentes'
);

-- Tema: Postes e Estruturas
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'postes-danificados', 'Poste Danificado',
       'Postes de iluminação com danos estruturais aparentes.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'iluminacao-postes'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'postes-danificados'
);

-- =====================================================
-- LIMPEZA URBANA
-- =====================================================

-- Tema: Coleta de Resíduos
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'coleta-nao-realizada', 'Coleta Não Realizada',
       'Coleta regular de resíduos que não ocorreu conforme previsto.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'limpeza-coleta'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'coleta-nao-realizada'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'coleta-entulho', 'Remoção de Entulho',
       'Solicitação de remoção de entulho descartado em áreas públicas.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'limpeza-coleta'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'coleta-entulho'
);

-- Tema: Limpeza de Vias e Espaços Públicos
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'limpeza-ruas', 'Limpeza de Ruas',
       'Solicitações de limpeza e varrição de vias públicas.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'limpeza-vias'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'limpeza-ruas'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'limpeza-pracas', 'Limpeza de Praças',
       'Solicitações de limpeza e conservação de praças públicas.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'limpeza-vias'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'limpeza-pracas'
);

-- =====================================================
-- MEIO AMBIENTE
-- =====================================================

-- Tema: Arborização Urbana
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'arborizacao-poda', 'Poda de Árvore',
       'Solicitações de poda de árvores em espaços públicos.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'meio-ambiente-arborizacao'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'arborizacao-poda'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'arborizacao-queda', 'Árvore Caída ou com Risco',
       'Ocorrências envolvendo árvores caídas ou com risco de queda.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'meio-ambiente-arborizacao'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'arborizacao-queda'
);

-- Tema: Fauna Urbana
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'fauna-animal-ferido', 'Animal Ferido',
       'Ocorrências envolvendo animais feridos em áreas públicas.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'meio-ambiente-fauna'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'fauna-animal-ferido'
);

-- =====================================================
-- TRANSPORTE
-- =====================================================

-- Tema: Sinalização Viária
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'sinalizacao-vertical', 'Placas de Sinalização',
       'Placas ausentes, danificadas ou com baixa visibilidade.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'transporte-sinalizacao'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'sinalizacao-vertical'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'sinalizacao-horizontal', 'Sinalização de Solo',
       'Faixas, marcações e pinturas viárias desgastadas ou ausentes.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'transporte-sinalizacao'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'sinalizacao-horizontal'
);

-- Tema: Semáforos
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'semaforos-inoperantes', 'Semáforo Inoperante',
       'Semáforos desligados ou sem funcionamento.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'transporte-semaforos'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'semaforos-inoperantes'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'semaforos-defeito', 'Semáforo com Defeito',
       'Semáforos com funcionamento irregular ou sinalização defeituosa.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'transporte-semaforos'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'semaforos-defeito'
);

-- =====================================================
-- SAÚDE
-- =====================================================

-- Tema: Unidades de Saúde
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'saude-infraestrutura', 'Infraestrutura',
       'Problemas estruturais nas instalações de unidades de saúde.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'saude-unidades'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'saude-infraestrutura'
);

-- =====================================================
-- ORDENAMENTO URBANO
-- =====================================================

-- Tema: Ocupação Irregular
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'ocupacao-calcada', 'Ocupação de Calçada',
       'Ocupação irregular de calçadas e áreas destinadas aos pedestres.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'ordenamento-ocupacao'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'ocupacao-calcada'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'ocupacao-area-publica', 'Ocupação de Área Pública',
       'Ocupação irregular de praças, ruas e outros espaços públicos.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'ordenamento-ocupacao'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'ocupacao-area-publica'
);

-- =====================================================
-- DEFESA CIVIL
-- =====================================================

-- Tema: Áreas de Risco
INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'risco-deslizamento', 'Risco de Deslizamento',
       'Ocorrências com indícios de instabilidade de encostas ou terrenos.',
       TRUE, 1
FROM catalogo_tema t
WHERE t.codigo = 'defesa-civil-riscos'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'risco-deslizamento'
);

INSERT INTO catalogo_assunto
    (tema_id, codigo, nome, descricao, ativo, ordem)
SELECT t.id, 'risco-estrutural', 'Risco Estrutural',
       'Ocorrências envolvendo possíveis riscos estruturais em edificações.',
       TRUE, 2
FROM catalogo_tema t
WHERE t.codigo = 'defesa-civil-riscos'
AND NOT EXISTS (
    SELECT 1 FROM catalogo_assunto WHERE codigo = 'risco-estrutural'
);
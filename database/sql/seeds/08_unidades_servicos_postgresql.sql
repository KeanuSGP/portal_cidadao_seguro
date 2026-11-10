-- ============================================================
-- Seed: relacionamento entre unidades de atendimento e serviços
-- Portal Cidadao Seguro
--
-- Regra adotada:
--   - A Central de Zeladoria atua no recebimento e na triagem.
--   - As quatro regionais oferecem os servicos do catalogo.
--   - O prazo especifico da unidade fica NULL, pois nao foi
--     definida uma variacao de prazo por regional.
--
-- O script pode ser executado mais de uma vez sem duplicar vinculos.
-- ============================================================

BEGIN;

INSERT INTO zeladoria_unidadeservico (
    unidade_id,
    servico_id,
    prazo_atendimento_dias,
    ativo
)
SELECT
    unidade.id,
    servico.id,
    NULL,
    TRUE
FROM zeladoria_unidadeatendimento AS unidade
CROSS JOIN catalogo_servicocatalogo AS servico
WHERE unidade.codigo IN (
    'regional-centro',
    'regional-zona-norte',
    'regional-zona-sul',
    'regional-zona-oeste'
)
AND NOT EXISTS (
    SELECT 1
    FROM zeladoria_unidadeservico AS vinculo
    WHERE vinculo.unidade_id = unidade.id
      AND vinculo.servico_id = servico.id
);

COMMIT;

-- Conferencia: quantidade de vinculos por unidade.
SELECT
    unidade.nome,
    COUNT(vinculo.id) AS total_servicos
FROM zeladoria_unidadeatendimento AS unidade
LEFT JOIN zeladoria_unidadeservico AS vinculo
    ON vinculo.unidade_id = unidade.id
GROUP BY unidade.id, unidade.nome
ORDER BY unidade.nome;

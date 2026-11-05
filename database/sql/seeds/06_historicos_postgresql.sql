
WITH eventos (
    protocolo,
    acao,
    status_anterior,
    status_novo,
    comentario,
    unidade_codigo,
    dias_atras
) AS (
    VALUES

    -- SOLICITAÇÃO 01: RECEBIDA
    (
        '00000000000040008000000000000001',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-centro',
        7
    ),

    -- SOLICITAÇÃO 02: EM ANÁLISE
    (
        '00000000000040008000000000000002',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-sul',
        6
    ),
    (
        '00000000000040008000000000000002',
        'ENCAMINHADA_ANALISE',
        'RECEBIDA',
        'EM_ANALISE',
        'Solicitação encaminhada para análise da equipe responsável.',
        'regional-zona-sul',
        5
    ),

    -- SOLICITAÇÃO 03: EM ATENDIMENTO
    (
        '00000000000040008000000000000003',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-sul',
        10
    ),
    (
        '00000000000040008000000000000003',
        'ENCAMINHADA_ANALISE',
        'RECEBIDA',
        'EM_ANALISE',
        'Solicitação encaminhada para análise.',
        'regional-zona-sul',
        9
    ),
    (
        '00000000000040008000000000000003',
        'INICIO_ATENDIMENTO',
        'EM_ANALISE',
        'EM_ATENDIMENTO',
        'Equipe iniciou o atendimento da solicitação.',
        'regional-zona-sul',
        8
    ),

    -- SOLICITAÇÃO 04: PENDENTE
    (
        '00000000000040008000000000000004',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-norte',
        8
    ),
    (
        '00000000000040008000000000000004',
        'ENCAMINHADA_ANALISE',
        'RECEBIDA',
        'EM_ANALISE',
        'Solicitação encaminhada para análise.',
        'regional-zona-norte',
        7
    ),
    (
        '00000000000040008000000000000004',
        'INICIO_ATENDIMENTO',
        'EM_ANALISE',
        'EM_ATENDIMENTO',
        'Equipe iniciou a avaliação do ponto de iluminação.',
        'regional-zona-norte',
        6
    ),
    (
        '00000000000040008000000000000004',
        'SOLICITACAO_PENDENTE',
        'EM_ATENDIMENTO',
        'PENDENTE',
        'Atendimento pendente de avaliação ou recurso adicional.',
        'regional-zona-norte',
        5
    ),

    -- SOLICITAÇÃO 05: CONCLUÍDA
    (
        '00000000000040008000000000000005',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-centro',
        15
    ),
    (
        '00000000000040008000000000000005',
        'ENCAMINHADA_ANALISE',
        'RECEBIDA',
        'EM_ANALISE',
        'Solicitação encaminhada para análise.',
        'regional-centro',
        14
    ),
    (
        '00000000000040008000000000000005',
        'INICIO_ATENDIMENTO',
        'EM_ANALISE',
        'EM_ATENDIMENTO',
        'Equipe iniciou o atendimento da ocorrência.',
        'regional-centro',
        12
    ),
    (
        '00000000000040008000000000000005',
        'SOLICITACAO_CONCLUIDA',
        'EM_ATENDIMENTO',
        'CONCLUIDA',
        'Serviço executado e solicitação concluída.',
        'regional-centro',
        10
    ),

    -- SOLICITAÇÃO 06: RECEBIDA
    (
        '00000000000040008000000000000006',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-oeste',
        3
    ),

    -- SOLICITAÇÃO 07: EM ANÁLISE
    (
        '00000000000040008000000000000007',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-sul',
        5
    ),
    (
        '00000000000040008000000000000007',
        'ENCAMINHADA_ANALISE',
        'RECEBIDA',
        'EM_ANALISE',
        'Solicitação encaminhada para avaliação técnica.',
        'regional-zona-sul',
        4
    ),

    -- SOLICITAÇÃO 08: CANCELADA
    (
        '00000000000040008000000000000008',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-centro',
        9
    ),
    (
        '00000000000040008000000000000008',
        'SOLICITACAO_CANCELADA',
        'RECEBIDA',
        'CANCELADA',
        'Solicitação cancelada.',
        'regional-centro',
        8
    ),

    -- SOLICITAÇÃO 09: EM ATENDIMENTO
    (
        '00000000000040008000000000000009',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-norte',
        6
    ),
    (
        '00000000000040008000000000000009',
        'ENCAMINHADA_ANALISE',
        'RECEBIDA',
        'EM_ANALISE',
        'Solicitação encaminhada para análise.',
        'regional-zona-norte',
        5
    ),
    (
        '00000000000040008000000000000009',
        'INICIO_ATENDIMENTO',
        'EM_ANALISE',
        'EM_ATENDIMENTO',
        'Equipe iniciou a avaliação do semáforo.',
        'regional-zona-norte',
        4
    ),

    -- SOLICITAÇÃO 10: RECEBIDA
    (
        '00000000000040008000000000000010',
        'SOLICITACAO_CRIADA',
        '',
        'RECEBIDA',
        'Solicitação registrada pelo cidadão.',
        'regional-zona-oeste',
        2
    )
)

INSERT INTO zeladoria_historicosolicitacao (
    solicitacao_id,
    acao,
    status_anterior,
    status_novo,
    comentario,
    criado_em,
    ator_id,
    responsavel_anterior_id,
    responsavel_novo_id,
    unidade_origem_id,
    unidade_destino_id
)
SELECT
    s.id,
    e.acao,
    e.status_anterior,
    e.status_novo,
    e.comentario,
    CURRENT_TIMESTAMP - (e.dias_atras * INTERVAL '1 day'),
    NULL,
    NULL,
    NULL,
    CASE
        WHEN e.status_anterior = '' THEN NULL
        ELSE u.id
    END,
    u.id
FROM eventos e
INNER JOIN zeladoria_solicitacaozeladoria s
    ON s.protocolo = e.protocolo::uuid
INNER JOIN zeladoria_unidadeatendimento u
    ON u.codigo = e.unidade_codigo
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_historicosolicitacao h
    WHERE h.solicitacao_id = s.id
      AND h.acao = e.acao
      AND h.status_novo = e.status_novo
);

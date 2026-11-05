
WITH anexos (
    protocolo,
    email,
    arquivo,
    nome_original,
    tipo_conteudo,
    tamanho_bytes,
    dias_atras
) AS (
    VALUES

    (
        '00000000000040008000000000000001',
        'maria.silva@teste.com',
        'solicitacoes/mock/buraco-pista-01.jpg',
        'buraco_pista.jpg',
        'image/jpeg',
        245760,
        7
    ),
    (
        '00000000000040008000000000000002',
        'joao.santos@teste.com',
        'solicitacoes/mock/calcada-danificada-01.jpg',
        'calcada_danificada.jpg',
        'image/jpeg',
        312450,
        6
    ),
    (
        '00000000000040008000000000000002',
        'joao.santos@teste.com',
        'solicitacoes/mock/calcada-danificada-02.jpg',
        'detalhe_calcada.jpg',
        'image/jpeg',
        198320,
        6
    ),
    (
        '00000000000040008000000000000003',
        'ana.oliveira@teste.com',
        'solicitacoes/mock/banco-publico.jpg',
        'banco_publico.jpg',
        'image/jpeg',
        421800,
        10
    ),
    (
        '00000000000040008000000000000004',
        'pedro.costa@teste.com',
        'solicitacoes/mock/poste-iluminacao.jpg',
        'poste_iluminacao.jpg',
        'image/jpeg',
        287650,
        8
    ),
    (
        '00000000000040008000000000000006',
        'maria.silva@teste.com',
        'solicitacoes/mock/entulho.jpg',
        'entulho_acumulado.jpg',
        'image/jpeg',
        356700,
        3
    ),
    (
        '00000000000040008000000000000007',
        'joao.santos@teste.com',
        'solicitacoes/mock/arvore.jpg',
        'arvore_proxima_rede.jpg',
        'image/jpeg',
        410200,
        5
    ),
    (
        '00000000000040008000000000000008',
        'ana.oliveira@teste.com',
        'solicitacoes/mock/placa-danificada.jpg',
        'placa_danificada.jpg',
        'image/jpeg',
        193500,
        9
    ),
    (
        '00000000000040008000000000000009',
        'pedro.costa@teste.com',
        'solicitacoes/mock/semaforo.jpg',
        'semaforo_inoperante.jpg',
        'image/jpeg',
        328400,
        6
    ),
    (
        '00000000000040008000000000000010',
        'lucas.mendes@teste.com',
        'solicitacoes/mock/vazamento.jpg',
        'vazamento_unidade.jpg',
        'image/jpeg',
        276300,
        2
    )
)

INSERT INTO zeladoria_anexosolicitacao (
    solicitacao_id,
    arquivo,
    nome_original,
    tipo_conteudo,
    tamanho_bytes,
    criado_em,
    enviado_por_id
)
SELECT
    s.id,
    a.arquivo,
    a.nome_original,
    a.tipo_conteudo,
    a.tamanho_bytes,
    CURRENT_TIMESTAMP - (a.dias_atras * INTERVAL '1 day'),
    u.id
FROM anexos a
INNER JOIN zeladoria_solicitacaozeladoria s
    ON s.protocolo = a.protocolo::uuid
INNER JOIN accounts_usuario u
    ON u.email = a.email
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_anexosolicitacao existente
    WHERE existente.solicitacao_id = s.id
      AND existente.nome_original = a.nome_original
);

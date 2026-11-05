
WITH solicitacoes (
    protocolo,
    solicitante_email,
    servico_codigo,
    unidade_codigo,
    descricao,
    respostas_adicionais,
    formulario_versao,
    status,
    logradouro,
    numero,
    complemento,
    bairro,
    cep,
    ponto_referencia,
    latitude,
    longitude
) AS (
    VALUES
    (
        '00000000000040008000000000000001',
        'maria.silva@teste.com',
        'reparo-buraco-pista',
        'regional-centro',
        'Buraco de grandes dimensões próximo ao cruzamento.',
        '{"profundidade_aproximada":20,"risco_acidentes":"Sim","descricao_complementar":"Buraco dificulta a passagem de veículos."}',
        1, 'RECEBIDA',
        'Rua da Assembleia', '100', '',
        'Centro', '20011-000',
        'Próximo ao cruzamento',
        -22.9044, -43.1760
    ),
    (
        '00000000000040008000000000000002',
        'joao.santos@teste.com',
        'reparo-calcada',
        'regional-zona-sul',
        'Calçada com diversas pedras soltas.',
        '{"tipo_dano":"Piso quebrado","interdita_passagem":"Parcialmente","descricao_complementar":"Há dificuldade para circulação de cadeirantes."}',
        1, 'EM_ANALISE',
        'Rua Voluntários da Pátria', '250', '',
        'Botafogo', '22270-010',
        'Próximo à estação de metrô',
        -22.9519, -43.1822
    ),
    (
        '00000000000040008000000000000003',
        'ana.oliveira@teste.com',
        'manutencao-banco-publico',
        'regional-zona-sul',
        'Banco de praça apresenta estrutura quebrada.',
        '{"tipo_problema":"Banco quebrado","descricao_complementar":"Uma das partes do assento está solta."}',
        1, 'EM_ATENDIMENTO',
        'Rua Jardim Botânico', '500', '',
        'Jardim Botânico', '22461-000',
        'Praça próxima ao endereço',
        -22.9658, -43.2170
    ),
    (
        '00000000000040008000000000000004',
        'pedro.costa@teste.com',
        'reparo-lampada-apagada',
        'regional-zona-norte',
        'Poste de iluminação sem funcionamento.',
        '{"numero_poste":"RJ-1045","quantidade_lampadas":1,"periodo_problema":"Durante toda a noite"}',
        1, 'PENDENTE',
        'Rua Conde de Bonfim', '300', '',
        'Tijuca', '20520-050',
        'Em frente ao comércio',
        -22.9245, -43.2351
    ),
    (
        '00000000000040008000000000000005',
        'lucas.mendes@teste.com',
        'reclamacao-coleta-nao-realizada',
        'regional-centro',
        'Coleta de resíduos não ocorreu na data prevista.',
        '{"data_prevista":"2026-11-03","tipo_residuo":"Resíduo domiciliar","descricao_complementar":"Os resíduos continuam acumulados na calçada."}',
        1, 'CONCLUIDA',
        'Rua do Senado', '80', '',
        'Centro', '20231-005',
        'Próximo ao número 80',
        -22.9097, -43.1892
    ),
    (
        '00000000000040008000000000000006',
        'maria.silva@teste.com',
        'solicitacao-remocao-entulho',
        'regional-zona-oeste',
        'Entulho acumulado em área pública.',
        '{"tipo_entulho":"Resíduos de construção","quantidade_aproximada":"Grande"}',
        1, 'RECEBIDA',
        'Estrada do Mendanha', '1200', '',
        'Campo Grande', '23087-283',
        'Próximo à entrada do bairro',
        -22.9035, -43.5580
    ),
    (
        '00000000000040008000000000000007',
        'joao.santos@teste.com',
        'solicitacao-poda-arvore',
        'regional-zona-sul',
        'Galhos de árvore próximos à rede elétrica.',
        '{"motivo_poda":"Galhos próximos à rede elétrica","altura_aproximada":8}',
        1, 'EM_ANALISE',
        'Rua São Clemente', '150', '',
        'Botafogo', '22260-000',
        'Próximo à esquina',
        -22.9495, -43.1880
    ),
    (
        '00000000000040008000000000000008',
        'ana.oliveira@teste.com',
        'reparo-placa-sinalizacao',
        'regional-centro',
        'Placa de sinalização danificada.',
        '{"tipo_placa":"Advertência","problema":"Placa danificada"}',
        1, 'CANCELADA',
        'Avenida Presidente Vargas', '500', '',
        'Centro', '20071-004',
        'Próximo ao cruzamento',
        -22.9028, -43.1870
    ),
    (
        '00000000000040008000000000000009',
        'pedro.costa@teste.com',
        'reparo-semaforo-inoperante',
        'regional-zona-norte',
        'Semáforo desligado em cruzamento movimentado.',
        '{"tipo_local":"Cruzamento","situacao":"Totalmente desligado"}',
        1, 'EM_ATENDIMENTO',
        'Avenida Maracanã', '900', '',
        'Maracanã', '20271-111',
        'Cruzamento com rua lateral',
        -22.9128, -43.2300
    ),
    (
        '00000000000040008000000000000010',
        'lucas.mendes@teste.com',
        'reparo-infraestrutura-saude',
        'regional-zona-oeste',
        'Problema hidráulico em unidade pública de saúde.',
        '{"nome_unidade":"Unidade de Saúde Teste","tipo_problema":"Problema hidráulico","descricao_complementar":"Vazamento próximo ao banheiro."}',
        1, 'RECEBIDA',
        'Rua Cesário de Melo', '3000', '',
        'Campo Grande', '23050-102',
        'Próximo à unidade de saúde',
        -22.9010, -43.5600
    )
)

INSERT INTO zeladoria_solicitacaozeladoria (
    protocolo,
    solicitante_id,
    servico_id,
    unidade_atual_id,
    descricao,
    respostas_adicionais,
    formulario_versao,
    status,
    logradouro,
    numero,
    complemento,
    bairro,
    cep,
    ponto_referencia,
    latitude,
    longitude,
    criado_em,
    atualizado_em
)
SELECT
    s.protocolo,
    u.id,
    serv.id,
    un.id,
    s.descricao,
    s.respostas_adicionais,
    s.formulario_versao,
    s.status,
    s.logradouro,
    s.numero,
    s.complemento,
    s.bairro,
    s.cep,
    s.ponto_referencia,
    s.latitude,
    s.longitude,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM solicitacoes s
INNER JOIN accounts_usuario u
    ON u.email = s.solicitante_email
INNER JOIN catalogo_servicocatalogo serv
    ON serv.codigo = s.servico_codigo
INNER JOIN zeladoria_unidadeatendimento un
    ON un.codigo = s.unidade_codigo
WHERE NOT EXISTS (
    SELECT 1
    FROM zeladoria_solicitacaozeladoria existente
    WHERE existente.protocolo = s.protocolo
);

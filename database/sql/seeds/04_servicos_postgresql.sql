WITH servicos (
    assunto_codigo,
    codigo,
    nome,
    descricao,
    instrucoes,
    prazo_estimado_dias,
    formulario_config,
    ordem
) AS (
    VALUES

    -- =================================================
    -- ZELADORIA URBANA
    -- =================================================

    (
        'vias-buracos',
        'reparo-buraco-pista',
        'Reparo de buraco na pista',
        'Solicitação de reparo de buracos e danos no pavimento de vias públicas.',
        'Informe a localização exata do buraco e, se possível, envie uma fotografia.',
        15,
        '{"versao_formulario":1,"campos":[{"chave":"profundidade_aproximada","rotulo":"Profundidade aproximada do buraco (cm)","tipo":"number","obrigatorio":false},{"chave":"risco_acidentes","rotulo":"O buraco oferece risco de acidentes?","tipo":"select","obrigatorio":true,"opcoes":["Sim","Não","Não sei informar"]},{"chave":"descricao_complementar","rotulo":"Informações adicionais","tipo":"textarea","obrigatorio":false}]}',
        1
    ),

    (
        'vias-pavimentacao',
        'recuperacao-pavimento',
        'Recuperação de pavimento',
        'Solicitação de recuperação de pavimento deteriorado em vias públicas.',
        'Descreva as condições do pavimento e a extensão aproximada do problema.',
        20,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_pavimento","rotulo":"Tipo de pavimento","tipo":"select","obrigatorio":true,"opcoes":["Asfalto","Paralelepípedo","Concreto","Outro","Não sei informar"]},{"chave":"extensao_problema","rotulo":"Extensão aproximada do trecho afetado (metros)","tipo":"number","obrigatorio":false},{"chave":"descricao_complementar","rotulo":"Informações adicionais","tipo":"textarea","obrigatorio":false}]}',
        1
    ),

    (
        'calcadas-danos',
        'reparo-calcada',
        'Reparo de calçada danificada',
        'Solicitação de reparo de calçadas quebradas ou deterioradas.',
        'Indique o trecho afetado e descreva os danos encontrados.',
        15,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_dano","rotulo":"Tipo de dano","tipo":"select","obrigatorio":true,"opcoes":["Piso quebrado","Desnível","Buraco","Afundamento","Outro"]},{"chave":"interdita_passagem","rotulo":"O problema impede a passagem de pedestres?","tipo":"select","obrigatorio":true,"opcoes":["Sim","Parcialmente","Não"]},{"chave":"descricao_complementar","rotulo":"Informações adicionais","tipo":"textarea","obrigatorio":false}]}',
        1
    ),

    (
        'calcadas-acessibilidade',
        'adequacao-acessibilidade-calcada',
        'Adequação de acessibilidade em calçada',
        'Solicitação de avaliação de barreiras à circulação de pedestres.',
        'Descreva a barreira encontrada e como ela afeta a circulação.',
        20,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_barreira","rotulo":"Tipo de barreira","tipo":"select","obrigatorio":true,"opcoes":["Ausência de rampa","Rampa inadequada","Obstáculo na passagem","Piso inadequado","Outro"]},{"chave":"descricao_complementar","rotulo":"Detalhes da ocorrência","tipo":"textarea","obrigatorio":true}]}',
        1
    ),

    (
        'mobiliario-bancos',
        'manutencao-banco-publico',
        'Manutenção de banco público',
        'Solicitação de manutenção ou reparo de bancos em espaços públicos.',
        'Informe a localização do equipamento e os danos observados.',
        15,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_problema","rotulo":"Problema identificado","tipo":"select","obrigatorio":true,"opcoes":["Banco quebrado","Banco solto","Banco danificado","Banco removido","Outro"]},{"chave":"descricao_complementar","rotulo":"Informações adicionais","tipo":"textarea","obrigatorio":false}]}',
        1
    ),

    (
        'mobiliario-equipamentos',
        'manutencao-equipamento-publico',
        'Manutenção de equipamento público',
        'Solicitação de manutenção de equipamentos instalados em espaços públicos.',
        'Identifique o equipamento e descreva o problema.',
        20,
        '{"versao_formulario":1,"campos":[{"chave":"equipamento","rotulo":"Equipamento afetado","tipo":"text","obrigatorio":true},{"chave":"tipo_problema","rotulo":"Problema identificado","tipo":"textarea","obrigatorio":true}]}',
        1
    ),

    -- =================================================
    -- ILUMINAÇÃO PÚBLICA
    -- =================================================

    (
        'lampadas-apagadas',
        'reparo-lampada-apagada',
        'Reparo de lâmpada apagada',
        'Solicitação de reparo de ponto de iluminação pública sem funcionamento.',
        'Informe o endereço e, se possível, o número de identificação do poste.',
        10,
        '{"versao_formulario":1,"campos":[{"chave":"numero_poste","rotulo":"Número de identificação do poste","tipo":"text","obrigatorio":false},{"chave":"quantidade_lampadas","rotulo":"Quantidade de lâmpadas apagadas","tipo":"number","obrigatorio":false},{"chave":"periodo_problema","rotulo":"Quando o problema ocorre?","tipo":"select","obrigatorio":true,"opcoes":["Durante toda a noite","Em alguns períodos","Não sei informar"]}]}',
        1
    ),

    (
        'lampadas-intermitentes',
        'reparo-lampada-intermitente',
        'Reparo de iluminação intermitente',
        'Solicitação de reparo de luminárias com funcionamento irregular.',
        'Descreva o comportamento da iluminação e quando ele ocorre.',
        10,
        '{"versao_formulario":1,"campos":[{"chave":"comportamento","rotulo":"Comportamento observado","tipo":"select","obrigatorio":true,"opcoes":["Acende e apaga","Oscila a intensidade","Apaga após algum tempo","Outro"]},{"chave":"periodo_ocorrencia","rotulo":"Período em que ocorre","tipo":"select","obrigatorio":false,"opcoes":["No início da noite","Durante a madrugada","Durante toda a noite","Outro"]}]}',
        1
    ),

    (
        'postes-danificados',
        'reparo-poste-danificado',
        'Reparo de poste danificado',
        'Solicitação de avaliação de poste de iluminação com danos estruturais.',
        'Informe a localização e descreva os danos. Se houver risco imediato, procure os canais de emergência.',
        15,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_dano","rotulo":"Dano observado","tipo":"select","obrigatorio":true,"opcoes":["Poste inclinado","Poste enferrujado","Base danificada","Fiação exposta","Poste parcialmente destruído","Outro"]},{"chave":"risco_imediato","rotulo":"Existe risco imediato para pessoas?","tipo":"select","obrigatorio":true,"opcoes":["Sim","Não","Não sei informar"]}]}',
        1
    ),

    -- =================================================
    -- LIMPEZA URBANA
    -- =================================================

    (
        'coleta-nao-realizada',
        'reclamacao-coleta-nao-realizada',
        'Reclamação de coleta não realizada',
        'Registro de ocorrência de coleta de resíduos não realizada.',
        'Informe o dia em que a coleta deveria ter ocorrido.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"data_prevista","rotulo":"Data em que a coleta deveria ocorrer","tipo":"date","obrigatorio":true},{"chave":"tipo_residuo","rotulo":"Tipo de resíduo","tipo":"select","obrigatorio":true,"opcoes":["Resíduo domiciliar","Resíduo comercial","Outro"]},{"chave":"descricao_complementar","rotulo":"Informações adicionais","tipo":"textarea","obrigatorio":false}]}',
        1
    ),

    (
        'coleta-entulho',
        'solicitacao-remocao-entulho',
        'Solicitação de remoção de entulho',
        'Solicitação de remoção de entulho descartado em área pública.',
        'Informe o tipo e a quantidade aproximada de entulho acumulado.',
        10,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_entulho","rotulo":"Tipo de material","tipo":"select","obrigatorio":true,"opcoes":["Resíduos de construção","Móveis descartados","Galhos e podas","Materiais diversos","Outro"]},{"chave":"quantidade_aproximada","rotulo":"Quantidade aproximada","tipo":"select","obrigatorio":true,"opcoes":["Pequena","Média","Grande"]}]}',
        1
    ),

    (
        'limpeza-ruas',
        'solicitacao-limpeza-rua',
        'Solicitação de limpeza de rua',
        'Solicitação de limpeza ou varrição de via pública.',
        'Descreva a situação e indique o trecho que necessita de limpeza.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_sujeira","rotulo":"Tipo de ocorrência","tipo":"select","obrigatorio":true,"opcoes":["Acúmulo de lixo","Sujeira na via","Resíduos espalhados","Outro"]},{"chave":"extensao_trecho","rotulo":"Extensão aproximada do trecho (metros)","tipo":"number","obrigatorio":false}]}',
        1
    ),

    (
        'limpeza-pracas',
        'solicitacao-limpeza-praca',
        'Solicitação de limpeza de praça',
        'Solicitação de limpeza e conservação de praça pública.',
        'Informe o nome da praça e descreva o problema.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_problema","rotulo":"Problema identificado","tipo":"select","obrigatorio":true,"opcoes":["Acúmulo de lixo","Lixeiras cheias","Sujeira geral","Resíduos de poda","Outro"]},{"chave":"nome_praca","rotulo":"Nome da praça","tipo":"text","obrigatorio":false}]}',
        1
    ),

    -- =================================================
    -- MEIO AMBIENTE
    -- =================================================

    (
        'arborizacao-poda',
        'solicitacao-poda-arvore',
        'Solicitação de poda de árvore',
        'Solicitação de avaliação e poda de árvore em área pública.',
        'Identifique a árvore e descreva a necessidade de poda.',
        20,
        '{"versao_formulario":1,"campos":[{"chave":"motivo_poda","rotulo":"Motivo da solicitação","tipo":"select","obrigatorio":true,"opcoes":["Galhos próximos à rede elétrica","Galhos obstruindo passagem","Galhos sobre imóveis","Manutenção preventiva","Outro"]},{"chave":"altura_aproximada","rotulo":"Altura aproximada da árvore (metros)","tipo":"number","obrigatorio":false}]}',
        1
    ),

    (
        'arborizacao-queda',
        'avaliacao-arvore-risco',
        'Avaliação de árvore caída ou com risco',
        'Solicitação de avaliação de árvore caída ou com risco de queda.',
        'Descreva a situação e informe se há risco para pessoas ou imóveis.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"situacao_arvore","rotulo":"Situação da árvore","tipo":"select","obrigatorio":true,"opcoes":["Árvore caída","Árvore inclinada","Raízes expostas","Tronco danificado","Galhos prestes a cair","Outro"]},{"chave":"risco_pessoas","rotulo":"Há risco para pessoas ou imóveis?","tipo":"select","obrigatorio":true,"opcoes":["Sim","Não","Não sei informar"]}]}',
        1
    ),

    (
        'fauna-animal-ferido',
        'atendimento-animal-ferido',
        'Atendimento de animal ferido',
        'Registro de ocorrência envolvendo animal ferido em área pública.',
        'Informe a localização, a espécie se conhecida e a condição do animal.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"especie_animal","rotulo":"Espécie do animal","tipo":"select","obrigatorio":true,"opcoes":["Cão","Gato","Ave","Animal silvestre","Outro","Não sei identificar"]},{"chave":"condicao_animal","rotulo":"Condição observada","tipo":"textarea","obrigatorio":true},{"chave":"animal_agressivo","rotulo":"O animal apresenta comportamento agressivo?","tipo":"select","obrigatorio":false,"opcoes":["Sim","Não","Não sei informar"]}]}',
        1
    ),

    -- =================================================
    -- TRANSPORTE
    -- =================================================

    (
        'sinalizacao-vertical',
        'reparo-placa-sinalizacao',
        'Reparo de placa de sinalização',
        'Solicitação de instalação, substituição ou reparo de placa viária.',
        'Informe o endereço e o tipo de placa envolvida.',
        15,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_placa","rotulo":"Tipo de placa","tipo":"select","obrigatorio":true,"opcoes":["Regulamentação","Advertência","Indicação","Não sei identificar"]},{"chave":"problema","rotulo":"Problema identificado","tipo":"select","obrigatorio":true,"opcoes":["Placa ausente","Placa danificada","Placa encoberta","Placa ilegível","Outro"]}]}',
        1
    ),

    (
        'sinalizacao-horizontal',
        'reparo-sinalizacao-solo',
        'Reparo de sinalização de solo',
        'Solicitação de recuperação de faixas e marcações viárias.',
        'Informe o endereço e o tipo de sinalização que necessita de reparo.',
        20,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_sinalizacao","rotulo":"Tipo de sinalização","tipo":"select","obrigatorio":true,"opcoes":["Faixa de pedestres","Linha divisória de pista","Símbolo no pavimento","Linha de retenção","Outro"]},{"chave":"condicao","rotulo":"Condição da sinalização","tipo":"select","obrigatorio":true,"opcoes":["Apagada","Desgastada","Ausente","Parcialmente visível"]}]}',
        1
    ),

    (
        'semaforos-inoperantes',
        'reparo-semaforo-inoperante',
        'Reparo de semáforo inoperante',
        'Solicitação de avaliação de semáforo desligado ou sem funcionamento.',
        'Informe o cruzamento e descreva a situação observada.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_local","rotulo":"Localização do semáforo","tipo":"select","obrigatorio":true,"opcoes":["Cruzamento","Travessia de pedestres","Outro"]},{"chave":"situacao","rotulo":"Situação observada","tipo":"select","obrigatorio":true,"opcoes":["Totalmente desligado","Apagado parcialmente","Piscando","Outro"]}]}',
        1
    ),

    (
        'semaforos-defeito',
        'avaliacao-semaforo-defeito',
        'Avaliação de semáforo com defeito',
        'Solicitação de avaliação de semáforo com funcionamento irregular.',
        'Descreva o comportamento observado e o local da ocorrência.',
        5,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_defeito","rotulo":"Defeito observado","tipo":"select","obrigatorio":true,"opcoes":["Tempo de sinal irregular","Luzes fora de sequência","Luz queimada","Sinalização intermitente","Outro"]},{"chave":"descricao_complementar","rotulo":"Detalhes do problema","tipo":"textarea","obrigatorio":false}]}',
        1
    ),

    -- =================================================
    -- SAÚDE
    -- =================================================

    (
        'saude-infraestrutura',
        'reparo-infraestrutura-saude',
        'Reparo de infraestrutura de unidade de saúde',
        'Registro de problemas de infraestrutura em unidades públicas de saúde.',
        'Informe o nome da unidade e descreva o problema encontrado.',
        15,
        '{"versao_formulario":1,"campos":[{"chave":"nome_unidade","rotulo":"Nome da unidade de saúde","tipo":"text","obrigatorio":true},{"chave":"tipo_problema","rotulo":"Tipo de problema","tipo":"select","obrigatorio":true,"opcoes":["Problema hidráulico","Problema elétrico","Danos estruturais","Problema em banheiro","Problema em acessibilidade","Outro"]},{"chave":"descricao_complementar","rotulo":"Descrição do problema","tipo":"textarea","obrigatorio":true}]}',
        1
    ),

    -- =================================================
    -- ORDENAMENTO URBANO
    -- =================================================

    (
        'ocupacao-calcada',
        'denuncia-ocupacao-calcada',
        'Registro de ocupação irregular de calçada',
        'Registro de ocorrência de ocupação irregular de calçada ou passeio público.',
        'Descreva a ocupação e indique como ela afeta a circulação de pedestres.',
        10,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_ocupacao","rotulo":"Tipo de ocupação","tipo":"select","obrigatorio":true,"opcoes":["Mercadorias","Estrutura comercial","Entulho","Veículos","Outro"]},{"chave":"bloqueio_passagem","rotulo":"A passagem de pedestres está bloqueada?","tipo":"select","obrigatorio":true,"opcoes":["Totalmente","Parcialmente","Não"]}]}',
        1
    ),

    (
        'ocupacao-area-publica',
        'denuncia-ocupacao-area-publica',
        'Registro de ocupação irregular de área pública',
        'Registro de ocorrência de ocupação irregular de praça ou outro espaço público.',
        'Identifique o espaço público e descreva a ocupação.',
        10,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_espaco","rotulo":"Tipo de espaço público","tipo":"select","obrigatorio":true,"opcoes":["Praça","Parque","Rua","Área institucional","Outro"]},{"chave":"tipo_ocupacao","rotulo":"Tipo de ocupação","tipo":"textarea","obrigatorio":true}]}',
        1
    ),

    -- =================================================
    -- DEFESA CIVIL
    -- =================================================

    (
        'risco-deslizamento',
        'avaliacao-risco-deslizamento',
        'Avaliação de risco de deslizamento',
        'Registro de ocorrência com indícios de instabilidade de encosta ou terreno.',
        'Descreva os sinais observados. Em situação de perigo imediato, acione os serviços de emergência.',
        2,
        '{"versao_formulario":1,"campos":[{"chave":"sinais_observados","rotulo":"Sinais observados","tipo":"select","obrigatorio":true,"opcoes":["Rachaduras no solo","Queda de terra ou pedras","Inclinação de árvores ou postes","Movimentação de terreno","Outro"]},{"chave":"chuva_recente","rotulo":"Houve chuva intensa recentemente?","tipo":"select","obrigatorio":true,"opcoes":["Sim","Não","Não sei informar"]},{"chave":"descricao_complementar","rotulo":"Detalhes da ocorrência","tipo":"textarea","obrigatorio":true}]}',
        1
    ),

    (
        'risco-estrutural',
        'avaliacao-risco-estrutural',
        'Avaliação de risco estrutural',
        'Registro de ocorrência envolvendo possível risco estrutural em edificação.',
        'Descreva os danos observados e informe a localização. Em situação de perigo imediato, acione os serviços de emergência.',
        2,
        '{"versao_formulario":1,"campos":[{"chave":"tipo_edificacao","rotulo":"Tipo de edificação","tipo":"select","obrigatorio":true,"opcoes":["Residencial","Comercial","Pública","Outra"]},{"chave":"sinais_risco","rotulo":"Sinais observados","tipo":"select","obrigatorio":true,"opcoes":["Rachaduras","Desabamento parcial","Paredes inclinadas","Laje danificada","Outro"]},{"chave":"descricao_complementar","rotulo":"Detalhes da ocorrência","tipo":"textarea","obrigatorio":true}]}',
        1
    )
)

INSERT INTO catalogo_servicocatalogo (
    assunto_id,
    codigo,
    nome,
    descricao,
    instrucoes,
    prazo_estimado_dias,
    formulario_config,
    versao_formulario,
    ativo,
    ordem,
    criado_em,
    atualizado_em
)
SELECT
    a.id,
    s.codigo,
    s.nome,
    s.descricao,
    s.instrucoes,
    s.prazo_estimado_dias,
    s.formulario_config::jsonb,
    1,
    TRUE,
    s.ordem,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM servicos s
INNER JOIN catalogo_assunto a
    ON a.codigo = s.assunto_codigo
WHERE NOT EXISTS (
    SELECT 1
    FROM catalogo_servicocatalogo existente
    WHERE existente.codigo = s.codigo
);
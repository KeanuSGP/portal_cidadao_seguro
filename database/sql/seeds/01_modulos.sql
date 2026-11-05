INSERT INTO catalogo_moduloportal
    (codigo, nome, descricao, ativo, ordem, criado_em, atualizado_em)
VALUES
    ('zeladoria-urbana', 'Zeladoria Urbana',
     'Serviços de conservação e manutenção urbana',
     1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('iluminacao-publica', 'Iluminação Pública',
     'Serviços relacionados à iluminação pública',
     1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('limpeza-urbana', 'Limpeza Urbana',
     'Serviços de limpeza e conservação de espaços públicos',
     1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('meio-ambiente', 'Meio Ambiente',
     'Serviços relacionados à preservação ambiental',
     1, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('transporte', 'Transporte',
     'Serviços relacionados à mobilidade urbana',
     1, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('saude', 'Saúde',
     'Serviços de atendimento e informações de saúde',
     1, 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('ordenamento-urbano', 'Ordenamento Urbano',
     'Serviços de fiscalização e organização urbana',
     1, 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    ('defesa-civil', 'Defesa Civil',
     'Serviços relacionados à prevenção e resposta a riscos',
     1, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
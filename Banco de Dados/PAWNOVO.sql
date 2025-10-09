USE MASTER IF EXISTS(SELECT * FROM SYS.databases WHERE NAME = 'PAWPROTETICARE')
 
 
DROP DATABASE PAWPROTETICARE

GO

CREATE DATABASE PAWPROTETICARE

GO

USE PAWPROTETICARE

GO
 
 
 
CREATE TABLE animachado (
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    especie VARCHAR(100) NOT NULL,
 
    historia VARCHAR(255) NOT NULL,
 
    idade INT NOT NULL,
 
    imagem VARBINARY(MAX),
 
    nome VARCHAR(100) NOT NULL,
 
    status VARCHAR(30) CHECK (status IN('APTO_PARA_ADOCAO','ANALISE_SITUACAO','AGUARDANDO_PROTESE','FALECIDO','NAO_AVALIADO')),
 
    protese_id BIGINT
 
);

CREATE TABLE animadotado (
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    doado VARCHAR(255)  NOT NULL CHECK (doado IN ('APROVADO','REPROVADO','AGUARDANDO_AVALIACAO')),
 
    animachado_id BIGINT,
 
    proprietario_id BIGINT
 
);

CREATE TABLE doacao (
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    datadoacao DATETIME2(6) NOT NULL,
 
    tipodoacao VARCHAR(50) NOT NULL,
 
    valor VARCHAR(30) NOT NULL,
 
    doador_id BIGINT
 
);

CREATE TABLE protese (
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    codigo VARCHAR(40) NOT NULL,
 
    custo NUMERIC(10,2) NOT NULL,
 
    descricao VARCHAR(40),
 
    fabricante VARCHAR(100) NOT NULL,
 
    nome VARCHAR(100) NOT NULL,
 
    tipo VARCHAR(40) NOT NULL
 
);

CREATE TABLE protese_animachado (
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    data_aplicacao_protese DATETIME2(6) NOT NULL,
 
    observacao VARCHAR(255),
 
    animachado_id BIGINT NOT NULL,
 
    protese_entity_id BIGINT
 
);

CREATE TABLE solicitacao_adocao (
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    data_solicitacao DATETIME2(6),
 
    motivacao VARCHAR(255),
 
    animachado_id BIGINT,
 
    proprietario_id BIGINT
 
);

CREATE TABLE tokens (
 
    id BIGINT NOT NULL PRIMARY KEY,
 
    expired BIT NOT NULL,
 
    revoked BIT NOT NULL,
 
    token VARCHAR(255),
 
    token_type VARCHAR(255) CHECK (token_type IN ('BEARER')),
 
    usuario_id BIGINT
 
);

CREATE TABLE usuario (
 
    role VARCHAR(31)NOT NULL CHECK (role IN('ADMIN','PROPRIETARIO','DOADOR','VISITANTE')),
 
    id BIGINT IDENTITY NOT NULL PRIMARY KEY,
 
    bairro VARCHAR(40),
 
    cep VARCHAR(9),
 
    cod_status BIT NOT NULL,
 
    complemento VARCHAR(30),
 
    cpf VARCHAR(255),
 
    email VARCHAR(50) NOT NULL,
 
    logradouro VARCHAR(50),
 
    nome VARCHAR(50),
 
    numeroend INT,
 
    password VARCHAR(255) NOT NULL,
 
    telefone CHAR(14),
 
    uf VARCHAR(2)
 
);

 
CREATE UNIQUE NONCLUSTERED INDEX UKmwt6juuiuw6ae0pwv7gtn79ht ON animadotado (animachado_id) WHERE animachado_id IS NOT NULL;
 
CREATE UNIQUE NONCLUSTERED INDEX UKna3v9f8s7ucnj16tylrs822qj ON tokens (token) WHERE token IS NOT NULL;

 
 
CREATE SEQUENCE tokens_seq START WITH 1 INCREMENT BY 50;

 
 
ALTER TABLE animachado ADD CONSTRAINT FKgy2nry1o99k6glcgc21pbeqca FOREIGN KEY (protese_id) REFERENCES protese(id);
 
ALTER TABLE animadotado ADD CONSTRAINT FK7t7e3nnhlcsxtgqqjerkcrjm1 FOREIGN KEY (animachado_id) REFERENCES animachado(id);
 
ALTER TABLE animadotado ADD CONSTRAINT FKd2o366sfswyk4wg4k0erpp13e FOREIGN KEY (proprietario_id) REFERENCES usuario(id);
 
ALTER TABLE doacao ADD CONSTRAINT FK4oh2q403sxmtg2jutfwkvq60t FOREIGN KEY (doador_id) REFERENCES usuario(id);
 
ALTER TABLE protese_animachado ADD CONSTRAINT FK8ki3mt48ab4lv7ycufa4vusf FOREIGN KEY (animachado_id) REFERENCES animachado(id);
 
ALTER TABLE protese_animachado ADD CONSTRAINT FK1hhb8vnuxhod77jtroq4v1pvu FOREIGN KEY (protese_entity_id) REFERENCES protese(id);
 
ALTER TABLE solicitacao_adocao ADD CONSTRAINT FKaknuxypctdiowr6qk9mqyd6k4 FOREIGN KEY (animachado_id) REFERENCES animachado(id);
 
ALTER TABLE solicitacao_adocao ADD CONSTRAINT FK5mo0b76dqbp3rco04ydr8ltr8 FOREIGN KEY (proprietario_id) REFERENCES usuario(id);
 
ALTER TABLE tokens ADD CONSTRAINT FKchhxaj9kivyvsm9hgpvnf1qhq FOREIGN KEY (usuario_id) REFERENCES usuario(id);
 
 
 
 
INSERT INTO Protese (nome,tipo, fabricante, custo,codigo) VALUES ('OrtoKnee X1','Joelho', 'OrtoTech', 3500.00,'PRT-2025-AX9Q7W3E8L2M5B6C1D4F7G0H3J9K2L') 

INSERT INTO Protese (nome,tipo, fabricante, custo,codigo) VALUES ('HipMotion Pro','Quadril', 'BioMotion', 4200.50,'PRT-2025-Z8X1C3V7B9N6M5L2K4J0H3G8F7D1A')

INSERT INTO Protese (nome,tipo, fabricante, custo,codigo) VALUES ('FlexiShoulder 360','Ombro', 'FlexMed', 2800.75,'PRT-2025-Q7W9E2R5T6Y8U1I3O4P0L9K6J5H2G')

INSERT INTO Protese (nome,tipo, fabricante, custo,codigo) VALUES ('AnkleMove Lite','Tornozelo', 'MoviPro', 3100.20,'PRT-2025-M3N5B7V9C1X2Z4A6S8D0F7G9H1J3K')

INSERT INTO Protese (nome,tipo, fabricante, custo,codigo) VALUES  ('NeuroElbow Max','Cotovelo', 'NeuroFit', 2650.00,'PRT-2025-L9K8J7H6G5F4D3S2A1Z0X9C8V7B6N')

INSERT INTO Protese (nome, tipo, fabricante, custo, codigo) VALUES('FlexKnee Ultra','Joelho','BioMotion', 3120.50,'PRT-2025-K8J7H6G5F4D3S2A1Z0X9C8V7B6N5M4L');

INSERT INTO Protese (nome, tipo, fabricante, custo, codigo) VALUES ('GripPaw Pro','pata','NeuroFit', 1985.75,'PRT-2025-H6G5F4D3S2A1Z0X9C8V7B6N5M4L3K2J');
 
 
 
INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Chico', 2 , 'Tumor nos membros.', 'Vira-lata','AGUARDANDO_PROTESE',1);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Pedrita', 14 , 'Hernia de disco que resultou a uma paralisia.', 'Dachshund','AGUARDANDO_PROTESE',2);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Toby', 8 , 'Atropelamento por carro', 'Chihuahua','AGUARDANDO_PROTESE',3);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Amora', 12 , 'Brigou com outro animal e perdeu um dos membros.', 'Pastor Alemão','AGUARDANDO_PROTESE',4);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Bob', 11 , 'Necrose de tecidos: devido a falta de circulação sanguinea.', 'Pinscher','ANALISE_SITUACAO',NULL);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Pantera', 20 , 'Após um AVC(Acidente vascular cerebral) que resultou a paralisia.', 'Siamês','AGUARDANDO_PROTESE',5);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Vodka', 16 , 'Fratura complexa, onde a fratura não cicatrizou corretamente.', 'Bombaim','AGUARDANDO_PROTESE',6);

INSERT INTO	animachado(nome,idade,historia,especie,status,protese_id) VALUES('Theo', 13 , 'Infecção grave que não correspondeu ao tratamento.','Siberiano','FALECIDO',NULL);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_id) VALUES('Duquesa', 15 , 'Acidente doméstico.', 'Norueguês da Floresta','NAO_AVALIADO',NULL);

INSERT INTO animachado(nome,idade,historia,especie,status,protese_Id) VALUES('Jonas', 8 , 'Atropelamento por um carro.', 'bulldog','NAO_AVALIADO',NULL);
 
 
INSERT INTO usuario(role, bairro, cep, cod_status, complemento, cpf, email, logradouro, nome, numeroend, password, telefone, uf) VALUES('ADMIN', 'Centro', '06401-000', 1, 'Apto 101', '12345678901', 'admin@example.com', 'Rua das Flores', 'João Silva', 100, 'senhaSegura123', '(11)91234-5678', 'SP')

INSERT INTO usuario(role, bairro, cep, cod_status, complemento, cpf, email, logradouro, nome, numeroend, password, telefone, uf) VALUES('PROPRIETARIO', 'Jardim Paulista', '01415-002', 1, 'Casa 2', '98765432100', 'maria.proprietaria@example.com', 'Av. Paulista', 'Maria Oliveira', 45, 'senhaForte456', '(11)99876-5432', 'SP');

INSERT INTO usuario(role, bairro, cep, cod_status, complemento, cpf, email, logradouro, nome, numeroend, password, telefone, uf) VALUES('VISITANTE', 'Moema', '04522-060', 1, 'Sala 3', '45678912300', 'visitante.jose@example.com', 'Rua Gaivota', 'José Lima', 120, 'senhaVisitante789', '(11)98765-4321', 'SP');

INSERT INTO usuario(role, bairro, cep, cod_status, complemento, cpf, email, logradouro, nome, numeroend, password, telefone, uf) VALUES('DOADOR', 'Pinheiros', '05422-010', 1, 'Cobertura', '32165498700', 'doadora.clara@example.com', 'Rua dos Pinheiros', 'Clara Mendes', 88, 'senhaDoador321', '(11)97654-3210', 'SP');

INSERT INTO usuario(role, bairro, cep, cod_status, complemento, cpf, email, logradouro, nome, numeroend, password, telefone, uf) VALUES('PROPRIETARIO', 'Vila Mariana', '04112-000', 1, 'Fundos', '65498732100', 'proprietario.lucas@example.com', 'Rua Domingos de Morais', 'Lucas Rocha', 200, 'senhaLucas654', '(11)96543-2109', 'SP');

INSERT INTO usuario(role, bairro, cep, cod_status, complemento, cpf, email, logradouro, nome, numeroend, password, telefone, uf)VALUES('DOADOR', 'Santana', '02012-000', 1, 'Apto 202', '78912345600', 'doador.ana@example.com', 'Rua Alfredo Pujol', 'Ana Costa', 75, 'senhaAna789', '(11)95432-1098', 'SP');
 
 
 
TCC.zip
 
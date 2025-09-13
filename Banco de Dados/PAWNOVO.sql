USE MASTER IF EXISTS(SELECT * FROM SYS.databases WHERE NAME = 'PAWPROTETICARE')


DROP DATABASE PAWPROTETICARE
GO
 
CREATE DATABASE PAWPROTETICARE
GO
 
USE PAWPROTETICARE
GO


CREATE TABLE Protese (
    Id INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	tipo VARCHAR(40),
    nome VARCHAR(100),
	custo DECIMAL(10,2),
	fabricante VARCHAR(100)
);

CREATE TABLE Usuario (
   Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
   AnimalId INT,
   CPF BIGINT,
   email VARCHAR(50),
   senha VARCHAR(50),
   nome VARCHAR(50),
   bairro VARCHAR (40),
   numeroend INT,
   uf VARCHAR(2),
   complemento VARCHAR(30),
   cep VARCHAR (8),
   logradouro VARCHAR(50),
   telefone CHAR (11),
   tipousuario VARCHAR(15)
);


CREATE TABLE Animachado (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nome VARCHAR(100),
    especie VARCHAR(100),
    historia VARCHAR(255),
	protese VARCHAR(255),
	status VARCHAR (30),
	idade INT,
	imagem VARCHAR(MAX),
	doado BIT NOT NULL,
	fk_Protese_Id INT NULL,
	fk_Usuario_Id INT NULL,	
	FOREIGN KEY (fk_Protese_Id) REFERENCES Protese(Id),
	FOREIGN KEY (fk_Usuario_Id) REFERENCES Usuario(Id)
);



CREATE TABLE Animadotado	 (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    proprietario_id INT,
	animalachado_id INT,
	doado BIT NOT NULL, 
 	fk_Protese_Id INT NULL,
	fk_Usuario_Id INT NULL,
	FOREIGN KEY (fk_Protese_Id) REFERENCES Protese(Id),
	FOREIGN KEY (fk_Usuario_Id) REFERENCES Usuario(Id)
);


CREATE TABLE Doacao (
    Id INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	tipodoacao VARCHAR(50),
	doador_id INT,
	valor decimal (10,2),
	fk_Usuario_Id INT NULL,
	FOREIGN KEY (fk_Usuario_Id) REFERENCES Usuario(Id)
   );

INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Chico', 2 , 'Tumor nos membros.', 'Vira-lata','Adotado','Perna direita inferior',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Pedrita', 14 , 'Hernia de disco que resultou a uma paralisia.', 'Dachshund','Esperando Cirurgia','Patas inferiores',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Toby', 8 , 'Atropelamento por carro', 'Chihuahua','Esperando Protése','Patas superiores',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Amora', 12 , 'Brigou com outro animal e perdeu um dos membros.', 'Pastor Alemão','Esperando Cirurgia','Pata direita superior',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Bob', 11 , 'Necrose de tecidos: devido a falta de circulação sanguinea.', 'Pinscher','Adotado','Pernas inferiores',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Pantera', 20 , 'Após um AVC(Acidente vascular cerebral) que resultou a paralisia.', 'Siamês','Esperando Protése','Pata direita inferior',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Vodka', 16 , 'Fratura complexa, onde a fratura não cicatrizou corretamente.', 'Bombaim','Esperando Protése','Pata esquerda superior',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Theo', 13 , 'Infecção grave que não correspondeu ao tratamento.', 'Siberiano','Adotado','Quadril',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Duquesa', 15 , 'Acidente doméstico.', 'Norueguês da Floresta','Adotado','Olho direito',0);
INSERT INTO Animachado(nome, idade, historia,especie,status,protese,doado) VALUES('Jonas', 8 , 'Atropelamento por um carro.', 'bulldog','Esperando Cirurgia','Perna esquerda inferior',0);

INSERT INTO Doacao(tipodoacao) VALUES('Roupa')
INSERT INTO Doacao(tipodoacao) VALUES('Ração')
INSERT INTO Doacao(tipodoacao) VALUES ('Dinheiro')
INSERT INTO Doacao(tipodoacao) VALUES('Dinheiro50')
INSERT INTO Doacao(tipodoacao) VALUES('Dinheiro100')
INSERT INTO Doacao(tipodoacao) VALUES ('Dinheiro10')
INSERT INTO Doacao(tipodoacao) VALUES ('Dinheiro15')
INSERT INTO Doacao(tipodoacao) VALUES ('Dinheiro20')
INSERT INTO Doacao(tipodoacao) VALUES ('Dinheiro25')
INSERT INTO Doacao(tipodoacao) VALUES ('Dinheiro30')


INSERT INTO Usuario(nome,CPF,email,senha,bairro,numeroend,uf,complemento,cep,logradouro,telefone,tipousuario) VALUES ('Nathan Prado Santos',12345678909,'nps.paw@gmail.com', '1233','Jardim Belval',170,'SP','casa 01','06499888','Alameda Altair','11912345678','Visitante');
INSERT INTO Usuario(nome,CPF,email,senha,bairro,numeroend,uf,complemento,cep,logradouro,telefone,tipousuario) VALUES ('Amanda Oliveira Costa', 98765432100, 'amanda.oc@gmail.com', 'senha456', 'Centro', 45, 'RJ', 'apto 302', '20040002', 'Rua das Laranjeiras', '21987654321','Doador');
INSERT INTO Usuario(nome,CPF,email,senha,bairro,numeroend,uf,complemento,cep,logradouro,telefone,tipousuario) VALUES ('Carlos Henrique Lima', 32178965432, 'carlos.hl@outlook.com', 'abc123', 'Santa Cecília', 89, 'SP', 'fundos', '01230010', 'Rua Jaguaribe', '11988776655','Visitante');
INSERT INTO Usuario(nome,CPF,email,senha,bairro,numeroend,uf,complemento,cep,logradouro,telefone,tipousuario) VALUES ('Fernanda Souza Ribeiro', 45612378901, 'fernanda.ribeiro@yahoo.com', 'senha789', 'Vila Mariana', 300, 'SP', 'casa', '04120010', 'Rua Domingos de Morais', '11933221100','Adotante&Doador');
INSERT INTO Usuario(nome,CPF,email,senha,bairro,numeroend,uf,complemento,cep,logradouro,telefone,tipousuario) VALUES ('Ricardo Mendes Rocha', 11223344556, 'ricardo.mr@gmail.com', 'meuacesso', 'Bela Vista', 77, 'SP', 'apto 101', '01310000', 'Avenida Paulista', '11999887766','Visitante');

INSERT INTO Protese (nome,tipo, fabricante, custo) VALUES ('OrtoKnee X1','Joelho', 'OrtoTech', 3500.00), ('HipMotion Pro','Quadril', 'BioMotion', 4200.50), ('FlexiShoulder 360','Ombro', 'FlexMed', 2800.75), ('AnkleMove Lite','Tornozelo', 'MoviPro', 3100.20), ('NeuroElbow Max','Cotovelo', 'NeuroFit', 2650.00);


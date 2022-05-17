
DROP TABLE cinema;
DROP TABLE cinema_ent;
DROP TABLE sala;
DROP TABLE funcionariofuncao;
DROP TABLE funcionario;
DROP TABLE filme;
CREATE TABLE cinema(
	CNPJ VARCHAR(14),
    enderecocep VARCHAR(8),
    endereconum INT,
    contatoemail VARCHAR(40),
    contatotel VARCHAR(9),
    nome VARCHAR(30),
    PRIMARY KEY(CNPJ)
);
CREATE TABLE sala(
	numero INT,
	CNPJ VARCHAR(14) REFERENCES cinema(CNPJ),    
    tipo VARCHAR(20),
    capacidade INT,
    PRIMARY KEY(numero,CNPJ)
);
CREATE TABLE funcionariofuncao(
	funcao VARCHAR(15),
    salario INT,
    PRIMARY KEY(funcao)
);
CREATE TABLE funcionario(
	CPF VARCHAR(11),
    nome VARCHAR(30),
    funcao VARCHAR(15) REFERENCES funcionariofuncao(funcao),
    CNPJ VARCHAR(14) NOT NULL REFERENCES cinema(CNPJ),
    gerente VARCHAR(11) NOT NULL REFERENCES funcionario(CPF),
    PRIMARY KEY(CPF)
);
CREATE TABLE filme(
	titulo VARCHAR(30),
    duracao VARCHAR(3),
    faixa_etaria INT,
	PRIMARY KEY(titulo)
);
CREATE TABLE genero(
	gen VARCHAR(15),
    titulo VARCHAR(30) REFERENCES filme(titulo),
	PRIMARY KEY(gen,titulo)
);
CREATE TABLE sessao(
	horario TIMESTAMP,
    CNPJ VARCHAR(14) REFERENCES cinema(CNPJ),
    numero INT REFERENCES sala(numero),
    titulo VARCHAR(30) REFERENCES filme(titulo),
    idioma VARCHAR(15),
    tipo VARCHAR(15),
	PRIMARY KEY(horario,CNPJ,numero)
);
CREATE TABLE ingresso(
	codigo INT,
    preço INT,
	PRIMARY KEY(codigo)
);
CREATE TABLE associado(
	tempo TIMESTAMP,
    CNPJ VARCHAR(14) REFERENCES cinema(CNPJ),
    numero INT REFERENCES sala(numero),
    codigo INT REFERENCES ingresso(codigo),
    horario TIMESTAMP REFERENCES sessao(horario), 
	PRIMARY KEY(tempo,CNPJ,numero,codigo,horario)
);

CREATE TABLE consumivel(
	codigo INT,
    nome VARCHAR(15),
    tamanho VARCHAR(15),
    preco INT,
    tipo VARCHAR(15),
	PRIMARY KEY(codigo)
); 
CREATE TABLE cliente(
	CPF VARCHAR(11),
    nome VARCHAR(30),
	PRIMARY KEY(CPF)
);
CREATE TABLE cupom(
	idcupom INT,
    tipo VARCHAR(15),
    desconto DOUBLE PRECISION,
	PRIMARY KEY(idcupom)
);
CREATE TABLE compraingresso(
	tempoing TIMESTAMP ,
	codigo INT REFERENCES ingresso(codigo),
    CPF VARCHAR(11) REFERENCES cliente(CPF),
    qtd INT,
    idcupom INT REFERENCES cupom(idcupom),
	PRIMARY KEY(tempoing,codigo,CPF)
);
CREATE TABLE compraconsumivel(
	tempoconsu TIMESTAMP,
	codigo INT REFERENCES ingresso(codigo),
    CPF VARCHAR(11) REFERENCES cliente(CPF),
    qtd INT,
    idcupom INT REFERENCES cupom(idcupom),
	PRIMARY KEY(tempoconsu,codigo,CPF)
);

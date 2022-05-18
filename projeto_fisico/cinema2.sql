DROP TABLE CINEMA CASCADE;
DROP TABLE FUNCIONARIO CASCADE;
DROP TABLE SALA CASCADE;
DROP TABLE SESSAO CASCADE;
DROP TABLE FILME CASCADE;
DROP TABLE CONSUMIVEL CASCADE;
DROP TABLE GENERO CASCADE;
DROP TABLE ASSOCIADO CASCADE;
DROP TABLE INGRESSO CASCADE;
DROP TABLE CUPOM CASCADE;
DROP TABLE CLIENTE CASCADE;
DROP TABLE COMPRA_ING CASCADE;
DROP TABLE COMPRA_CONSU CASCADE;

CREATE TABLE CINEMA (
       cnpj   varchar (18) ,
       end_cep varchar(9),
       end_num integer,
       cont_email varchar (50),
       cont_tele varchar (14) CONSTRAINT uniq_tele UNIQUE,
       nome varchar (30),
       PRIMARY KEY (cnpj)
);

CREATE TABLE FUNCIONARIO(
       cpf varchar (14),
       nome varchar (30),
       funcao varchar(10),
       cnpj varchar (14) NOT NULL REFERENCES CINEMA(cnpj),
       gerente varchar(30)  REFERENCES FUNCIONARIO(cpf), -- porque isso?
       PRIMARY KEY (cpf)
       -- ainda ha uma table funcionario funcao, mas porque ela existe? nf3?
);

CREATE TABLE SALA(
       numero smallint,
       tipo varchar (10),
       capacidade smallint,
       cnpj varchar (18) REFERENCES CINEMA(cnpj),
       PRIMARY KEY (cnpj, numero)
);

CREATE TABLE SESSAO(
       horario timestamp,
       idioma varchar (11),
       tipo varchar (10),
       numero integer ,
       cnpj varchar (18),
       titulo  varchar(30) REFERENCES FILME(titulo),
       FOREIGN KEY (numero, cnpj) REFERENCES SALA(numero, cnpj),
       PRIMARY KEY(cnpj,numero,horario)
);

CREATE TABLE FILME(
       titulo  varchar(50),
       faixaetaria char(1),
       duracao varchar(20), --em minutos!
       PRIMARY KEY(titulo)
);

CREATE TABLE GENERO(
       genero varchar(15),
       titulo varchar(30) REFERENCES FILME(titulo),
       PRIMARY KEY(titulo)
);

CREATE TABLE ASSOCIADO(
       acesso timestamp,
       codigo varchar(30) REFERENCES INGRESSO(codigo),
       numero integer,
       cnpj varchar (18),
       horario timestamp,
       FOREIGN KEY (numero, cnpj) REFERENCES SALA(numero,cnpj),
       PRIMARY KEY (codigo,horario,numero,cnpj,acesso)
);

CREATE TABLE INGRESSO(
       codigo varchar(30),
       preco real,
       PRIMARY KEY (codigo)
);

CREATE TABLE CONSUMIVEL(
       codigo varchar(30),
       preco real,
       tamanho varchar(20),
       tipo varchar(20),
       nome varchar (30),
       PRIMARY KEY (codigo)
);

CREATE TABLE CLIENTE(
       cpf varchar (14),
       nome varchar (30),
       PRIMARY KEY (cpf)
);

CREATE TABLE CUPOM(
       idcupom  varchar(20),
       tipo varchar(20),
       valor real,
       PRIMARY KEY(idcupom)
);

CREATE TABLE COMPRA_ING(
       compra_ing timestamp,
       idcupom  varchar(20),
       cpf varchar(14) REFERENCES CLIENTE(cpf),
       codigo varchar(30) REFERENCES INGRESSO(codigo),
       qtd integer,
       PRIMARY KEY (compra_ing, cpf, codigo)
);

CREATE TABLE COMPRA_CONSU(
       compra_consu timestamp,
       idcupom  varchar(20),
       cpf varchar(14) REFERENCES CLIENTE(cpf),
       codigo varchar(30) REFERENCES CONSUMIVEL(codigo),
       qtd integer,
       PRIMARY KEY (compra_consu, cpf, codigo)
);

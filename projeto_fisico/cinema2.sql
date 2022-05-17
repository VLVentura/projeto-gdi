DROP TABLE CINEMA CASCADE;
DROP TABLE FUNCIONARIO CASCADE;
DROP TABLE SALA CASCADE;
DROP TABLE SESSAO CASCADE;
DROP TABLE FILME CASCADE;
DROP TABLE CONSUMIVEL CASCADE;
DROP TABLE INGRESSO CASCADE;
DROP TABLE CUPOM CASCADE;
DROP TABLE CLIENTE CASCADE;
DROP TABLE COMPRA_ING CASCADE;
DROP TABLE COMPRA_CONSU CASCADE;

CREATE TABLE CINEMA (
       cnpj   varchar (14) ,
       end_cep varchar(9),
       end_num smallint,
       cont_email varchar (30),
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
       cnpj varchar (14) REFERENCES CINEMA_ENT(cnpj),
       PRIMARY KEY (cnpj, numero)
);

CREATE TABLE SESSAO(
       horario timestamp,
       idioma varchar (11),
       tipo varchar (10),
       numero smallint ,
       cnpj varchar (14),
       titulo  varchar(30) REFERENCES FILME(titulo),
       FOREIGN KEY (numero, cnpj) REFERENCES SALA(numero, cnpj),
       PRIMARY KEY(cnpj,numero,horario)
);

CREATE TABLE FILME(
       titulo  varchar(30),
       faixaetaria char(1),
       duracao varchar(3), --em minutos!
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
       numero smallint,
       cnpj varchar (14),
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
       tamanho char,
       tipo varchar(10),
       nome varchar (30),
       PRIMARY KEY (codigo)
);

CREATE TABLE CLIENTE(
       cpf varchar (11),
       nome varchar (30),
       PRIMARY KEY (cpf)
);

CREATE TABLE CUPOM(
       idcupom  varchar(4),
       tipo varchar(10),
       valor real,
       PRIMARY KEY(idcupom)
);

CREATE TABLE COMPRA_ING(
       compra_ing timestamp,
       idcupom  varchar(4),
       cpf varchar(11) REFERENCES CLIENTE(cpf),
       codigo varchar(30) REFERENCES INGRESSO(codigo),
       qtd integer,
       PRIMARY KEY (compra_ing, cpf, codigo)
);

CREATE TABLE COMPRA_CONSU(
       compra_consu timestamp,
       idcupom  varchar(4),
       cpf varchar(11) REFERENCES CLIENTE(cpf),
       codigo varchar(30) REFERENCES CONSUMIVEL(codigo),
       qtd integer,
       PRIMARY KEY (compra_consu, cpf, codigo)
);

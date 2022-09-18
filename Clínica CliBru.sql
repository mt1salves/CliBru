CREATE SCHEMA CliBru;

USE CliBru;

CREATE TABLE Medico(
	idMedico INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	crm VARCHAR (45) NOT NULL,
	nome VARCHAR (45) NOT NULL,
    sobrenome VARCHAR (45) NOT NULL
);

DESCRIBE Medico;

CREATE TABLE Atendente(
	idAtendente INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (45) NOT NULL,
    matricula VARCHAR (45) NOT NULL
);

DESCRIBE Atendente;

CREATE TABLE Paciente(
	idPaciente INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (45) NOT NULL,
    cpf VARCHAR (11) NOT NULL,
    nascimento DATE NOT NULL
);

DESCRIBE Paciente;

CREATE TABLE Especialidade(
	idEspecialidade INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (45) NOT NULL
);

DESCRIBE Especialidade;

CREATE TABLE Endereco(
	idEndereco INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR (45) NOT NULL,
    numero VARCHAR (45) NOT NULL,
    bairro VARCHAR (45) NOT NULL,
    cidade VARCHAR (45) NOT NULL,
    cep VARCHAR (45) NOT NULL,
    Paciente_idPaciente INT NOT NULL,
    FOREIGN KEY (Paciente_idPaciente) REFERENCES Paciente(idPaciente)
);

DESCRIBE Endereco;

CREATE TABLE Convenio(
	idConvenio INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (45) NOT NULL
);

DESCRIBE Convenio;

CREATE TABLE Consulta(
	Medico_idMedico INTEGER NOT NULL,
    Paciente_idPaciente INTEGER NOT NULL,
    Atendente_idAtendente INTEGER NOT NULL,
    data_marcada DATETIME NOT NULL,
    aconteceu TINYINT NOT NULL,
    FOREIGN KEY (Medico_idMedico) REFERENCES Medico(idMedico),
    FOREIGN KEY (Paciente_idPaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (Atendente_idAtendente) REFERENCES Atendente(idAtendente)
);

DESCRIBE Consulta;

CREATE TABLE Medico_has_Especialidade(
	Medico_idMedico INTEGER NOT NULL,
    Especialidade_idEspecialidade INTEGER NOT NULL,
	FOREIGN KEY (Medico_idMedico) REFERENCES Medico(idMedico),
	FOREIGN KEY (Especialidade_idEspecialidade) REFERENCES Especialidade(idEspecialidade)
);

DESCRIBE Medico_has_Especialidade;

CREATE TABLE Paciente_has_Convenio(
	Paciente_idPaciente INTEGER NOT NULL,
    Convenio_idConvenio INTEGER NOT NULL,
	FOREIGN KEY (Paciente_idPaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (Convenio_idConvenio) REFERENCES Convenio(idConvenio)
);

DESCRIBE Paciente_has_Convenio;

INSERT INTO Medico(idMedico, crm, nome, sobrenome)
VALUES (1, '123456-0/BR', 'Jackson', 'Avery'), (2, '123456-1/BR', 'Lucas', 'Santos'), (3, '123456-2/BR', 'Evandro', 'Torres');

INSERT INTO Atendente(idAtendente, nome, matricula)
VALUES (1, 'Tauane Carol', '202015210097'), (2, 'João Franco', '202015210017'), (3, 'José Augusto', '202015210023');

INSERT INTO Paciente(idPaciente, nome, cpf, nascimento)
VALUES (1, 'Pedro Otávio', '0123456789', '1994-02-23'), (2, 'Antônio Miguel', '0192837465', '2007-05-12'), (3, 'Luís Henrique', '1029384756', '2000-07-28');

INSERT INTO Especialidade(idEspecialidade, nome)
VALUES (1, 'Otorrinolaringologia'), (2, 'Pediatria'), (3, 'Urologia');

INSERT INTO Endereco(idEndereco, logradouro, numero, bairro, cidade, cep, Paciente_idPaciente)
VALUES (1, 'Avenida Hormindo Francisco Gama', '170', 'Parque Alvorada', 'Brumado', '46100000', 1), (2, 'Rua José Alves da Silva', '230', 'Parque Alvorada', 'Brumado', '46100000', 2), (3, 'Rua Zélio Lima', '80', 'Parque Alvorada', 'Brumado', '46100000', 3);

INSERT INTO Convenio(idConvenio, nome)
VALUES (1, 'SulAmérica'), (2, 'Unimed'), (3, 'Hapvida');

INSERT INTO Consulta(Medico_idMedico, Paciente_idPaciente, Atendente_idAtendente, data_marcada, aconteceu)
VALUES (1, 1, 1, '2022-06-18 09:33:26', true), (2, 2, 2, '2022-07-19 10:34:27', true), (3, 3, 3, '2022-08-22 11:35:28', true);

INSERT INTO Medico_has_Especialidade(Medico_idMedico, Especialidade_idEspecialidade)
VALUES (1, 1), (2, 2), (3, 3);

INSERT INTO Paciente_has_Convenio(Paciente_idPaciente, Convenio_idConvenio)
VALUES (1, 1), (2, 2), (3, 3);

SELECT * FROM Medico;

SELECT * FROM Atendente;

SELECT * FROM Paciente;

SELECT * FROM Especialidade;

SELECT * FROM Endereco;

SELECT * FROM Convenio;

SELECT * FROM Consulta;

SELECT * FROM Medico_has_Especialidade;

SELECT * FROM Paciente_has_Convenio;

SELECT
	p.nome AS 'Nome do Paciente',
    p.cpf AS 'CPF',
    p.nascimento AS 'Data de Nascimento',
    c.data_marcada AS 'Data Marcada',
    c.aconteceu AS 'Aconteceu'
FROM Paciente p
INNER JOIN Consulta c
ON p.idPaciente = c.Paciente_idPaciente;

SELECT
	p.nome AS 'Nome do Paciente',
    p.cpf AS 'CPF',
    p.nascimento AS 'Data de Nascimento',
	m.crm AS 'CRM',
    m.nome AS 'Nome do Médico',
    m.sobrenome AS 'Sobrenome do Médico',
    c.data_marcada AS 'Data Marcada',
    c.aconteceu AS 'Aconteceu'
FROM Paciente p
INNER JOIN Consulta c
ON p.idPaciente = c.Paciente_idPaciente
INNER JOIN Medico m
ON m.idMedico = c.Medico_idMedico;

SELECT
	m.crm AS 'CRM',
    m.nome AS 'Nome do Médico',
    m.sobrenome AS 'Sobrenome do Médico',
    e.nome AS 'Especialidade Médica'
FROM Medico m
INNER JOIN Medico_has_Especialidade mhe
ON m.idMedico = mhe.Medico_idMedico
INNER JOIN Especialidade e
ON e.idEspecialidade = mhe.Especialidade_idEspecialidade;

SELECT
	p.nome AS 'Nome do Paciente',
    p.cpf AS 'CPF',
    p.nascimento AS 'Data de Nascimento',
    c.nome AS 'Convênio'
FROM Paciente p
INNER JOIN Paciente_has_Convenio phc
ON p.idPaciente = phc.Paciente_idPaciente
INNER JOIN Convenio c
ON c.idConvenio = phc.Convenio_idConvenio;

SELECT
	p.nome 'Nome do Paciente',
    p.cpf AS 'CPF',
    p.nascimento AS 'Data de Nascimento',
    e.logradouro AS 'Logradouro',
    e.numero AS 'Número',
    e.bairro 'Bairro',
    e.cidade AS 'Cidade',
    e.cep AS 'CEP'
FROM Paciente p
INNER JOIN Endereco e
ON p.idPaciente = e.Paciente_idPaciente;
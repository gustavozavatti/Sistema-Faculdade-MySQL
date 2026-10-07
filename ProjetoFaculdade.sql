CREATE DATABASE faculdade;
USE faculdade;

CREATE TABLE aluno(
	rgm INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN('M','F')) NOT NULL,
    datanascimento DATE NOT NULL,
    endereco VARCHAR(100) NOT NULL
);
CREATE TABLE telefone(
	id INT PRIMARY KEY AUTO_INCREMENT,
    alunorgm int NOT NULL,
    numero VARCHAR(20) NOT NULL,
    FOREIGN KEY (alunorgm) REFERENCES aluno(rgm)
);
CREATE TABLE nativo(
    alunorgm INT PRIMARY KEY,
    cpf VARCHAR(20) NOT NULL UNIQUE,
    rg VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (alunorgm) REFERENCES aluno(rgm)
);
CREATE TABLE estrangeiro(
    alunorgm INT PRIMARY KEY,
    passaporte VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (alunorgm) REFERENCES aluno(rgm)
);
CREATE TABLE pagamento(
	id INT PRIMARY KEY AUTO_INCREMENT,
    alunorgm INT NOT NULL,
    forma VARCHAR(30) NOT NULL,
    valortotal DECIMAL(10,2) CHECK(valortotal > 0) NOT NULL,
    FOREIGN KEY (alunorgm) REFERENCES aluno(rgm)
);
CREATE TABLE professor(
	matricula INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	sexo CHAR(1) CHECK (sexo IN('M','F')) NOT NULL,
	datanascimento DATE NOT NULL,
	endereco VARCHAR(100) NOT NULL
);
CREATE TABLE telefoneprofessor(
	id INT PRIMARY KEY AUTO_INCREMENT,
    professormatricula int NOT NULL,
    numero VARCHAR(20) NOT NULL,
    FOREIGN KEY (professormatricula) REFERENCES professor(matricula)
);
CREATE TABLE disciplina(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    quantidadehoras INT CHECK(quantidadehoras > 0) NOT NULL,
    sala INT NOT NULL
);
CREATE TABLE grade (
    id INT PRIMARY KEY AUTO_INCREMENT,
    disciplinaid INT NOT NULL,
    professormatricula INT NOT NULL,
    FOREIGN KEY (disciplinaid) REFERENCES disciplina(id),
    FOREIGN KEY (professormatricula) REFERENCES professor(matricula),
    UNIQUE(disciplinaid, professormatricula)
);
CREATE TABLE turma(
	id INT PRIMARY KEY AUTO_INCREMENT,
    semestre TINYINT NOT NULL,
    ano YEAR NOT NULL,
    periodo VARCHAR(20) NOT NULL,
	UNIQUE(semestre, ano, periodo)
);
CREATE TABLE matricula(
    id INT PRIMARY KEY AUTO_INCREMENT,
    alunorgm INT NOT NULL,
    turmaid INT NOT NULL,
    disciplinaid INT NOT NULL,
    estado VARCHAR(20) CHECK (estado IN('Ativo', 'Trancado', 'Cancelado')) NOT NULL,
    valormensalidade DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (alunorgm) REFERENCES aluno(rgm),
    FOREIGN KEY (disciplinaid) REFERENCES disciplina(id),
    FOREIGN KEY (turmaid) REFERENCES turma(id),
    UNIQUE(alunorgm, turmaid, disciplinaid)
);
CREATE TABLE reserva(
	id INT PRIMARY KEY AUTO_INCREMENT,
    alunorgm INT NOT NULL,
    FOREIGN KEY (alunorgm) REFERENCES aluno(rgm)
);
CREATE TABLE instrutor(
	matricula INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN('M','F')) NOT NULL,
    datanascimento DATE NOT NULL,
    endereco VARCHAR(100) NOT NULL
);
CREATE TABLE academia(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	instrutormatricula INT,
    FOREIGN KEY (instrutormatricula) REFERENCES instrutor(matricula)
);
CREATE TABLE natacao(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	instrutormatricula INT,
    FOREIGN KEY (instrutormatricula) REFERENCES instrutor(matricula)
);
CREATE TABLE academiareserva(
	academiaid INT NOT NULL,
    reservaid INT NOT NULL,
    datahora DATETIME NOT NULL,
    FOREIGN KEY (reservaid) REFERENCES reserva(id),
    FOREIGN KEY (academiaid) REFERENCES academia(id),
    PRIMARY KEY(academiaid, reservaid, datahora) 
);
CREATE TABLE natacaoreserva(
	natacaoid INT NOT NULL,
    reservaid INT NOT NULL,
    datahora DATETIME NOT NULL,
    FOREIGN KEY (reservaid) REFERENCES reserva(id),
    FOREIGN KEY (natacaoid) REFERENCES natacao(id),
    PRIMARY KEY(natacaoid, reservaid, datahora) 
);

INSERT INTO  aluno(nome, sexo, datanascimento, endereco)
VALUES
('Oswaldo Cruz', 'M', '2007-12-09','Rua Afonso Pena'),
('Gustavo Lima', 'M', '2007-12-17', 'Rua da Espanha'),
('Mônica de Souza', 'F', '2006-06-02', 'Rua dos Limoeiros'),
('Willian Bonner', 'M', '2005-12-10', 'Avenida dos Prédios Altos'),
('Vitor Roque', 'M', '1990-09-09', 'Avenida Manoel Ribas'),
('Marie Curie', 'F', '2000-10-12', 'Paris Tower'),
('Flaco López', 'M', '1995-01-17', 'Avenida das Torres'),
('Michael Jackson', 'M', '1986-03-19', 'Mannig Dr'),
('Ariana Pequena', 'F', '1999-07-05', 'Texas Route 66'),
('Terry Rock Julis', 'M', '1980-08-04', 'Casa do Patrick Estrela');

INSERT INTO telefone(alunorgm, numero)
VALUES
(1, '+55 (11) 99120-2342'),
(3, '+55 (12) 98573-4673'),
(7, '+01 (23) 99258-4213'),
(8, '+11 (09) 99425-2143'),
(10,'+11 (21) 92481-7893');

INSERT INTO nativo(alunorgm, cpf, rg)
VALUES
(1, '847194-184', '103.141.141-32'),
(2, '274252-141', '741.814.149-48'),
(3, '275254-414', '252.141.252-14'),
(4, '614565-145', '184.815.448-76'),
(5, '754755-525', '717.418.185-93');

INSERT INTO estrangeiro(alunorgm, passaporte)
VALUES
(6, '1475757-34'),
(7, '4715165-59'),
(8, '2814114-69'),
(9, '5885404-12'),
(10, '8415484-41');

INSERT INTO pagamento(alunorgm, forma, valortotal) VALUES
(1, 'Cartão de Crédito', 500.00),
(2, 'Boleto', 450.00),
(5, 'Pix', 600.00),
(8, 'Cartão de Débito', 500.00),
(10, 'Boleto', 650.00);        


INSERT INTO professor(nome, sexo, datanascimento, endereco)
VALUES
('Harry Kane', 'M', '1999-12-12', 'Rua Marechal Deodoro'),
('Thomas Sheby', 'M', '1990-03-05', 'Birmingham Street'),
('Mark Zukenberg', 'M', '1986-08-13', 'Vale do Silício'),
('Albert Einstein', 'M', '1975-04-12', 'Dortmand'),
('Enaldo Pererira', 'M', '1970-07-22', 'Bairro Itaqui');

INSERT INTO telefoneprofessor(professormatricula, numero)
VALUES
(1, '+55 (41) 98424-1415'),
(2, '+21 (55) 99241-6412'),
(2, '+55 (41) 95125-7213'),
(3, '+65 (75) 91414-5156'),
(5, '+55 (41) 96841-7875');

INSERT INTO disciplina(nome, quantidadehoras, sala)
VALUES
('Banco de Dados', 60, 209),
('Matemática na Economia', 120, 80),
('Marketing em Sites', 60, 14),
('Física 1', 120, 76),
('Governos e Poderes', 80, 194);

INSERT INTO grade(disciplinaid, professormatricula)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

INSERT INTO turma(semestre, ano, periodo)
VALUES
(2, 2025, 'Matutino'),
(3, 2025, 'Noturno'),
(3, 2025, 'Matutino'),
(6, 2025, 'Noturno'),
(8, 2025, 'Tarde'); 

INSERT INTO matricula(alunorgm, disciplinaid, turmaid, estado, valormensalidade)
VALUES
(1, 4, 1, 'Ativo', 500.00),  
(2, 3, 2, 'Ativo', 450.00), 
(3, 2, 1, 'Ativo', 480.00),
(4, 5, 2, 'Ativo', 470.00),
(5, 1, 3, 'Trancado', 550.00),
(6, 4, 3, 'Ativo', 500.00),
(7, 3, 4, 'Ativo', 460.00),
(8, 2, 4, 'Cancelado', 480.00),
(9, 1, 5, 'Ativo', 520.00),
(10, 5, 5, 'Ativo', 600.00);

INSERT INTO reserva(alunorgm)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO instrutor(nome, sexo, datanascimento, endereco)
VALUES
('The Rock', 'M', '1999-07-13', 'Selva de Jumanji'),
('Rocky Balboa', 'M', '1987-09-09', 'Escadaria da Filadélfia'),
('Júlio Balestrin', 'M', '1987-10-13', 'Ironberg'),
('Renato Cariani', 'M', '1999-01-15', 'Ironberg' ),
('Jackie Chan', 'M', '1965-04-07', 'Hong Kong Street'),
('Patrick Estrela', 'M', '2000-11-24', 'Fenda do Biquíni'),
('Poseidon', 'M', '1999-01-01', 'Palácio Submerso'),
('Peixe Nemo', 'M', '1978-12-12', 'Coral na Fenda do Biquíni'),
('Aquaman', 'M', '1983-01-29', 'Atlântida'),
('Squirtle', 'M', '1996-02-27', 'Kanto'),
('Abel Ferreira', 'M', '1999-02-08', 'Allianz Park');

INSERT INTO academia(instrutormatricula)
VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO natacao(instrutormatricula)
VALUES
(6),
(7),
(8),
(9),
(10);

INSERT INTO academiareserva(academiaid, reservaid, datahora)
VALUES
(1, 1, '2025-10-06 08:00:00'),
(2, 2, '2025-10-06 09:00:00'),
(3, 3, '2025-10-06 10:00:00'),
(4, 4, '2025-10-06 11:00:00'),
(5, 5, '2025-10-06 12:00:00');

INSERT INTO natacaoreserva(natacaoid, reservaid, datahora)
VALUES
(1, 6, '2025-10-07 08:00:00'),
(2, 7, '2025-10-07 09:00:00'),
(3, 8, '2025-10-07 10:00:00'),
(4, 9, '2025-10-07 11:00:00'),
(5, 10, '2025-10-07 12:00:00');

-- Necessidade 1: Listar o nome e a data de nascimento de todos os alunos que nasceram após o ano de 2000.
SELECT nome AS Nome, datanascimento AS DataNascimento
FROM aluno
WHERE YEAR(datanascimento) > 2000;

-- Necessidade 2: Mostrar o nome e o número de telefone de cada aluno cadastrado no sistema.
SELECT aluno.nome AS Nome, telefone.numero AS Telefone
FROM aluno
INNER JOIN telefone
ON telefone.alunorgm = aluno.rgm;

-- Necessidade 3: Exibir o nome dos alunos e o valor total de seus pagamentos, ordenados do maior para o menor valor.
SELECT aluno.nome AS Nome, pagamento.valortotal AS Valor
FROM aluno
INNER JOIN pagamento
ON pagamento.alunorgm = aluno.rgm
ORDER BY pagamento.valortotal DESC;

-- Necessidade 4: Listar todos os professores e seus números e as disciplinas que cada um ministra.
SELECT  professor.nome AS Nome, IF(telefoneprofessor.numero IS NULL, 'Não possui', telefoneprofessor.numero) AS Telefone, IF(disciplina.nome IS NULL, 'Não ministra', disciplina.nome) AS Disciplina
FROM professor
LEFT JOIN telefoneprofessor
ON telefoneprofessor.professormatricula = professor.matricula
LEFT JOIN grade
ON grade.professormatricula = professor.matricula
LEFT JOIN disciplina
ON grade.disciplinaid = disciplina.id;

-- Necessidade 5: Mostrar as turmas cadastradas, exibindo o semestre, ano e período de cada uma.
SELECT semestre AS Semestre, ano AS Ano, periodo AS Periodo FROM turma;

-- Necessidade 6: Exibir a quantidade total de alunos matriculados em cada disciplina.
SELECT disciplina.nome AS Disciplina, COUNT(matricula.alunorgm) AS TotalAlunos
FROM disciplina
LEFT JOIN matricula 
ON matricula.disciplinaid = disciplina.id
GROUP BY disciplina.id, disciplina.nome
ORDER BY TotalAlunos DESC;

-- Necessidade 7: Liste os nomes dos alunos, sua disciplina, o estado da matrícula e valor da mensalidade.
SELECT aluno.nome AS Nome, disciplina.nome AS Disciplina, matricula.estado AS Estado, matricula.valormensalidade AS Valor
FROM aluno
INNER JOIN matricula
ON matricula.alunorgm = aluno.rgm
INNER JOIN disciplina
ON disciplina.id = matricula.disciplinaid;

-- Necessidade 8: Liste os alunos e mostre seu cpf e rg, ou passaporte se estrangeiro. 
SELECT aluno.nome, IF(nativo.rg IS NULL, 'Não possui', nativo.rg) AS RG, IF(nativo.cpf IS NULL, 'Não possui', nativo.cpf) AS CPF, IF(estrangeiro.passaporte IS NULL, 'Não possui', estrangeiro.passaporte) AS Passaporte
FROM aluno
LEFT JOIN nativo
ON nativo.alunorgm = aluno.rgm
LEFT JOIN estrangeiro
ON estrangeiro.alunorgm = aluno.rgm;
    
-- Necessidade 9: Listar todos os instrutores e o tipo de serviço (academia ou natação) em que cada um atua.
SELECT instrutor.nome, IF(natacao.instrutormatricula IS NULL, 'Não atua', 'Atua') AS Natação, IF(academia.instrutormatricula IS NULL, 'Não atua', 'Atua') AS Academia
FROM instrutor
LEFT JOIN natacao
ON natacao.instrutormatricula = instrutor.matricula
LEFT JOIN academia
ON academia.instrutormatricula = instrutor.matricula;

-- Necessidade 10: Exibir os horários de reservas realizadas na academia e na natação, junto com o nome do aluno responsável.
SELECT aluno.nome, IF(academiareserva.datahora IS NULL, 'Sem reserva', academiareserva.datahora) AS Academia, IF(natacaoreserva.datahora IS NULL, 'Sem reserva', natacaoreserva.datahora) AS Natacao
FROM aluno
INNER JOIN reserva
ON reserva.alunorgm = aluno.rgm
LEFT JOIN academiareserva
ON academiareserva.reservaid = reserva.id
LEFT JOIN natacaoreserva
ON natacaoreserva.reservaid = reserva.id;

-- Necessidade 11: Aumentar as mensalidades em 20% e mostrar o nome dos alunos com os novos valores em ordem decrescente.
UPDATE matricula 
SET valormensalidade = valormensalidade * 1.2;

SELECT aluno.nome AS Nome, matricula.valormensalidade AS Valor
FROM aluno
INNER JOIN matricula
ON matricula.alunorgm = aluno.rgm
INNER JOIN disciplina
ON disciplina.id = matricula.disciplinaid
ORDER BY matricula.valormensalidade DESC;

-- Necessidade 12: O personal Rocky Balboa está se aposentando tire ele do sistema e mostre os instrutores restantes.

DELETE instrutor
FROM instrutor
WHERE instrutor.nome = 'Rocky Balboa';

SELECT *
FROM instrutor;
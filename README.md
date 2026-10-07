# 🏫 Projeto SQL — Sistema de Faculdade

Um projeto de banco de dados desenvolvido em **MySQL**, criado para praticar conceitos de modelagem, criação de tabelas, relacionamentos, consultas SQL, inserção e manipulação de dados.

## 📚 Sobre o projeto

Este projeto consiste na criação de um banco de dados para representar diferentes informações relacionadas ao funcionamento de uma **faculdade**.

O banco foi desenvolvido buscando aplicar, na prática, conceitos estudados em **Banco de Dados**, como:

* Criação de tabelas
* Chaves primárias e estrangeiras
* Relacionamentos entre tabelas
* Restrições de dados
* Inserção de registros
* Consultas SQL
* `JOIN`
* `GROUP BY`
* `COUNT`
* `ORDER BY`
* `UPDATE`
* `DELETE`

O projeto também possui diferentes entidades relacionadas a alunos, professores, disciplinas, turmas, matrículas, pagamentos e reservas.

## 🛠️ Tecnologias

| Tecnologia | Utilização                                            |
| ---------- | ----------------------------------------------------- |
| **MySQL**  | Criação e gerenciamento do banco de dados             |
| **SQL**    | Criação das tabelas, inserção e manipulação dos dados |
| **Git**    | Controle de versão do projeto                         |
| **GitHub** | Armazenamento e gerenciamento do projeto              |

## 🗄️ Estrutura do banco

O banco de dados utilizado no projeto é:

```sql
faculdade
```

Entre as principais tabelas estão:

| Tabela              | Descrição                                     |
| ------------------- | --------------------------------------------- |
| `aluno`             | Armazena os dados dos alunos                  |
| `telefone`          | Telefones relacionados aos alunos             |
| `nativo`            | Informações adicionais de alunos brasileiros  |
| `estrangeiro`       | Informações adicionais de alunos estrangeiros |
| `pagamento`         | Registros de pagamentos                       |
| `professor`         | Dados dos professores                         |
| `telefoneprofessor` | Telefones dos professores                     |
| `disciplina`        | Disciplinas oferecidas                        |
| `grade`             | Relação entre disciplinas e professores       |
| `turma`             | Turmas cadastradas                            |
| `matricula`         | Matrículas dos alunos                         |
| `reserva`           | Reservas realizadas                           |
| `instrutor`         | Dados dos instrutores                         |
| `academia`          | Informações relacionadas à academia           |
| `natacao`           | Informações relacionadas à natação            |
| `academiareserva`   | Relação entre reservas e academia             |
| `natacaoreserva`    | Relação entre reservas e natação              |

## 🔗 Relacionamentos

O banco utiliza **chaves estrangeiras (`FOREIGN KEY`)** para relacionar as diferentes tabelas.

Dessa forma, informações de diferentes partes do sistema podem ser relacionadas através das consultas SQL.

Alguns exemplos de relações utilizadas no projeto:

* Alunos → Telefones
* Alunos → Matrículas
* Alunos → Pagamentos
* Professores → Disciplinas
* Disciplinas → Turmas
* Alunos → Reservas
* Instrutores → Academia
* Instrutores → Natação
* Reservas → Academia
* Reservas → Natação

## 📊 Dados inseridos

Após a criação das tabelas, o projeto realiza a inserção de dados para permitir a realização dos testes e consultas.

Foram cadastrados dados relacionados a:

* 👨‍🎓 Alunos
* 👨‍🏫 Professores
* 📚 Disciplinas
* 🏫 Turmas
* 📝 Matrículas
* 💰 Pagamentos
* 📞 Telefones
* 🏊 Natação
* 🏋️ Academia
* 👤 Instrutores
* 📅 Reservas

## 🔎 Consultas e operações

O projeto possui uma série de consultas para praticar diferentes comandos SQL.

### 👨‍🎓 Consulta de alunos

Uma das consultas realiza a busca de alunos que nasceram após o ano de 2000.

```sql
SELECT nome AS Nome, datanascimento AS DataNascimento
FROM aluno
WHERE YEAR(datanascimento) > 2000;
```

### 📞 Alunos e telefones

Também é realizada uma consulta relacionando alunos e seus respectivos telefones.

```sql
SELECT aluno.nome AS Nome, telefone.numero AS Telefone
FROM aluno
INNER JOIN telefone
ON telefone.alunorgm = aluno.rgm;
```

### 💰 Pagamentos

Os pagamentos são consultados e organizados em ordem decrescente de valor.

```sql
SELECT aluno.nome AS Nome, pagamento.valortotal AS Valor
FROM aluno
INNER JOIN pagamento
ON pagamento.alunorgm = aluno.rgm
ORDER BY pagamento.valortotal DESC;
```

### 👨‍🏫 Professores, telefones e disciplinas

O projeto também realiza uma consulta para listar os professores, seus telefones e as disciplinas que cada professor ministra.

São utilizados `LEFT JOIN` para permitir que professores sem telefone ou disciplina também apareçam no resultado.

### 🏫 Turmas

Também é possível consultar as turmas cadastradas, mostrando:

* Semestre
* Ano
* Período

### 📚 Contagem de alunos por disciplina

O projeto utiliza `COUNT` e `GROUP BY` para descobrir a quantidade de alunos matriculados em cada disciplina.

```sql
SELECT disciplina.nome AS Disciplina,
       COUNT(matricula.alunorgm) AS TotalAlunos
FROM disciplina
LEFT JOIN matricula 
ON matricula.disciplinaid = disciplina.id
GROUP BY disciplina.id, disciplina.nome
ORDER BY TotalAlunos DESC;
```

### 🔗 Alunos, disciplinas e matrículas

Também é realizada uma consulta relacionando:

* Nome do aluno
* Disciplina
* Estado da matrícula
* Valor da mensalidade

Essas informações são obtidas através de `JOIN` entre as tabelas `aluno`, `matricula` e `disciplina`.

### 🌎 Alunos nativos e estrangeiros

O projeto também consulta os documentos dos alunos, mostrando:

* RG
* CPF
* Passaporte

São utilizados `LEFT JOIN` entre as tabelas `aluno`, `nativo` e `estrangeiro`.

### 🏋️ Instrutores

Também é realizada uma consulta para identificar se cada instrutor atua em:

* Academia
* Natação

A consulta utiliza `LEFT JOIN` e `IF` para indicar se o instrutor atua ou não em cada serviço.

### 📅 Reservas

O projeto consulta os horários das reservas realizadas na academia e na natação, juntamente com o nome do aluno responsável.

São utilizadas as tabelas:

* `aluno`
* `reserva`
* `academiareserva`
* `natacaoreserva`

## ✏️ Atualização de dados

O projeto também pratica a alteração de informações já cadastradas.

Uma das operações realiza um aumento de **20% no valor das mensalidades**:

```sql
UPDATE matricula 
SET valormensalidade = valormensalidade * 1.2;
```

Após a atualização, os alunos e seus novos valores de mensalidade são exibidos em ordem decrescente.

## 🗑️ Exclusão de dados

Também foi realizada uma operação de exclusão utilizando `DELETE`.

No projeto, o instrutor **Rocky Balboa** é removido do sistema:

```sql
DELETE instrutor
FROM instrutor
WHERE instrutor.nome = 'Rocky Balboa';
```

Após a exclusão, os instrutores restantes são exibidos através de uma nova consulta.

## 🧠 Conceitos praticados

| Conceito          | Aplicação no projeto                            |
| ----------------- | ----------------------------------------------- |
| `CREATE DATABASE` | Criação do banco de dados                       |
| `CREATE TABLE`    | Criação das tabelas                             |
| `PRIMARY KEY`     | Identificação única dos registros               |
| `FOREIGN KEY`     | Relacionamento entre tabelas                    |
| `AUTO_INCREMENT`  | Geração automática de IDs                       |
| `NOT NULL`        | Obrigatoriedade de informações                  |
| `UNIQUE`          | Evita valores duplicados                        |
| `CHECK`           | Validação de determinadas informações           |
| `INSERT`          | Inserção de registros                           |
| `SELECT`          | Consulta dos dados                              |
| `JOIN`            | Relacionamento entre tabelas                    |
| `LEFT JOIN`       | Consulta mantendo registros sem correspondência |
| `WHERE`           | Filtragem de registros                          |
| `ORDER BY`        | Ordenação dos resultados                        |
| `GROUP BY`        | Agrupamento dos dados                           |
| `COUNT`           | Contagem de registros                           |
| `IF`              | Verificação de condições                        |
| `UPDATE`          | Atualização de dados                            |
| `DELETE`          | Exclusão de registros                           |
| `YEAR`            | Manipulação do ano de uma data                  |

## 🎯 Objetivo

O principal objetivo do projeto é **praticar SQL e conceitos de banco de dados através da criação de um sistema acadêmico**.

O desenvolvimento permitiu trabalhar desde a criação das tabelas e seus relacionamentos até a realização de consultas, atualizações e exclusões de dados.

Durante o desenvolvimento foram aplicados conceitos como:

* Estruturação de banco de dados
* Criação de tabelas
* Chaves primárias
* Chaves estrangeiras
* Relacionamentos
* Inserção de dados
* Consultas SQL
* `JOIN`
* `GROUP BY`
* `COUNT`
* `ORDER BY`
* `UPDATE`
* `DELETE`
* Validação de dados

Este projeto faz parte dos meus estudos em **Ciência da Computação**, servindo como prática dos conceitos de **Banco de Dados e MySQL**.

## 📌 Status

🚧 **Projeto desenvolvido para fins de estudo.**

---

⭐ Desenvolvido durante meus estudos de **MySQL, SQL e Ciência da Computação**.

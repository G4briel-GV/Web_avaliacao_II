-- ESSE SCRIPT FOI FEITO NO DIA 26/11 PARA POPULAR O BANCO DE DADOS COM DADOS DO ALUNO E MENTOR,
-- PARA Q POSTERIORMENTE EU CONSEGUISSE BUSCAR OS REGISTRO PELO DROPDOWNLIST NA TELA DE AGENDAR MENTORIA
SELECT * FROM Aluno;
SELECT * FROM Disponibilidade;
SELECT * FROM Materia;
SELECT * FROM Mentoria;


INSERT INTO Usuario (email, senha)
VALUES ('teste.mentor@fatec.br', '123456');

INSERT INTO Aluno (id_usuario, matricula, mentor, nome)
VALUES (1, '1000000001', 'N', 'Aluno Teste');

INSERT INTO Aluno (id_usuario, matricula, mentor, nome)
VALUES (2, '1000000002', 'S', 'Mentor Teste');


INSERT INTO Materia (nome)
VALUES ('Banco de Dados');


INSERT INTO mentor_materia (id_aluno, id_materia)
SELECT TOP 1 a.id_aluno, m.id_materia
FROM Aluno a
CROSS JOIN Materia m
WHERE a.mentor = 'S'
  AND a.nome = 'Mentor Teste'
  AND m.nome = 'Banco de Dados'
ORDER BY a.id_aluno DESC, m.id_materia DESC;


DECLARE @IdMentor INT = (
    SELECT TOP 1 id_aluno
    FROM Aluno
    WHERE mentor = 'S' AND nome = 'Mentor Teste'
    ORDER BY id_aluno DESC
);

EXEC InserirDisponibilidade
    @dia_semana = 'qui',
    @inicio = '19:00:00',
    @fim = '21:00:00',
    @id_aluno = @IdMentor;

SELECT * FROM Usuario;
SELECT * FROM Aluno;
SELECT * FROM Materia;
SELECT * FROM mentor_materia;
SELECT * FROM Disponibilidade;
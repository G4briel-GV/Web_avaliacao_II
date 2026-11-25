CREATE PROCEDURE InserirDisponibilidade
    @dia_semana NVARCHAR(50),
    @inicio     TIME,
    @fim        TIME,
    @id_aluno   INT
AS
BEGIN
    INSERT INTO Disponibilidade (dia_semana, hora_inicio, hora_fim, id_aluno)
    VALUES (@dia_semana, @inicio, @fim, @id_aluno);
END
GO
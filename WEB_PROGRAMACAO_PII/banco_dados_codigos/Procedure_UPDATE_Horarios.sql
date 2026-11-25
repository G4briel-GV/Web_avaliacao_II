CREATE PROCEDURE AtualizarDisponibilidade
    @id_disponibilidade INT,
    @dia_semana         NVARCHAR(50),
    @inicio             TIME,
    @fim                TIME,
    @id_aluno           INT
AS
BEGIN
    UPDATE Disponibilidade
    SET dia_semana = @dia_semana, hora_inicio = @inicio, hora_fim = @fim
    WHERE id_disponibilidade = @id_disponibilidade AND id_aluno = @id_aluno;
END
GO
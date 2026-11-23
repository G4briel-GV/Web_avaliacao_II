CREATE PROCEDURE RemoverDisponibilidade
    @id_disponibilidade INT,
    @id_aluno INT
AS
BEGIN
    DELETE FROM Disponibilidade
    WHERE id_disponibilidade=@id_disponibilidade AND id_aluno=@id_aluno;
END
GO
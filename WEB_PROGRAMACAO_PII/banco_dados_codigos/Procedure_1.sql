CREATE OR ALTER PROCEDURE ListarDisponibilidadeMentor
    @id_aluno INT
AS
BEGIN
    SELECT
        id_disponibilidade, dia_semana, inicio, fim FROM Disponibilidade
    WHERE id_aluno = @id_aluno
    ORDER BY
        CASE dia_semana
            WHEN 'seg' THEN 1
            WHEN 'ter' THEN 2
            WHEN 'qua' THEN 3
            WHEN 'qui' THEN 4
            WHEN 'sex' THEN 5
            WHEN 'sab' THEN 6
            WHEN 'dom' THEN 7
        END,
        inicio;
END
GO
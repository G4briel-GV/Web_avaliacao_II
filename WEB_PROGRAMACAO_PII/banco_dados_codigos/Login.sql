CREATE PROCEDURE ValidarLogin
    @email NVARCHAR(60),
    @senha NVARCHAR(50)
AS
BEGIN
    SELECT
        Usuario.id_usuario,
        id_aluno,
        mentor,
        id_coordenacao
    FROM Usuario
    LEFT JOIN Aluno        ON Aluno.id_usuario = Usuario.id_usuario
    LEFT JOIN Coordenacao  ON Coordenacao.id_usuario = Usuario.id_usuario
    WHERE Usuario.email = @email AND Usuario.senha = @senha;
END
GO
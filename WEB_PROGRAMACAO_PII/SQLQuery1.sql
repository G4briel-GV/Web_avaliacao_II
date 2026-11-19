CREATE TABLE Usuario (
    id_usuario  INT           NOT NULL PRIMARY KEY,
    email       NCHAR(60)     NOT NULL,
    senha       NCHAR(50)     NOT NULL
);

CREATE TABLE Aluno (
    id_aluno    INT           NOT NULL PRIMARY KEY,
    id_usuario  INT           NOT NULL,
    matricula   NCHAR(10)     NOT NULL,
    mentor      NCHAR(1)      NOT NULL,
    nome        NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Aluno_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Coordenacao (
    id_coordenacao INT NOT NULL,
    id_usuario     INT NOT NULL,
    CONSTRAINT FK_Coordenacao_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Curso (
    id_curso    INT           NOT NULL PRIMARY KEY,
    nome        NVARCHAR(50)  NOT NULL,
    sigla       NVARCHAR(2)   NULL,
    periodo     INT           NOT NULL
);

CREATE TABLE Materia (
    id_materia  INT           NOT NULL PRIMARY KEY,
    nome        NVARCHAR(50)  NOT NULL
);

CREATE TABLE Aluno_Curso (
    id_aluno_curso INT NOT NULL PRIMARY KEY,
    id_aluno       INT NOT NULL,
    id_curso       INT NOT NULL,
    CONSTRAINT FK_Aluno_Curso_Aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_Aluno_Curso_Curso FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Curso_Materia (
    id_curso_materia INT NOT NULL PRIMARY KEY,
    id_curso         INT NOT NULL,
    id_materia       INT NOT NULL,
    CONSTRAINT FK_Curso_Materia_Curso   FOREIGN KEY (id_curso)   REFERENCES Curso(id_curso),
    CONSTRAINT FK_Curso_Materia_Materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE mentor_materia (
    id_mentor_materia INT NOT NULL PRIMARY KEY,
    id_aluno          INT NOT NULL,
    id_materia        INT NOT NULL,
    CONSTRAINT FK_mentor_materia_Aluno   FOREIGN KEY (id_aluno)   REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_mentor_materia_Materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE Disponibilidade (
    id_disponibilidade INT          NOT NULL PRIMARY KEY,
    dia_semana         NVARCHAR(50) NOT NULL,
    inicio             TIME(7)      NOT NULL,
    fim                TIME(7)      NOT NULL,
    id_aluno           INT          NOT NULL,
    CONSTRAINT FK_Disponibilidade_Aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);

CREATE TABLE Mentoria (
    id_mentoria  INT          NOT NULL PRIMARY KEY,
    status       NVARCHAR(50) NOT NULL,
    data         DATE         NOT NULL,
    hora_inicio  TIME(7)      NOT NULL,
    hora_final   TIME(7)      NOT NULL,
    id_aluno     INT          NOT NULL,
    id_mentor    INT          NOT NULL,
    id_materia   INT          NOT NULL,
    CONSTRAINT FK_Mentoria_Aluno   FOREIGN KEY (id_aluno)   REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_Mentoria_Aluno1  FOREIGN KEY (id_mentor)  REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_Mentoria_Materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);
GO
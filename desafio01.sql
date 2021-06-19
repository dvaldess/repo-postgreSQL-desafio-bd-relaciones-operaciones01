\c postgres
DROP DATABASE blog;

CREATE DATABASE blog;

\c blog

CREATE TABLE usuarios(
    id SERIAL,
    email VARCHAR(50),
    PRIMARY KEY(id)
);

CREATE TABLE posts(
    id INT,
    usuario_id INT,
    titulo VARCHAR(200),
    fecha DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios(
    id INT,
    usuario_id INT,
    post_id INT,
    texto VARCHAR,
    fecha DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(post_id) REFERENCES posts(id),
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

-- Cargando datos de forma manual

INSERT INTO usuarios (email) VALUES ('usuario01@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario02@gmail.com');
INSERT INTO usuarios (email) VALUES ('usuario03@gmail.com');
INSERT INTO usuarios (email) VALUES ('usuario04@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario05@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario06@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario07@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario08@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario09@yahoo.com');

-- Cargando datos de forma autoamtica y masiva

\copy posts FROM 'post.csv' csv header;
\copy comentarios FROM 'comentarios.csv' csv header;

SELECT email,id,titulo FROM usuarios where id=5;

-- Pregunta 4

SELECT email, u.id, titulo FROM usuarios u INNER JOIN posts ON u.id = posts.usuario_id WHERE u.id = 5;

-- Pregunta 5

SELECT u.email, com.id, com.texto FROM comentarios AS com INNER JOIN usuarios AS u ON u.id = com.usuario_id WHERE u.email != 'usuario06@hotmail.com';

-- Pregunta 6

SELECT * FROM usuarios U LEFT JOIN posts P ON U.id = P.usuario_id WHERE p.id is NULL;

-- Pregunta 7

SELECT * FROM posts p LEFT JOIN comentarios C ON p.id = C.post_id ORDER BY C.post_id ASC;

-- Pregunta 8

SELECT u.*, p.fecha FROM usuarios AS u INNER JOIN posts AS p ON u.id = p.usuario_id WHERE EXTRACT(MONTH FROM p.fecha) = 06;

SELECT * FROM usuarios JOIN posts ON usuarios.id = posts.usuario_id WHERE posts.fecha BETWEEN '2020-06-01' AND '2020-06-30';
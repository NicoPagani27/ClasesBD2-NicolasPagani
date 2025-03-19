CREATE DATABASE IF NOT EXISTS imdb;
USE imdb;

CREATE TABLE pelicula (
    id_pelicula INT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    año_de_estreno INT,
    CONSTRAINT PK_pelicula PRIMARY KEY (id_pelicula)
);

DROP TABLE IF EXISTS pelicula;

CREATE TABLE actor (
    id_actor INT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
     CONSTRAINT PK_actor PRIMARY KEY (id_actor)
);

CREATE TABLE actor_de_pelicula (
    id_actor INT,
    id_pelicula INT,
    PRIMARY KEY (id_actor, id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor) ON DELETE CASCADE,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula) ON DELETE CASCADE
);

ALTER TABLE pelicula ADD COLUMN last_update DATE;
ALTER TABLE actor ADD COLUMN last_update DATE;


INSERT INTO actor (id_actor, nombre, apellido) VALUES
(1, 'Leonardo', 'DiCaprio'),
(2, 'Scarlett', 'Johansson'),
(3, 'Tom', 'Hanks');

INSERT INTO pelicula (id_pelicula, titulo, descripcion, año_de_estreno) VALUES
(1, 'Inception', 'Un ladrón que roba secretos corporativos a través del uso de la tecnología de los sueños.', 2010),
(2, 'Lost in Translation', 'Una estrella de cine en declive y una joven solitaria forman una amistad en Tokio.', 2003),
(3, 'Forrest Gump', 'La historia de un hombre con una perspectiva única de la vida.', 1994);

INSERT INTO actor_de_pelicula (id_actor, id_pelicula) VALUES
(1, 1),
(2, 2), 
(3, 3); 


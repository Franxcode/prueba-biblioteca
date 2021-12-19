-- Se requiere modelar una base de datos para una biblioteca.
-- USE below structure to execute, make sure to change "user" by your database user.
-- psql < script.sql -U "user"
-- Parte 1 - Modelo Conceptual, Lógico y Físico, ver archivos adjuntos .png.
-- Parte 2 - Creando el modelo en la base de datos.

-- DROP DATABASE.
DROP DATABASE biblioteca;

-- 1) CREATE DATABASE.
CREATE DATABASE biblioteca;

-- Connect to the database.
\c biblioteca

-- 1) CREATE TABLES.

CREATE TABLE libro(
    isbn VARCHAR(15) PRIMARY KEY,
    titulo VARCHAR(25),
    numero_de_paginas INT
);

CREATE TABLE autor(
    codigo_autor INT PRIMARY KEY,
    nombre_autor VARCHAR(32),
    apellido_autor VARCHAR(32),
    fecha_de_nacimiento_autor VARCHAR(4),
    fecha_de_muerte_autor VARCHAR(4)
);

CREATE TABLE tipo_autor(
    id_tipo_autor SERIAL PRIMARY KEY,
    tipo_autor VARCHAR(25)
);

CREATE TABLE comuna(
    id_comuna SERIAL PRIMARY KEY,
    nombre_comuna VARCHAR(25)
);

CREATE TABLE socio(
rut VARCHAR(9) PRIMARY KEY,
nombre VARCHAR(32),
apellido VARCHAR(32),
direccion VARCHAR(64),
telefono INT,
comuna_id_comuna INT,
FOREIGN KEY (comuna_id_comuna) REFERENCES comuna(id_comuna)
);

CREATE TABLE prestamo(
id_prestamo SERIAL PRIMARY KEY,
fecha_inicio_del_prestamo DATE,
fecha_esperada_de_la_devolucion DATE,
fecha_real_de_la_devolucion DATE,
socio_rut VARCHAR(9),
libro_isbn VARCHAR(15),
FOREIGN KEY (socio_rut) REFERENCES socio(rut),
FOREIGN KEY (libro_isbn) REFERENCES libro(isbn)
);

CREATE TABLE autor_tiene_tipo_autor_en_libro(
    id_autor_tiene_tipo_autor_en_libro SERIAL PRIMARY KEY,
    libro_isbn VARCHAR(15),
    autor_codigo_autor INT,
    tipo_autor_id_tipo_autor INT,
    FOREIGN KEY (libro_isbn) REFERENCES libro(isbn),
    FOREIGN KEY (autor_codigo_autor) REFERENCES autor(codigo_autor),
    FOREIGN KEY (tipo_autor_id_tipo_autor) REFERENCES tipo_autor(id_tipo_autor)
);

-- 2) INSERT RECORDS INTO TABLES.

INSERT INTO libro(isbn, titulo, numero_de_paginas) VALUES ('111-1111111-111', 'CUENTOS DE TERROR', 344);
INSERT INTO libro(isbn, titulo, numero_de_paginas) VALUES ('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167); 
INSERT INTO libro(isbn, titulo, numero_de_paginas) VALUES ('333-3333333-333', 'HISTORIA DE ASIA', 511); 
INSERT INTO libro(isbn, titulo, numero_de_paginas) VALUES ('444-4444444-444', 'MANUAL DE MECÁNICA', 298); 

INSERT INTO autor(codigo_autor, nombre_autor, apellido_autor, fecha_de_nacimiento_autor, fecha_de_muerte_autor) VALUES (3, 'JOSE', 'SALGADO', '1968', '2020');
INSERT INTO autor(codigo_autor, nombre_autor, apellido_autor, fecha_de_nacimiento_autor, fecha_de_muerte_autor) VALUES (4, 'ANA', 'SALGADO', '1972', '');
INSERT INTO autor(codigo_autor, nombre_autor, apellido_autor, fecha_de_nacimiento_autor, fecha_de_muerte_autor) VALUES (1, 'ANDRES', 'ULLOA', '1982', '');
INSERT INTO autor(codigo_autor, nombre_autor, apellido_autor, fecha_de_nacimiento_autor, fecha_de_muerte_autor) VALUES (2, 'SERGIO', 'MARDONES', '1950', '2012');
INSERT INTO autor(codigo_autor, nombre_autor, apellido_autor, fecha_de_nacimiento_autor, fecha_de_muerte_autor) VALUES (5, 'MARTIN', 'PORTA', '1976', '');

INSERT INTO tipo_autor(id_tipo_autor, tipo_autor) VALUES (1, 'PRINCIPAL');
INSERT INTO tipo_autor(id_tipo_autor, tipo_autor) VALUES (2, 'COAUTOR');

INSERT INTO comuna(id_comuna, nombre_comuna) VALUES (1, 'SANTIAGO');

INSERT INTO socio(rut, nombre, apellido, direccion, telefono, comuna_id_comuna) VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1', 911111111, 1);
INSERT INTO socio(rut, nombre, apellido, direccion, telefono, comuna_id_comuna) VALUES ('2222222-2', 'ANA', 'PÉREZ', 'PASAJE 2', 922222222, 1);
INSERT INTO socio(rut, nombre, apellido, direccion, telefono, comuna_id_comuna) VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2', 933333333, 1);
INSERT INTO socio(rut, nombre, apellido, direccion, telefono, comuna_id_comuna) VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3', 944444444, 1);
INSERT INTO socio(rut, nombre, apellido, direccion, telefono, comuna_id_comuna) VALUES ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3', 955555555, 1);
 
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (1, '2020-01-20', '2020-01-27' , '2020-01-27', '1111111-1' , '111-1111111-111');
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (2, '2020-01-20', '2020-01-27' , '2020-01-30', '5555555-5' , '222-2222222-222');
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (3, '2020-01-22', '2020-01-29' , '2020-01-30', '3333333-3' , '333-3333333-333');
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (4, '2020-01-23', '2020-01-30' , '2020-01-30', '4444444-4' , '444-4444444-444');
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (5, '2020-01-27', '2020-02-03' , '2020-02-04', '2222222-2' , '111-1111111-111');
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (6, '2020-01-31', '2020-02-07' , '2020-02-12', '1111111-1' , '444-4444444-444');
INSERT INTO prestamo(id_prestamo, fecha_inicio_del_prestamo, fecha_esperada_de_la_devolucion, fecha_real_de_la_devolucion, socio_rut, libro_isbn) VALUES (7, '2020-01-31', '2020-02-07' , '2020-02-12', '3333333-3' , '222-2222222-222');

INSERT INTO autor_tiene_tipo_autor_en_libro(libro_isbn, autor_codigo_autor, tipo_autor_id_tipo_autor) VALUES ('111-1111111-111', 3, 1);
INSERT INTO autor_tiene_tipo_autor_en_libro(libro_isbn, autor_codigo_autor, tipo_autor_id_tipo_autor) VALUES ('111-1111111-111', 4, 2);
INSERT INTO autor_tiene_tipo_autor_en_libro(libro_isbn, autor_codigo_autor, tipo_autor_id_tipo_autor) VALUES ('222-2222222-222', 1, 1);
INSERT INTO autor_tiene_tipo_autor_en_libro(libro_isbn, autor_codigo_autor, tipo_autor_id_tipo_autor) VALUES ('333-3333333-333', 2, 1);
INSERT INTO autor_tiene_tipo_autor_en_libro(libro_isbn, autor_codigo_autor, tipo_autor_id_tipo_autor) VALUES ('444-4444444-444', 5, 1);

-- 3) QUERYS.
-- a. Mostrar todos los libros que posean menos de 300 páginas.

SELECT *
FROM libro
WHERE numero_de_paginas < 300;

-- b. Mostrar todos los autores que hayan nacido después del 01-01-1970.

SELECT *
FROM autor
WHERE fecha_de_nacimiento_autor > '1970';

-- c. Cuál es el libro mas solicitado?

SELECT prestamo.cantidad, libro.isbn, libro.titulo, libro.numero_de_paginas
FROM libro
INNER JOIN (SELECT libro_isbn, COUNT(libro_isbn) AS cantidad
FROM prestamo
GROUP BY libro_isbn) AS prestamo
ON prestamo.libro_isbn = libro.isbn
ORDER BY cantidad DESC LIMIT 1;

-- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.

-- Si quieres ver el total a pagar por usuario aunque sean libros distintos, usa esta query:
SELECT p.socio_rut, s.nombre, s.apellido, SUM(fecha_real_de_la_devolucion-fecha_esperada_de_la_devolucion) * 100 AS deuda_socio
FROM prestamo p
INNER JOIN socio s ON s.rut = p.socio_rut
INNER JOIN libro l ON l.isbn = p.libro_isbn
GROUP BY p.socio_rut, s.nombre, s.apellido
ORDER BY deuda_socio DESC;

-- Si quieres ver el total a pagar por usuario en cada libro distinto, usa esta query:
-- SELECT l.titulo, p.socio_rut, s.nombre, s.apellido, SUM(fecha_real_de_la_devolucion-fecha_esperada_de_la_devolucion) * 100 AS deuda_socio
-- FROM prestamo p
-- INNER JOIN socio s ON s.rut = p.socio_rut
-- INNER JOIN libro l ON l.isbn = p.libro_isbn
-- GROUP BY p.socio_rut, s.nombre, s.apellido, l.titulo
-- ORDER BY deuda_socio DESC;
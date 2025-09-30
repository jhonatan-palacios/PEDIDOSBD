
CREATE DATABASE IF NOT EXISTS tienda_online;
USE tienda_online;
CREATE TABLE IF NOT EXISTS comercial (
    id INT(10) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido1 VARCHAR(100),
    apellido2 VARCHAR(100),
    ciudad VARCHAR(100),
    comision FLOAT
);

CREATE TABLE IF NOT EXISTS cliente (
    id INT(10) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido1 VARCHAR(100),
    apellido2 VARCHAR(100),
    ciudad VARCHAR(100),
    categoria INT(10)
);

CREATE TABLE IF NOT EXISTS pedido (
    id INT(10) PRIMARY KEY,
    cantidad DOUBLE,
    fecha DATE,
    id_cliente INT(10),
    id_comercial INT(10),

    FOREIGN KEY (id_cliente) REFERENCES cliente(id),

    FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

INSERT INTO comercial (id, nombre, apellido1, apellido2, ciudad, comision) VALUES
(1, 'Javier', 'Sánchez', 'Herrera', 'Madrid', 0.1),
(2, 'María', 'López', 'Gómez', 'Barcelona', 0.15),
(3, 'Carlos', 'Martínez', 'Ruiz', 'Valencia', 0.12),
(4, 'Ana', 'Pérez', 'García', 'Sevilla', 0.1),
(5, 'Luis', 'Fernández', 'Díaz', 'Bilbao', 0.18),
(6, 'Sofía', 'Rodríguez', 'Hernández', 'Málaga', 0.1),
(7, 'Pedro', 'García', 'López', 'Murcia', 0.15),
(8, 'Elena', 'Díaz', 'Ramírez', 'Zaragoza', 0.11),
(9, 'Jorge', 'Gómez', 'Ortega', 'Palma', 0.1),
(10, 'Lucía', 'Ruiz', 'Serrano', 'Valladolid', 0.13);


INSERT INTO cliente (id, nombre, apellido1, apellido2, ciudad, categoria) VALUES
(1, 'Antonio', 'Fernández', 'Santos', 'Madrid', 100),
(2, 'Laura', 'García', 'Ruiz', 'Barcelona', 150),
(3, 'Pedro', 'López', 'Martín', 'Valencia', 100),
(4, 'Andrés', 'Gómez', 'Moreno', 'Sevilla', 200),
(5, 'Manuel', 'Sánchez', 'Pérez', 'Bilbao', 150),
(6, 'Lucía', 'Díaz', 'Gómez', 'Málaga', 100),
(7, 'Ana', 'Pérez', 'García', 'Murcia', 200),
(8, 'David', 'García', 'Díaz', 'Zaragoza', 150),
(9, 'Pilar', 'Ruiz', 'López', 'Palma', 100),
(10, 'Pablo', 'Molina', 'Herrera', 'Valladolid', 100);


INSERT INTO pedido (id, cantidad, fecha, id_cliente, id_comercial) VALUES
(1, 150.75, '2025-09-28', 1, 1),
(2, 200.00, '2025-09-27', 2, 2),
(3, 75.50, '2025-09-29', 3, 3),
(4, 500.25, '2025-09-26', 1, 4),
(5, 120.00, '2025-09-28', 4, 5),
(6, 300.50, '2025-09-27', 5, 6),
(7, 450.00, '2025-09-29', 6, 7),
(8, 250.00, '2025-09-26', 7, 8),
(9, 600.00, '2025-09-28', 8, 9),
(10, 180.25, '2025-09-27', 9, 10),
(11, 220.00, '2025-09-25', 1, 1),
(12, 195.00, '2025-09-28', 2, 2),
(13, 800.00, '2025-09-27', 3, 3),
(14, 150.00, '2025-09-26', 4, 4),
(15, 350.00, '2025-09-29', 5, 5);

SELECT * FROM pedido ORDER BY fecha DESC;


SELECT * FROM pedido ORDER BY cantidad DESC LIMIT 2;


SELECT DISTINCT id_cliente FROM pedido;

SELECT nombre 
FROM cliente 
WHERE nombre LIKE 'A%n' OR nombre LIKE 'P%' 
ORDER BY nombre;


SELECT MAX(comision) FROM comercial;

-- 13. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido
SELECT SUM(cantidad) FROM pedido;


SELECT AVG(cantidad) FROM pedido;


SELECT MAX(cantidad) FROM pedido;

SELECT MIN(cantidad) FROM pedido;

SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.nombre, c.apellido1, c.apellido2;

SELECT c.*, p.*
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.nombre;

SELECT cl.*, p.*, co.nombre AS nombre_comercial, co.apellido1 AS apellido_comercial
FROM cliente cl
INNER JOIN pedido p ON cl.id = p.id_cliente
INNER JOIN comercial co ON p.id_comercial = co.id
ORDER BY cl.nombre;

SELECT c.*, p.*
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;
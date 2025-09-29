
-- Crear la base de datos y seleccionarla para trabajar
CREATE DATABASE IF NOT EXISTS tienda_online;
USE tienda_online;

-- Crear la tabla comercial (Entidad 1)
CREATE TABLE IF NOT EXISTS comercial (
    id INT(10) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido1 VARCHAR(100),
    apellido2 VARCHAR(100),
    ciudad VARCHAR(100),
    comision FLOAT
);

-- Crear la tabla cliente (Entidad 2)
CREATE TABLE IF NOT EXISTS cliente (
    id INT(10) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido1 VARCHAR(100),
    apellido2 VARCHAR(100),
    ciudad VARCHAR(100),
    categoria INT(10)
);

-- Crear la tabla pedido (Entidad 3) con las relaciones (Foreign Keys)
CREATE TABLE IF NOT EXISTS pedido (
    id INT(10) PRIMARY KEY,
    cantidad DOUBLE,
    fecha DATE,
    id_cliente INT(10),
    id_comercial INT(10),
    -- Definición de la relación: un cliente puede tener muchos pedidos (1:N)
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    -- Definición de la relación: un comercial puede tener muchos pedidos (1:N)
    FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

-- Insertar 10 registros en la tabla comercial
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

-- Insertar 10 registros en la tabla cliente
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

-- Insertar más de 10 registros en la tabla pedido para tener datos de prueba
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

-- 4. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.
SELECT * FROM pedido ORDER BY fecha DESC;

-- 5. Listar todos los datos de los dos pedidos de mayor valor.
SELECT * FROM pedido ORDER BY cantidad DESC LIMIT 2;

-- 6. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
SELECT DISTINCT id_cliente FROM pedido;

-- 8. Devuelve un listado de los nombres de los clientes que empiezan por a y terminan por N y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.
SELECT nombre 
FROM cliente 
WHERE nombre LIKE 'A%n' OR nombre LIKE 'P%' 
ORDER BY nombre;

-- 7. Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial
SELECT MAX(comision) FROM comercial;

-- 13. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido
SELECT SUM(cantidad) FROM pedido;

-- 14. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido
SELECT AVG(cantidad) FROM pedido;

-- 15. Calcula cuál es la mayor cantidad que aparece en la tabla pedido
SELECT MAX(cantidad) FROM pedido;

-- 16. Calcula cuál es la menor cantidad que aparece en la tabla pedido
SELECT MIN(cantidad) FROM pedido;

-- 9. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.nombre, c.apellido1, c.apellido2;

-- 10. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
SELECT c.*, p.*
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.nombre;

-- 11. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.
SELECT cl.*, p.*, co.nombre AS nombre_comercial, co.apellido1 AS apellido_comercial
FROM cliente cl
INNER JOIN pedido p ON cl.id = p.id_cliente
INNER JOIN comercial co ON p.id_comercial = co.id
ORDER BY cl.nombre;

-- 12. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que NO han realizado ningún pedido. (Usa LEFT JOIN).
SELECT c.*, p.*
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;
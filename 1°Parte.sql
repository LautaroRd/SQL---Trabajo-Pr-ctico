/*
------Tablas------
*/


CREATE TABLE DOCUMENTOS
(
COD_DOCUMENTO INT  NOT NULL,
DESCRIPCION VARCHAR(20) NOT NULL,
PRIMARY KEY (COD_DOCUMENTO)
);


CREATE TABLE OFICINAS
(
COD_OFICINA CHAR(4) NOT NULL,
CODIGO_DIRECTOR INT,
DESCRIPCION VARCHAR(25) NOT NULL,
PRIMARY KEY (COD_OFICINA)
);


CREATE TABLE EMPLEADOS
(
COD_EMPLEADO INT NULL,
APELLIDO VARCHAR(20) NOT NULL,
NOMBRE VARCHAR(20) NOT NULL,
FECHA_NACIMIENTO DATE NOT NULL,
NUM_DOC INT NOT NULL,
COD_JEFE INT NOT NULL,
COD_OFICINA CHAR(4) NOT NULL,
COD_DOCUMENTO INT NOT NULL,
PRIMARY KEY (COD_EMPLEADO),
FOREIGN KEY (COD_JEFE) REFERENCES EMPLEADOS (COD_EMPLEADO),
FOREIGN KEY (COD_OFICINA) REFERENCES OFICINAS (COD_OFICINA),
FOREIGN KEY (COD_DOCUMENTO) REFERENCES DOCUMENTOS (COD_DOCUMENTO)
);


CREATE TABLE DATOS_CONTRATOS
(
COD_EMPLEADO INT NOT NULL,
FECHA_CONTRATO DATE NOT NULL,
COUTA INT NOT NULL,
VENTA INT NOT NULL,
PRIMARY KEY (COD_EMPLEADO),
FOREIGN KEY (COD_EMPLEADO) REFERENCES EMPLEADOS (COD_EMPLEADO) 
);


CREATE TABLE FABRICANTES
(
COD_FABRICANTE CHAR(4) NOT NULL,
RAZON_SOCIAL VARCHAR(25) NOT NULL,
PRIMARY KEY (COD_FABRICANTE)
);


CREATE TABLE LISTAS 
(
COD_LISTA INT NOT NULL,
DESCRIPCION VARCHAR(15) NOT NULL,
GANANCIA DOUBLE NOT NULL,
PRIMARY KEY (COD_LISTA)
);


CREATE TABLE PRODUCTOS
(
COD_PRODUCTO INT NOT NULL,
DESCRIPCION VARCHAR(25) NOT NULL,
PRECIO DOUBLE NOT NULL,
CANTIDAD_STOCK INT NOT NULL,
PUNTO_REPOSICION INT NOT NULL,
COD_FABRICANTE CHAR(4) NOT NULL,
PRIMARY KEY (COD_PRODUCTO),
FOREIGN KEY (COD_FABRICANTE) REFERENCES FABRICANTES (COD_FABRICANTE)
);


CREATE TABLE PRECIOS
(
COD_PRODUCTO INT NOT NULL,
COD_LISTA INT NOT NULL,
PRECIO DOUBLE NOT NULL,
PRIMARY KEY(COD_PRODUCTO,COD_LISTA),
FOREIGN KEY (COD_PRODUCTO) REFERENCES PRODUCTOS (COD_PRODUCTO),
FOREIGN KEY (COD_LISTA) REFERENCES LISTAS (COD_LISTA)
);


CREATE TABLE CLIENTES
(
COD_CLIENTE INT NOT NULL,
COD_LISTA INT NOT NULL,
RAZON_SOCIAL VARCHAR(25) NOT NULL,
PRIMARY KEY (COD_CLIENTE),
FOREIGN KEY (COD_LISTA) REFERENCES LISTAS (COD_LISTA)
);


CREATE TABLE PEDIDOS
(
COD_PEDIDO INT NOT NULL,
FECHA_PEDIDO DATE NOT NULL,
COD_EMPLEADO INT NOT NULL,
COD_CLIENTE INT NOT NULL,
PRIMARY KEY(COD_PEDIDO),
FOREIGN KEY(COD_EMPLEADO) REFERENCES EMPLEADOS (COD_EMPLEADO),
FOREIGN KEY(COD_CLIENTE) REFERENCES CLIENTES (COD_CLIENTE)
);


CREATE TABLE DETALLE_PEDIDOS
(
COD_PEDIDO INT NOT NULL,
NUMERO_LINEA INT NOT NULL,
COD_PRODUCTO INT NOT NULL,
CANTIDAD INT NOT NULL,
PRIMARY KEY (COD_PEDIDO, COD_PRODUCTO),
FOREIGN KEY (COD_PEDIDO) REFERENCES PEDIDOS (COD_PEDIDO),
FOREIGN KEY (COD_PRODUCTO) REFERENCES PRODUCTOS (COD_PRODUCTO)
);



/*
------Carga de datos------
*/


INSERT INTO DOCUMENTOS (COD_DOCUMENTO, DESCRIPCION)
VALUES 
(1, 'DNI'),
(2, 'Pasaporte'),
(3, 'Cédula de Identidad'),
(4, 'Licencia de Conducir'),
(5, 'Tarjeta de Residencia');


INSERT INTO OFICINAS (COD_OFICINA, CODIGO_DIRECTOR, DESCRIPCION)
VALUES 
('OF01', 101, 'Oficina Principal')
('OF01', 101, 'Oficina Principal'),
('OF02', 102, 'Sucursal Norte'),
('OF07', NULL, 'Oficina Este'),
('OF03', 103, 'Sucursal Sur'),
('OF06', NULL, 'Oficina Oeste'),
('OF04', 104, 'Oficina Regional'),
('OF05', 105, 'Oficina Internacional');


INSERT INTO EMPLEADOS (COD_EMPLEADO, APELLIDO, NOMBRE, FECHA_NACIMIENTO, NUM_DOC, COD_JEFE, COD_OFICINA, COD_DOCUMENTO)
VALUES
(1, 'Pérez', 'Juan', '1980-05-15', 12345678, NULL, 'OF01', 1), 
(2, 'González', 'Ana', '1990-11-20', 23456789, 1, 'OF01', 1),  
(3, 'López', 'Carlos', '1985-03-12', 34567890, 1, 'OF02', 2),  
(4, 'Martínez', 'Marta', '1995-07-07', 45678901, 2, 'OF02', 2),
(5, 'Sánchez', 'María', '1988-02-10', 56789012, 1, 'OF01', 1), 
(6, 'García', 'María', '1992-06-23', 67890123, 1, 'OF02', 2),  
(7, 'López', 'María', '1985-11-14', 78901234, 2, 'OF03', 1),  
(8, 'Pérez', 'María', '1990-01-05', 89012345, 3, 'OF02', 2),  
(9, 'Martínez', 'María', '1987-07-30', 90123456, 2, 'OF01', 1);


INSERT INTO DATOS_CONTRATOS (COD_EMPLEADO, FECHA_CONTRATO, COUTA, VENTA)
VALUES
(1, '1998-06-15', 110000, 150), 
(2, '2024-03-10', 60000, 180),  
(3, '2023-09-25', 45000, 160),  
(4, '2024-01-08', 52000, 170),  
(5, '2001-07-30', 32200, 120);
(6, '2002-08-21', 80000, 190),
(7, '2004-09-04', 8500,0 200),
(8, '2007-05-04', 49500, 121),
(9, '1999-09-04', 75000, 185);


INSERT INTO FABRICANTES (COD_FABRICANTE, RAZON_SOCIAL)
VALUES 
('FAB1', 'TechCorp'),
('FAB2', 'GigaSystems'),
('FAB3', 'Vision Electronics'),
('FAB4', 'AudioMax'),
('FAB5', 'Global Innovations');


INSERT INTO listas (COD_LISTA, DESCRIPCION, GANANCIA)
VALUES
(1, 'Ofertas especiales de productos electrónicos con descuentos exclusivos', 1000.50),
(2, 'Promociones de temporada para ropa y accesorios de marca', 1500.75),
(3, 'Catálogo de productos de tecnología avanzada y últimas novedades', 2000.00),
(4, 'Descuentos especiales en productos para el hogar y decoración', 1200.30),
(5, 'Ofertas exclusivas para clientes VIP en productos de lujo', 2500.60);


INSERT INTO CLIENTES (COD_CLIENTE, COD_LISTA, RAZON_SOCIAL)
VALUES 
(1, 1, 'Comercial XYZ'), 
(2, 2, 'Servicios ABC'),   
(3, 3, 'Distribuciones LMN'),  
(4, 4, 'Importaciones QRS'), 
(5, 4, 'Suministros Globales'), 
(6, 4, 'Logística Global'), 
(7, 4, 'Limpieza y Suministros'), 
(8, 3, 'Liderazgo Empresarial'),  
(9, 1, 'Láser Solutions'),        
(10, 3, 'Laboratorios X'),         
(11, 2, 'Lujos del Hogar');  


INSERT INTO PRECIOS (COD_PRODUCTO, COD_LISTA, PRECIO)
VALUES
(1001, 1, 25.99),
(1001, 2, 28.00),
(1002, 1, 15.49),
(1002, 2, 17.00),
(1003, 1, 180.00),
(1003, 2, 190.00),
(1004, 1, 7.99),
(1004, 2, 8.50),
(1005, 1, 40.99),
(1005, 2, 45.00);


INSERT INTO PRODUCTOS (COD_PRODUCTO, DESCRIPCION, PRECIO, CANTIDAD_STOCK, PUNTO_REPOSICION, COD_FABRICANTE) 
VALUES 
(1001, 'Teclado Inalámbrico', 25.99, 150, 10 , 'FAB1'),
(1002, 'Ratón Óptico', 15.49, 200, 15, 'FAB2'),
(1003, 'Monitor 24" LED', 180.00, 50, 5 , 'FAB3'),
(1004, 'Cable HDMI 2m', 7.99, 300, 20, 'FAB1'),
(1005, 'Auriculares Bluetooth', 40.99, 120, 10, 'FAB4');
(1006, 'Teclado Mecánico', 60.00, 5, 10 , 'FAB2'),
(1007, 'Mouse Gamer', 25.00, 10, 20, 'FAB3'),
(1008, 'Silla Ergonómica', 150.00, 70, 50, 'FAB4'),
(1009, 'Alfombrilla para Ratón', 12.99, 25, 10, 'FAB1'),
(1010, 'Parlantes Bluetooth', 55.00, 80, 30, 'FAB2');


INSERT INTO PEDIDOS (COD_PEDIDO, FECHA_PEDIDO, COD_EMPLEADO, COD_CLIENTE) 
VALUES 
(1014, '2024-03-05', 1, 3),  
(1015, '2025-03-12', 2, 2),  
(1016, '2023-03-18', 3, 5),  
(1017, '2024-03-22', 1, 4),  
(1018, '2025-03-27', 2, 1);  
(1006, '2024-08-15', 1, 2), 
(1007, '2023-12-22', 3, 4),  
(1008, '2025-06-10', 2, 5),  
(1009, '2024-11-03', 1, 1),
(1010, '2025-09-18', 3, 3), 
(1011, '2023-05-25', 2, 4), 
(1012, '2025-07-12', 1, 5),  
(1013, '2024-02-28', 3, 2);
(1001, '2025-04-01', 1, 1), 
(1002, '2025-04-02', 2, 2),  
(1003, '2025-04-03', 3, 3),  
(1004, '2025-04-04', 1, 4),  
(1005, '2025-04-05', 2, 5);


INSERT INTO DETALLE_PEDIDOS (COD_PEDIDO, NUMERO_LINEA, COD_PRODUCTO, CANTIDAD)
VALUES
(1016, 1, 1004, 5),
(1015, 5, 1002, 10),
(1001, 1, 1001, 5),
(1001, 2, 1002, 3),
(1002, 1, 1003, 2),
(1002, 2, 1004, 5),
(1003, 1, 1001, 7),
(1003, 2, 1005, 4),
(1004, 1, 1002, 8),
(1004, 2, 1003, 6),
(1005, 1, 1004, 9),
(1005, 2, 1005, 2);


/*
------ Consutas ------
*/


SELECT *
FROM EMPLEADOS


/*
------ Consulta Simples(Una sola tabla) ------
*/



/* 1. Obtener una lista con los nombres de las distintas oficinas de la empresa.*/


SELECT O.DESCRIPCION AS NOMBRE_DE_LAS_OFICINAS
FROM oficinas O


/* 2. Obtener una lista de todos los productos indicando descripción del producto, su precio de costo y su precio de costo IVA incluído (tomar el IVA como 21%). */


SELECT PR.DESCRIPCION AS PRODUCTO, PR.PRECIO AS COSTO, ROUND(PR.PRECIO *1.21, 2) AS COSTO_IVA
FROM productos PR


/* 3. Obtener una lista indicando para cada empleado apellido, nombre, fecha de cumpleaños y edad. */


SELECT EM.APELLIDO, EM.NOMBRE, EM.FECHA_NACIMIENTO, -YEAR(EM.FECHA_NACIMIENTO) + YEAR (CURDATE()) AS EDAD
FROM empleados EM


/* 4. Listar todos los empleados que tiene un jefe asignado. */


SELECT *
FROM empleados EM
WHERE EM.COD_JEFE IS NOT NULL


/* 5.  Listar los empleados de nombre “María” ordenado por apellido. */


SELECT *
FROM empleados E
WHERE EM.NOMBRE = "MARIA"
ORDER BY EM.APELLIDO 


/* 6. Listar los clientes cuya razón social comience con “L” ordenado por código de cliente. */


SELECT CL.*
FROM CLIENTES CL
WHERE CL.RAZON_SOCIAL LIKE "l%"


/* 7. Listar toda la información de los pedidos de Marzo ordenado por fecha de pedido. */


SELECT PE.*
FROM pedidos PE
WHERE MONTH(PE.FECHA_PEDIDO) = 3
ORDER BY DAY(PE.FECHA_PEDIDO) ASC


/* 8. Listar las oficinas que no tienen asignado director. */


SELECT O.DESCRIPCION AS OFICINAS_SIN_DIRECTOR
FROM oficinas O
WHERE O.CODIGO_DIRECTOR IS NULL 


/* 9.  Listar los 4 productos de menor precio de costo.*/


SELECT PR.*
FROM productos PR
ORDER BY PR.PRECIO ASC
LIMIT 4


/* 10. Listar los códigos de empleados de los tres que tengan la mayor cuota. */


SELECT DC.COD_EMPLEADO
FROM datos_contratos DC  
ORDER BY DC.COUTA DESC
LIMIT 3



/*
------ Consulta Multitabla ------
*/



/* 1. De cada producto listar descripción, razón social del fabricante y stock ordenado por razón social y descripción. */


SELECT F.RAZON_SOCIAL, P.DESCRIPCION, P.CANTIDAD_STOCK AS STOCK 
FROM productos PR, fabricantes FA
WHERE F.COD_FABRICANTE = P.COD_FABRICANTE


/* 2. De cada pedido listar código de pedido, fecha de pedido, apellido del empleado y razón social del cliente. */


SELECT PE.COD_PEDIDO, PE.FECHA_PEDIDO, EM.APELLIDO, CL.RAZON_SOCIAL
FROM pedidos PE, EMPLEADOS EM, CLIENTES CL
WHERE PE.COD_EMPLEADO = EM.COD_EMPLEADO
AND PE.COD_CLIENTE = CL.COD_CLIENTE


/* 3. Listar por cada empleado apellido, cuota asignada, oficina a la que pertenece ordenado en forma descendente por cuota. */


SELECT EM.APELLIDO, DC.COUTA, O.DESCRIPCION
FROM empleados EM, datos_contratos DC, oficinas O
WHERE EM.COD_OFICINA = O.COD_OFICINA
AND EM.COD_EMPLEADO = DC.COD_EMPLEADO
ORDER BY DC.COUTA DESC


/* 4. Listar sin repetir la razón social de todos aquellos clientes que hicieron pedidos en Abril. */


SELECT CL.RAZON_SOCIAL AS PEDIDOS_DE_ABRIL
FROM clientes CL, pedidos PE
WHERE CL.COD_CLIENTE = PE.COD_CLIENTE
AND MONTH(PE.FECHA_PEDIDO) = 4


/* 5.  Listar sin repetir los productos que fueron pedidos en Marzo. */


SELECT PR.DESCRIPCION AS PRODUCTOS_MARZO
FROM productos PR, pedidos PE, detalle_pedidos DP
WHERE DP.COD_PEDIDO = PE.COD_PEDIDO
AND DP.COD_PRODUCTO = PR.COD_PRODUCTO
AND MONTH(PE.FECHA_PEDIDO) = 3


/* 6. Listar aquellos empleados que están contratados por más de 10 años ordenado por cantidad de años en forma descendente. */


SELECT EM.*, DC.FECHA_CONTRATO
FROM empleados EM, DATOS_CONTRATOS DC
WHERE EM.COD_EMPLEADO = DC.COD_EMPLEADO
AND -YEAR(DC.FECHA_CONTRATO) + YEAR(CURDATE()) > 10
ORDER BY DC.FECHA_CONTRATO ASC


/* 7.Obtener una lista de los clientes mayoristas ordenada por razón social. */


SELECT DISTINCT CL.RAZON_SOCIAL
FROM clientes CL, pedidos PE, detalle_pedido DP
WHERE CL.COD_CLIENTE = PE.COD_CLIENTE
AND PE.COD_PEDIDO = DP.COD_PEDIDO
AND DP.CANTIDAD > 5
ORDER BY CL.RAZON_SOCIAL


/* 8. Obtener una lista sin repetir que indique qué productos compró cada cliente, ordenada por razón social y descripción. */


SELECT DISTINCT PR.DESCRIPCION
FROM clientes CL, productos PR, pedidos PE, detalle_pedido DP
WHERE CL.COD_CLIENTE = PE.COD_CLIENTE
AND PR.COD_PRODUCTO = DP.COD_PRODUCTO
AND PE.COD_PEDIDO = DP.COD_PEDIDO
ORDER BY CL.RAZON_SOCIAL, PR.DESCRIPCION


/* 9. Obtener una lista con la descripción de aquellos productos cuyo stock está por debajo del punto de reposición indicando cantidad a comprar y razón social del fabricante ordenada 
por razón social y descripción. */


SELECT PR.PUNTO_REPOSICION - PR.CANTIDAD_STOCK AS CANTIDAD_COMPRAR, FA.RAZON_SOCIAL
FROM productos PR, fabricantes FA
WHERE PR.COD_FABRICANTE = FA.COD_FABRICANTE
AND PR.CANTIDAD_STOCK < PR.PUNTO_REPOSICION
ORDER BY FA.RAZON_SOCIAL, PR.DESCRIPCION


/* 10. Listar aquellos empleados cuya cuota es menor a 50000 o mayor a 100000. */


SELECT DISTINCT *
FROM empleados EM, datos_contratos DC
WHERE EM.COD_EMPLEADO = DC.COD_EMPLEADO
AND DC.COUTA < 50000 
OR DC.COUTA > 100000
AND EM.COD_EMPLEADO = DC.COD_EMPLEADO


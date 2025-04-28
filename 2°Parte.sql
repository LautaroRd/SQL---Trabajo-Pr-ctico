/*
------Tablas------
*/


CREATE TABLE CLIENTES
(
cod_cliente INT AUTO_INCREMENT NOT NULL,
nombre VARCHAR(20) NOT NULL,
provincia VARCHAR (20) NOT NULL,
PRIMARY KEY (cod_cliente)
);


CREATE TABLE PRODUCTOS 
(
cod_prod INT NOT NULL,
nom_prod VARCHAR(20) NOT NULL,
PRIMARY KEY (cod_prod)
);


CREATE TABLE ITEM_VENTAS
(
num_fact CHAR(4) NOT NULL,
cod_prod int NOT NULL,
cant INT NOT NULL,
precio DOUBLE NOT NULL,
PRIMARY KEY (num_fact),
FOREIGN KEY (cod_prod) REFERENCES PRODUCTOS (cod_prod)
);


CREATE TABLE VENTAS
(
num_fact CHAR(4) NOT NULL,
cod_cliente INT NOT NULL,
fecha DATE NOT NULL,
PRIMARY KEY (num_fact, cod_cliente),
FOREIGN KEY (num_fact) REFERENCES ITEM_VENTAS (num_fact),
FOREIGN KEY (cod_cliente) REFERENCES CLIENTES (cod_cliente)
);



/*
------Carga de datos------
*/



INSERT INTO CLIENTES (nombre, provincia)
VALUES
('Julián', 'Buenos Aires'),
('José', 'Buenos Aires'),
('Sol', 'Formosa'),
('Pablo', 'Mendoza'),
('Fabián', 'Misiones'),
('Marco', 'Jujuy'),
('Franco', 'Chaco'),
('Paola', 'Santa Fe'),
('Estefanía', 'Tierra del Fuego');

INSERT INTO PRODUCTOS (cod_prod, nom_prod)
VALUE 
(001,'Jabón'),
(002,'Shampoo'),
(003,'Acodicionador'),
(004,'Crema para la cara'),
(005,'Desodorante'),
(006,'Gel'),
(007,'Pasta dental'),
(008,'cepillo');

INSERT INTO ITEM_VENTAS (num_fact,cod_prod,cant,precio)
VALUE 
('AA01',001,20,2.99),
('AA02',002,10,5.45),
('AA03',002,15,5.66),
('AA04',006,21,2.89),
('AA05',008,18,4.20),
('AA06',005,8,1.99),
('AA07',003,5,0.99),
('AA08',004,11,3.55),
('AA09',004,14,4.55);

INSERT INTO VENTAS (num_fact, cod_cliente, fecha)
VALUE
('AA06',1,'2025-05-02'),
('AA09',4,'2025-06-11'),
('AA02',6,'2024-10-22'),
('AA04',4,'2024-01-04'),
('AA05',4,'2024-06-20'),
('AA06',6,'2024-02-21'),
('AA09',5,'2024-04-22'),
('AA02',1,'2024-08-23'),
('AA04',7,'2024-05-30'),
('AA08',8,'2024-02-11'),
('AA08',9,'2024-05-10');

/*
------ Ejecicio B ------
*/

/* 1. Obtener la cantidad de unidades máxima. */


SELECT MAX(cant) AS Cantidad_Máxima
FROM item_ventas


/* 2. Obtener la cantidad total de unidades vendidas del producto c */


SELECT SUM(iv.precio)
FROM productos pr , item_ventas iv
WHERE iv.cod_prod = pr.cod_prod
AND pr.nom_prod LIKE 'C%'


/* 3. Cantidad de unidades vendidas por producto, indicando la descripción del producto, ordenado de mayor a menor por las cantidades vendidas.  */


SELECT DISTINCT pr.nom_prod
FROM productos pr, item_ventas iv, ventas ve
WHERE iv.cod_prod = pr.cod_prod
AND iv.num_fact = ve.num_fact
GROUP BY iv.cod_prod
ORDER BY SUM(iv.cant) DESC

/* 4. Cantidad de unidades vendidas por producto, indicando la descripción del producto, ordenado alfabéticamente por nombre de producto para los productos que vendieron mas de 30 unidades. */

SELECT pr.nom_prod
FROM productos pr, item_ventas iv, ventas ve
WHERE iv.cod_prod = pr.cod_prod
AND iv.num_fact = ve.num_fact
GROUP BY iv.cod_prod
HAVING SUM(iv.cant) > 30
ORDER BY pr.nom_prod

/* 5. Obtener cuantas compras (1 factura = 1 compra) realizó cada cliente indicando el código y nombre del cliente ordenado de mayor a menor  */

SELECT cl.cod_cliente, cl.nombre, COUNT(cl.cod_cliente) AS compras
FROM ventas ve, clientes cl
WHERE ve.cod_cliente = cl.cod_cliente
GROUP BY ve.cod_cliente
ORDER BY compras desc

/* 6.  Promedio de unidades vendidas por producto, indicando el código del producto para el cliente 1 */

SELECT iv.cod_prod, ROUND(AVG(iv.cant), 2) AS Promedio
FROM ventas ve, item_ventas iv
WHERE ve.num_fact = iv.num_fact
AND ve.cod_cliente = 6
GROUP BY iv.cod_prod


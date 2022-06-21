-- Guía 2 - Álgebra Relacional Pasada a SQL
-- Ejercicio 1

-- Dadas las tablas:
-- PROVEEDOR (id_proveedor, nombre, categoria, ciudad)
-- ARTICULO (id_articulo, descripción, ciudad, precio)
-- CLIENTE (id_cliente, nombre, ciudad)
-- PEDIDO (id_pedido, id_proveedor, id_articulo, id_cliente, cantidad, precio_total)
-- PROVEE (id_proveedor, id_articulo)
;
-- f) Hallar los pedidos en los que el cliente 23 solicita artículos no pedidos por el cliente 30.
SELECT id_pedido
FROM PEDIDO
WHERE id_cliente = 23
EXCEPT (SELECT id_pedido
        FROM PEDIDO
        WHERE id_cliente=30);

-- h) Hallar el nombre de los proveedores cuya categoría sea mayor que la de todos los proveedores que proveen el artículo Cuaderno.
SELECT id_proveedor
FROM PROVEEDOR
WHERE categoria > (SELECT MAX (categoria))
                   FROM PROVEEDOR Pv,
                        PROVEE P,
                        ARTICULO A
                   WHERE Pv.id_proveedor=P.id_proveedor
                   AND P.id_articulo=P.id_articulo
                   AND descripcion='Cuaderno');

-- j) Hallar los clientes que han pedido 2 o más artículos distintos.
SELECT id_cliente,COUNT(DISTINCT id_articulo)
FROM PEDIDO
GROUP BY id_cliente
HAVING COUNT(DISTINCT id_articulo) >= 2;

-- l) Hallar la cantidad de artículos diferentes que son provistos por cada uno de los proveedores de la base de datos.
SELECT id_proveedor,COUNT(DISTINCT id_articulo)
FROM PROVEE
GROUP BY id_proveedor;

-- m) Hallar el proveedor que más artículos provee.
SELECT id_proveedor,COUNT(*)
FROM PROVEE
GROUP BY id_proveedor
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                        FROM PROVEE
                        GROUP BY id_proveedor);

-- n) Hallar el proveedor que provee todos los artículos.
SELECT id_proveedor
FROM PROVEE
GROUP BY id_proveedor
HAVING COUNT(*)=(SELECT COUNT(*)
                 FROM ARTICULO);
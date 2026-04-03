-- Join tables for answering questions like:
-- How much do we sell? Under which price? What is the cost? and verify it per country.
--3 LEFT JOIN: ventas_2017 as v, productos as p, productos_categorias as pc y territorios as t
SELECT v.numero_pedido,
v.clave_producto,
p.nombre_producto,
pc.clave_categoria,
t.pais,
t.continente,
v.clave_territorio,
COALESCE(p.precio_producto,0) AS precio_producto,
COALESCE(v.cantidad_pedido,0) AS cantidad_pedido,
COALESCE(p.costo_producto,0) AS costo_producto
FROM ventas_2017 AS v
LEFT JOIN productos AS p
ON v.clave_producto = p.clave_producto
LEFT JOIN productos_categorias AS pc
ON p.clave_subcategoria = pc.clave_subcategoria
LEFT JOIN territorios as t
ON v.clave_territorio = t.clave_territorio
SELECT
    v.numero_pedido,
    v.clave_producto,
    p.nombre_producto,
    pc.clave_categoria,
    COALESCE(p.precio_producto, 0)  AS precio_producto,
    COALESCE(v.cantidad_pedido, 0)  AS cantidad_pedido,
    COALESCE(p.costo_producto, 0)   AS costo_producto,
    t.pais,
    t.continente,
    v.clave_territorio,
-- Total revenue and total cost calculations (KPIs). We will need to add them as two new columns.
COALESCE(p.precio_producto*cantidad_pedido) AS ingreso_total,
COALESCE (p.costo_producto*cantidad_pedido) AS costo_total
FROM ventas_2017 AS v
JOIN productos AS p
  ON v.clave_producto = p.clave_producto
LEFT JOIN productos_categorias AS pc
  ON p.clave_subcategoria = pc.clave_subcategoria
LEFT JOIN territorios AS t
  ON v.clave_territorio = t.clave_territorio;
-- Quick validation: Nulls on keys that join data from ventas_2017
SELECT
SUM(CASE WHEN numero_pedido IS NULL THEN 1 ELSE 0 END) AS nulos_numero_pedido,
SUM(CASE WHEN clave_producto IS NULL THEN 1 ELSE 0 END) AS nulos_clave_producto,
SUM(CASE WHEN clave_territorio IS NULL THEN 1 ELSE 0 END) AS nulos_clave_territorio
FROM ventas_2017
-- Count nulls at numero_pedido as nulos_numero_pedido, clave_producto as nulos_clave_producto , clave_territorio as nulos_clave_territorio 
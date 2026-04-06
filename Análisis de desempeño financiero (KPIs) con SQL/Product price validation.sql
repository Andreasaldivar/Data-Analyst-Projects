- Count of non valid quantities at ventas_2017 as productos_precio_no_valido
-- Usae < 0 for negatives
SELECT
COUNT (*) AS productos_precio_no_valido
    FROM productos
WHERE precio_producto <0;
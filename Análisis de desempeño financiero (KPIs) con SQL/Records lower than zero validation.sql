--Detect records where order_quantity is equal to or less than zero. We can't have values under zero.
SELECT
    COUNT(*) AS filas_cantidad_no_valida
FROM ventas_2017
WHERE cantidad_pedido <=0
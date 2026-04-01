SELECT pais,
clave_territorio,
SUM(ingreso_total)::INTEGER AS ingreso_total,
SUM (costo_total):: INTEGER AS costo_total
FROM ventas_clean
GROUP BY pais, clave_territorio
ORDER BY ingreso_total DESC;
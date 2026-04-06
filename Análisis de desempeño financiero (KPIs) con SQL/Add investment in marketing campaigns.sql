-- How much do we spend on marketing advertising?
SELECT
    v.pais,
    v.clave_territorio,
    SUM(v.ingreso_total)::integer AS ingresos,
    SUM(v.costo_total)::integer  AS costos,
COALESCE(SUM(c.costo_campana::numeric),0)::bigint AS costo_campana
FROM ventas_clean AS v
LEFT JOIN campanas AS c
  ON v.clave_territorio = c.clave_territorio::integer
GROUP BY
    v.pais,
    v.clave_territorio
ORDER BY
    ingresos DESC;
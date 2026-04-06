SELECT
    p.pais,
    p.clave_territorio,
    SUM(p.ingresos)::INTEGER AS ingresos,
    SUM(p.costos)::INTEGER AS costos,
    COALESCE(SUM(c.costo_campana),0)::integer AS costo_campana,
-- Calculate the gross profit (earnings before marketing). How much is left after covering direct costs?   
-- Use formula = suma (p.ingresos)::integer –  suma (p.costos)::integer
SUM(p.ingresos)::integer - SUM(p.costos):: integer AS beneficio_bruto,
-- Calculate magin_pct (sales efficiency) --> the share of revenue retained as gross profit per dollar sold.
-- margen_pct = (Ingresos – Costos) / Ingresos * 100
((SUM(p.ingresos) - SUM(p.costos))*100)/NULLIF(SUM(p.ingresos),0) AS margen_pct,
-- Calculate roi_pct (return on campaings) --> the profitability of each dollar invested in marketing.
-- roi_pct = Sumas (Ingresos – Costos) / CostoCampanas * 100 with nullif
((SUM(p.ingresos) - SUM(p.costos))*100)/NULLIF(SUM(c.costo_campana),0) AS roi_pct
FROM pais_ingreso_costo AS p
LEFT JOIN pais_campanas AS c
  ON p.clave_territorio = c.clave_territorio
GROUP BY
    p.pais,
    p.clave_territorio
ORDER BY
   p.clave_territorio,ingresos,costos;
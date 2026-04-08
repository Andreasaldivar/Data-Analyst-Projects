-- OBJECTIVE: segment the overall funnel per country
-- 1) Incluye country on all the CTEs.
-- 2) In funnel_counts: join by user_id and country; group by fv.country.
-- 3) On the final SELECT: Calculate conversions (5) about usuarios_first_visits per country.

WITH first_visits AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name = 'first_visit'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
select_item AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name IN ('select_item', 'select_promotion')
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_to_cart AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name = 'add_to_cart'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
begin_checkout AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name = 'begin_checkout'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_shipping_info AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name = 'add_shipping_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
add_payment_info AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name = 'add_payment_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
purchase AS (
  SELECT DISTINCT user_id, country
  FROM mercadolibre_funnel
  WHERE event_name = 'purchase'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
funnel_counts AS(
SELECT
    fv.country,
  COUNT (fv.user_id) AS usuarios_first_visit,
  COUNT (si.user_id) AS usuarios_select_item,
  COUNT(a.user_id) AS usuarios_add_to_cart,
  COUNT(bc.user_id) AS usuarios_begin_checkout,
  COUNT(asi.user_id) AS usuarios_add_shipping_info,
  COUNT(api.user_id) AS usuarios_add_payment_info,
  COUNT(p.user_id) AS usuarios_purchase
FROM first_visits fv
LEFT JOIN select_item si        ON fv.user_id = si.user_id
                                AND fv.country = si.country
LEFT JOIN add_to_cart a         ON fv.user_id = a.user_id
                                AND fv.country = a.country
LEFT JOIN begin_checkout bc     ON fv.user_id = bc.user_id
                                AND fv.country = bc.country
LEFT JOIN add_shipping_info asi ON fv.user_id = asi.user_id
                                AND fv.country = asi.country
LEFT JOIN add_payment_info api  ON fv.user_id = api.user_id
                                AND fv.country = api.country
LEFT JOIN purchase p            ON fv.user_id = p.user_id
                                AND fv.country = p.country
GROUP BY fv.country
)
select
country,
100.00* usuarios_select_item
    / NULLIF(usuarios_first_visit,0) AS conversion_select_item,
100.00* usuarios_add_to_cart
    / NULLIF(usuarios_first_visit,0) AS conversion_add_to_cart,
100.00* usuarios_begin_checkout
    / NULLIF(usuarios_first_visit,0) AS conversion_begin_checkout,
100.00* usuarios_add_shipping_info
    / NULLIF(usuarios_first_visit,0) AS conversion_add_shipping_info,
100.00* usuarios_add_payment_info
    / NULLIF(usuarios_first_visit,0) AS conversion_add_payment_info,
100.00* usuarios_purchase
    / NULLIF(usuarios_first_visit,0) AS conversion_purchase

FROM funnel_counts
ORDER BY conversion_purchase DESC;
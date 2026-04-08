-- 1) Create a new CTE per event with a specific data frame.
WITH cte_first_visit AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name = 'first_visit'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_select_item AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name IN('select_item', 'select_promotion')
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_add_to_cart AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_begin_checkout AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_add_shipping_info AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_add_payment_info AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),
cte_purchase AS(
SELECT DISTINCT user_id
FROM  mercadolibre_funnel
    WHERE event_name = 'purchase'
    AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
)
-- 2) Join the CTEs at signup and count the users per stage.
select
COUNT(fv.user_id) AS usuarios_first_visit,
COUNT(si.user_id) AS usuarios_select_item,
COUNT(atc.user_id) AS usuarios_add_to_cart,
COUNT(bc.user_id) AS usuarios_begin_checkout,
COUNT(asi.user_id) AS usuarios_add_shipping_info,
COUNT(api.user_id) AS usuarios_add_payment_info,
COUNT(p.user_id) AS usuarios_purchase
FROM 
cte_first_visit AS fv
LEFT JOIN cte_select_item AS si
    ON fv.user_id = si.user_id
LEFT JOIN cte_add_to_cart AS atc
    ON fv.user_id = atc.user_id
LEFT JOIN cte_begin_checkout AS bc
    ON fv.user_id = bc.user_id
LEFT JOIN cte_add_shipping_info AS asi
    ON fv.user_id = asi.user_id
LEFT JOIN cte_add_payment_info AS api
    ON fv.user_id = api.user_id
LEFT JOIN cte_purchase as p
    ON fv.user_id = p.user_id
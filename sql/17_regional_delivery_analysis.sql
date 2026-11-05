
-- ==========================================
-- STEP 17: REGIONAL DELIVERY PERFORMANCE
-- ==========================================

WITH delivery_data AS (

    SELECT
        o.order_id,
        c.customer_state,

        EXTRACT(EPOCH FROM (
            o.order_delivered_customer_date -
            o.order_delivered_carrier_date
        )) / 86400.0 AS shipping_days,

        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END AS late_delivery

    FROM orders o

    JOIN customers c
        ON o.customer_id = c.customer_id

    WHERE o.order_status = 'delivered'

      AND o.order_delivered_carrier_date IS NOT NULL
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL

      AND o.order_delivered_customer_date >=
          o.order_delivered_carrier_date
)

SELECT
    customer_state,

    COUNT(*) AS total_orders,

    ROUND(AVG(shipping_days)::NUMERIC, 2)
        AS average_shipping_days,

    ROUND(
        (PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY shipping_days))::NUMERIC,
        2
    ) AS median_shipping_days,

    ROUND(
        100.0 * SUM(late_delivery) / COUNT(*),
        2
    ) AS late_delivery_rate,

    COUNT(*) FILTER (
        WHERE late_delivery = 1
    ) AS late_orders

FROM delivery_data

GROUP BY customer_state

HAVING COUNT(*) >= 100

ORDER BY late_delivery_rate DESC;


-- ==========================================
-- STEP 19: SELLER DELIVERY PERFORMANCE
-- ==========================================

WITH seller_orders AS (

    -- Each seller-order combination should appear once
    SELECT DISTINCT
        oi.seller_id,
        o.order_id,
        o.order_approved_at,
        o.order_delivered_carrier_date,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date

    FROM order_items oi

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL
)

SELECT
    so.seller_id,
    s.seller_city,
    s.seller_state,

    COUNT(*) AS delivered_orders,

    ROUND(
        AVG(
            EXTRACT(EPOCH FROM (
                so.order_delivered_carrier_date -
                so.order_approved_at
            )) / 86400.0
        ) FILTER (
            WHERE so.order_approved_at IS NOT NULL
              AND so.order_delivered_carrier_date IS NOT NULL
              AND so.order_delivered_carrier_date >= so.order_approved_at
        )::NUMERIC,
        2
    ) AS average_preparation_days,

    ROUND(
        AVG(
            EXTRACT(EPOCH FROM (
                so.order_delivered_customer_date -
                so.order_delivered_carrier_date
            )) / 86400.0
        ) FILTER (
            WHERE so.order_delivered_carrier_date IS NOT NULL
              AND so.order_delivered_customer_date >=
                  so.order_delivered_carrier_date
        )::NUMERIC,
        2
    ) AS average_shipping_days,

    COUNT(*) FILTER (
        WHERE so.order_delivered_customer_date >
              so.order_estimated_delivery_date
    ) AS late_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE so.order_delivered_customer_date >
                  so.order_estimated_delivery_date
        ) / COUNT(*),
        2
    ) AS late_delivery_rate

FROM seller_orders so

JOIN sellers s
    ON so.seller_id = s.seller_id

GROUP BY
    so.seller_id,
    s.seller_city,
    s.seller_state

HAVING COUNT(*) >= 20

ORDER BY late_delivery_rate DESC;

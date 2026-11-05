
-- ==========================================
-- STEP 16: PROCESS VARIABILITY ANALYSIS
-- ==========================================

WITH stage_durations AS (

    SELECT
        'Purchase to Approval' AS stage,
        EXTRACT(EPOCH FROM (
            order_approved_at - order_purchase_timestamp
        )) / 3600.0 AS duration_hours
    FROM orders
    WHERE order_status = 'delivered'
      AND order_approved_at IS NOT NULL
      AND order_purchase_timestamp IS NOT NULL
      AND order_approved_at >= order_purchase_timestamp

    UNION ALL

    SELECT
        'Approval to Carrier',
        EXTRACT(EPOCH FROM (
            order_delivered_carrier_date - order_approved_at
        )) / 3600.0
    FROM orders
    WHERE order_status = 'delivered'
      AND order_approved_at IS NOT NULL
      AND order_delivered_carrier_date IS NOT NULL
      AND order_delivered_carrier_date >= order_approved_at

    UNION ALL

    SELECT
        'Carrier to Customer',
        EXTRACT(EPOCH FROM (
            order_delivered_customer_date -
            order_delivered_carrier_date
        )) / 3600.0
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_carrier_date IS NOT NULL
      AND order_delivered_customer_date IS NOT NULL
      AND order_delivered_customer_date >= order_delivered_carrier_date
)

SELECT
    stage,

    COUNT(*) AS analyzed_orders,

    ROUND(AVG(duration_hours)::NUMERIC / 24, 2)
        AS average_days,

    ROUND(
        (PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY duration_hours))::NUMERIC / 24,
        2
    ) AS median_days,

    ROUND(
        (PERCENTILE_CONT(0.90)
        WITHIN GROUP (ORDER BY duration_hours))::NUMERIC / 24,
        2
    ) AS p90_days,

    COUNT(*) FILTER (
        WHERE duration_hours > 30 * 24
    ) AS orders_over_30_days,

    ROUND(MAX(duration_hours)::NUMERIC / 24, 2)
        AS maximum_days

FROM stage_durations

GROUP BY stage

ORDER BY average_days DESC;

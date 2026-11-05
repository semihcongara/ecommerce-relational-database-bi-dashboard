
-- ==========================================
-- STEP 15: OPERATIONAL BOTTLENECK ANALYSIS
-- ==========================================

WITH stage_durations AS (

    -- 1. Purchase to Approval
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

    -- 2. Approval to Carrier Handoff
    SELECT
        'Approval to Carrier' AS stage,

        EXTRACT(EPOCH FROM (
            order_delivered_carrier_date - order_approved_at
        )) / 3600.0 AS duration_hours

    FROM orders

    WHERE order_status = 'delivered'
      AND order_approved_at IS NOT NULL
      AND order_delivered_carrier_date IS NOT NULL
      AND order_delivered_carrier_date >= order_approved_at

    UNION ALL

    -- 3. Carrier Handoff to Customer Delivery
    SELECT
        'Carrier to Customer' AS stage,

        EXTRACT(EPOCH FROM (
            order_delivered_customer_date -
            order_delivered_carrier_date
        )) / 3600.0 AS duration_hours

    FROM orders

    WHERE order_status = 'delivered'
      AND order_delivered_carrier_date IS NOT NULL
      AND order_delivered_customer_date IS NOT NULL
      AND order_delivered_customer_date >= order_delivered_carrier_date
)

SELECT
    stage,

    COUNT(*) AS analyzed_orders,

    ROUND(AVG(duration_hours)::NUMERIC, 2)
        AS average_hours,

    ROUND(
        (AVG(duration_hours) / 24.0)::NUMERIC,
        2
    ) AS average_days,

    ROUND(MIN(duration_hours)::NUMERIC, 2)
        AS minimum_hours,

    ROUND(MAX(duration_hours)::NUMERIC, 2)
        AS maximum_hours

FROM stage_durations

GROUP BY stage

ORDER BY average_hours DESC;

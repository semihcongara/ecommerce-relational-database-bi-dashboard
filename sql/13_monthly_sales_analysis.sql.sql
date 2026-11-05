-- ==========================================
-- STEP 13: MONTHLY SALES ANALYSIS
-- ==========================================

WITH order_values AS (
    SELECT
        order_id,
        SUM(price) AS product_sales,
        SUM(freight_value) AS freight_total
    FROM order_items
    GROUP BY order_id
)

SELECT
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp
    ) AS month,

    COUNT(*) AS delivered_orders,

    ROUND(SUM(ov.product_sales), 2) AS product_sales,

    ROUND(SUM(ov.freight_total), 2) AS freight_total,

    ROUND(
        SUM(ov.product_sales + ov.freight_total),
        2
    ) AS total_order_value,

    ROUND(
        AVG(ov.product_sales + ov.freight_total),
        2
    ) AS average_order_value

FROM orders o

JOIN order_values ov
    ON o.order_id = ov.order_id

WHERE o.order_status = 'delivered'

GROUP BY DATE_TRUNC(
    'month',
    o.order_purchase_timestamp
)

ORDER BY month;
-- ==========================================
-- STEP 14: PRODUCT CATEGORY ANALYSIS
-- ==========================================

SELECT
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Uncategorized'
    ) AS category,

    COUNT(*) AS total_items,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    ROUND(SUM(oi.price), 2) AS total_revenue,

    ROUND(AVG(oi.price), 2) AS average_item_price

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

JOIN products p
    ON oi.product_id = p.product_id

LEFT JOIN product_category_translation t
    ON p.product_category_name = t.product_category_name

WHERE o.order_status = 'delivered'

GROUP BY
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Uncategorized'
    )
ORDER BY total_revenue DESC;


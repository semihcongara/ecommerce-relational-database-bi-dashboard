
-- ==========================================
-- STEP 18: SELLER SALES PERFORMANCE
-- ==========================================

SELECT
    s.seller_id,

    s.seller_city,

    s.seller_state,

    COUNT(*) AS items_sold,

    COUNT(DISTINCT oi.order_id) AS delivered_orders,

    ROUND(SUM(oi.price), 2) AS total_revenue,

    ROUND(AVG(oi.price), 2) AS average_item_price

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

JOIN sellers s
    ON oi.seller_id = s.seller_id

WHERE o.order_status = 'delivered'

GROUP BY
    s.seller_id,
    s.seller_city,
    s.seller_state

HAVING COUNT(DISTINCT oi.order_id) >= 20

ORDER BY total_revenue DESC

LIMIT 20;

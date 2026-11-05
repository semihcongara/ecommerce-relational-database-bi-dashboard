-- 1. Orders -> Customers
SELECT
    'orders -> customers' AS relationship,
    COUNT(*) AS orphan_records
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL

UNION ALL

-- 2. Order Items -> Orders
SELECT
    'order_items -> orders',
    COUNT(*)
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE oi.order_id IS NOT NULL
  AND o.order_id IS NULL

UNION ALL

-- 3. Order Items -> Products
SELECT
    'order_items -> products',
    COUNT(*)
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE oi.product_id IS NOT NULL
  AND p.product_id IS NULL

UNION ALL

-- 4. Order Items -> Sellers
SELECT
    'order_items -> sellers',
    COUNT(*)
FROM order_items oi
LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE oi.seller_id IS NOT NULL
  AND s.seller_id IS NULL

UNION ALL

-- 5. Payments -> Orders
SELECT
    'order_payments -> orders',
    COUNT(*)
FROM order_payments op
LEFT JOIN orders o
    ON op.order_id = o.order_id
WHERE op.order_id IS NOT NULL
  AND o.order_id IS NULL

UNION ALL

-- 6. Reviews -> Orders
SELECT
    'order_reviews -> orders',
    COUNT(*)
FROM order_reviews r
LEFT JOIN orders o
    ON r.order_id = o.order_id
WHERE r.order_id IS NOT NULL
  AND o.order_id IS NULL

UNION ALL

-- 7. Products -> Category Translation
SELECT
    'products -> category_translation',
    COUNT(*)
FROM products p
LEFT JOIN product_category_translation t
    ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND t.product_category_name IS NULL;

--checking orphans
  SELECT
    p.product_category_name,
    COUNT(*) AS affected_products
FROM products p
LEFT JOIN product_category_translation t
    ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND t.product_category_name IS NULL
GROUP BY p.product_category_name
ORDER BY affected_products DESC;

SELECT
    COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- PRIMARY KEY PRE-CHECK

SELECT
    'customers.customer_id' AS key_name,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_rows,
    (SELECT COUNT(*) FROM (
        SELECT customer_id FROM customers
        GROUP BY customer_id HAVING COUNT(*) > 1
    ) d) AS duplicate_groups
FROM customers

UNION ALL

SELECT
    'orders.order_id',
    COUNT(*) FILTER (WHERE order_id IS NULL),
    (SELECT COUNT(*) FROM (
        SELECT order_id FROM orders
        GROUP BY order_id HAVING COUNT(*) > 1
    ) d)
FROM orders

UNION ALL

SELECT
    'products.product_id',
    COUNT(*) FILTER (WHERE product_id IS NULL),
    (SELECT COUNT(*) FROM (
        SELECT product_id FROM products
        GROUP BY product_id HAVING COUNT(*) > 1
    ) d)
FROM products

UNION ALL

SELECT
    'sellers.seller_id',
    COUNT(*) FILTER (WHERE seller_id IS NULL),
    (SELECT COUNT(*) FROM (
        SELECT seller_id FROM sellers
        GROUP BY seller_id HAVING COUNT(*) > 1
    ) d)
FROM sellers

UNION ALL

SELECT
    'order_items (order_id, order_item_id)',
    COUNT(*) FILTER (
        WHERE order_id IS NULL OR order_item_id IS NULL
    ),
    (SELECT COUNT(*) FROM (
        SELECT order_id, order_item_id FROM order_items
        GROUP BY order_id, order_item_id HAVING COUNT(*) > 1
    ) d)
FROM order_items

UNION ALL

SELECT
    'order_payments (order_id, payment_sequential)',
    COUNT(*) FILTER (
        WHERE order_id IS NULL OR payment_sequential IS NULL
    ),
    (SELECT COUNT(*) FROM (
        SELECT order_id, payment_sequential FROM order_payments
        GROUP BY order_id, payment_sequential HAVING COUNT(*) > 1
    ) d)
FROM order_payments

UNION ALL

SELECT
    'product_category_translation.product_category_name',
    COUNT(*) FILTER (WHERE product_category_name IS NULL),
    (SELECT COUNT(*) FROM (
        SELECT product_category_name
        FROM product_category_translation
        GROUP BY product_category_name HAVING COUNT(*) > 1
    ) d)
FROM product_category_translation;
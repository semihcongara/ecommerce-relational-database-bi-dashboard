-- CUSTOMERS
ALTER TABLE customers
ADD CONSTRAINT pk_customers
PRIMARY KEY (customer_id);

-- ORDERS
ALTER TABLE orders
ADD CONSTRAINT pk_orders
PRIMARY KEY (order_id);

-- PRODUCTS
ALTER TABLE products
ADD CONSTRAINT pk_products
PRIMARY KEY (product_id);

-- SELLERS
ALTER TABLE sellers
ADD CONSTRAINT pk_sellers
PRIMARY KEY (seller_id);

-- ORDER ITEMS
ALTER TABLE order_items
ADD CONSTRAINT pk_order_items
PRIMARY KEY (order_id, order_item_id);

-- ORDER PAYMENTS
ALTER TABLE order_payments
ADD CONSTRAINT pk_order_payments
PRIMARY KEY (order_id, payment_sequential);

-- PRODUCT CATEGORY TRANSLATION
ALTER TABLE product_category_translation
ADD CONSTRAINT pk_product_category_translation
PRIMARY KEY (product_category_name);



--CONTROL
SELECT
    tc.table_name,
    tc.constraint_name,
    kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.ordinal_position;
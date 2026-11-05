-- 1. Inspect duplicated review IDs
SELECT
    review_id,
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC
LIMIT 20;

-- 2. Check duplicated review_id + order_id combinations
SELECT COUNT(*) AS duplicate_review_order_pairs
FROM (
    SELECT
        review_id,
        order_id
    FROM order_reviews
    GROUP BY review_id, order_id
    HAVING COUNT(*) > 1
) d;

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS non_null_order_ids,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_order_rows
FROM order_reviews;

SELECT
    COUNT(*) FILTER (
        WHERE review_id IS NULL
    ) AS null_review_ids,

    COUNT(*) FILTER (
        WHERE order_id IS NULL
    ) AS null_order_ids,

    (
        SELECT COUNT(*)
        FROM (
            SELECT review_id, order_id
            FROM order_reviews
            GROUP BY review_id, order_id
            HAVING COUNT(*) > 1
        ) duplicates
    ) AS duplicate_pairs

FROM order_reviews;
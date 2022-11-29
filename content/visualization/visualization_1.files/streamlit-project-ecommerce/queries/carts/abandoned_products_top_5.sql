-- Abandoned Products
WITH session_products AS (
    SELECT
        domain_sessionid,
        product_id,
        SUM(CASE WHEN is_add_to_cart THEN COALESCE(product_quantity, 1) ELSE 0 END ) AS total_added,
        SUM(CASE WHEN is_remove_from_cart THEN COALESCE(product_quantity, 1) ELSE 0 END ) +
            SUM(CASE WHEN is_product_transaction THEN COALESCE(product_quantity, 1) ELSE 0 END ) AS total_removed
    FROM
        dbt_ryan_derived.snowplow_ecommerce_product_interactions
    GROUP BY
        domain_sessionid,
        product_id
    )
SELECT
    product_id,
    SUM(total_added) AS total_added,
    SUM(total_removed) AS total_removed,
    SUM(total_added - total_removed) AS total_abandoned
FROM
    session_products
GROUP BY
    1
ORDER BY
    4 DESC
LIMIT
    5

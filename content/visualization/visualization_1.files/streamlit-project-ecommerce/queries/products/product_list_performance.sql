-- Abandoned Products
WITH session_prod_lists as (
    SELECT
        domain_sessionid,
        product_list_name,
        product_id,
        COUNT(distinct domain_sessionid) as list_views
    FROM
        dbt_ryan_derived.snowplow_ecommerce_product_interactions
    WHERE
        product_view_type = 'list_view'
    GROUP BY 1,2,3
),

session_interactions as (
    SELECT
        domain_sessionid,
        product_id,
        MAX(case when product_view_type = 'product_view' then 1 else 0 end) as viewed_product,
        MAX(case when is_add_to_cart then 1 else 0 end) as cart_product,
        MAX(case when is_product_transaction then 1 else 0 end) as transact_product,
        COUNT(distinct transaction_id) as unique_transactions,
        SUM(case when is_product_transaction then product_price * coalesce(product_quantity, 1) else 0 end) as product_revenue
    FROM
        dbt_ryan_derived.snowplow_ecommerce_product_interactions
    GROUP BY 1, 2
)

SELECT
    product_list_name,
    sum(list_views) as list_views,
    SUM(viewed_product) as product_viewed,
    concat(round(100*(SUM(viewed_product)/sum(list_views)), 1), '%') as CTR,
    SUM(cart_product) as cart_product,
    SUM(transact_product) as transact_product,
    SUM(unique_transactions) as unique_transactions,
    SUM(product_revenue) as product_revenue
FROM session_prod_lists a
    LEFT JOIN session_interactions b
        ON a.domain_sessionid = b.domain_sessionid and a.product_id = b.product_id
GROUP BY 1

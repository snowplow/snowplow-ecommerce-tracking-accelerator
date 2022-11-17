-- Out-of-stock page views and entrances
SELECT
    product_id,
    COUNT(DISTINCT event_id) as number_views,
    COUNT(DISTINCT CASE WHEN page_view_in_session_index = 1 THEN event_id END) as number_entrances
FROM
    `$1`.`$2`.snowplow_ecommerce_product_interactions
WHERE
    is_product_view
    AND product_inventory_status = 'out_of_stock'

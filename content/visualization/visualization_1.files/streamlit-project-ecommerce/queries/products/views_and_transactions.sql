SELECT
    product_id,
    sum(case when is_product_view then 1 else 0 end) as Views,
    sum(case when is_product_transaction then 1 else 0 end) as Transactions
FROM
    `$1`.`$2`.snowplow_ecommerce_product_interactions
WHERE
    DATE(derived_tstamp) > "2022-10-01"
GROUP BY product_id

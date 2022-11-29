SELECT
    domain_sessionid,
    start_tstamp,
    end_tstamp,
    number_carts_created - (number_carts_emptied + number_carts_transacted) AS number_of_abandoned_cart
FROM
    `$1`.`$2`.snowplow_ecommerce_sessions
WHERE
    DATE(start_tstamp) >= "2022-10-01"
    AND number_carts_created > (number_carts_emptied + number_carts_transacted)
ORDER BY
    3 DESC
LIMIT
    5

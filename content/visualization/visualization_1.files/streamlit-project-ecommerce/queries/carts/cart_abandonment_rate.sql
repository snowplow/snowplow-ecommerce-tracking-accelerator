-- cart abandonment rate
with daily_cart_stats AS (
    select
        DATE(start_tstamp) as cart_date,
        SUM(number_carts_created) as number_carts_created,
        SUM(number_carts_transacted + number_carts_emptied) as number_carts_completed
    from
        `$1`.`$2`.snowplow_ecommerce_sessions
    group by 1
)

select
    cart_date,
    coalesce(number_carts_created) as number_carts_created,
    coalesce(number_carts_completed) as number_carts_completed,
    coalesce(1 - (number_carts_completed / number_carts_created * 1.0),0) as cart_abandonment_rate
from
    daily_cart_stats
order by 1 desc
limit 2

-- guest checkout rate
select
    COUNT(DISTINCT CASE WHEN ecommerce_user_is_guest THEN event_id END) /COUNT(DISTINCT event_id) * 1.0 as guest_checkout_rate
from
    `$1`.`$2`.snowplow_ecommerce_checkout_interactions
where
    checkout_succeeded

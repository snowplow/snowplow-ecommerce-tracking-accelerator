-- entrance per step in checkout process
select
    checkout_step_number,
    COUNT(DISTINCT CASE WHEN session_entered_at_step THEN event_id END) as number_entrance_step,
    COUNT(DISTINCT event_id) as number_total_views

from
    `$1`.`$2`.snowplow_ecommerce_checkout_interactions
group by 1

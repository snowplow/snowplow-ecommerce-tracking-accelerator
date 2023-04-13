+++
title= "Explore Snowplow data"
weight = 3
post = ""
+++

Processed data should now be loaded into your warehouse. In this section we will take a closer look at the output to get familiar with the derived tables.

***

#### **Step 1:** Check the output schemas
Head to the SQL editor of your choice to check the model's output. You should be able to see three new schemas created:
1. [your_custom_schema]_***scratch***: drop and recompute models that aid the incremental run
2. [your_custom_schema]_***derived***: main output models you can use in your downstream models and reporting
3. [your_custom_schema]_***snowplow_manifest***: tables that help the integrity and core incremental logic of the model

***
#### **Step 2:** Explore your data

Take some time to familiarize yourself with the derived tables. You could run a few simple queries such as the ones listed below. Make sure to modify the schema to be aligned with your custom dbt schema.

**Find out the last 5 sessions with abandoned carts using `derived.snowplow_ecommerce_sessions:`**

```sql

SELECT
    domain_sessionid,
    start_tstamp,
    end_tstamp,
    number_carts_created - (number_carts_emptied + number_carts_transacted) AS number_of_abandoned_cart
FROM
    YOUR_CUSTOM_SCHEMA.snowplow_ecommerce_sessions
WHERE
    DATE(start_tstamp) >= "2022-10-01"
    AND number_carts_created > (number_carts_emptied + number_carts_transacted)
ORDER BY
    3 DESC
LIMIT
    5

```

**Calculate the top product variant (based on transactions) using `derived.snowplow_ecommerce_product_interactions:`**
```sql

-- Top variant in transactions per product
select
    product_id,
    product_variant,
    COUNT(DISTINCT CASE WHEN is_product_transaction THEN event_id END) as number_purchased,
from
    YOUR_CUSTOM_SCHEMA.snowplow_ecommerce_product_interactions
GROUP BY 1,2
ORDER BY 1,2,3 DESC

```


**Find out which checkout step your customer sessions are entering the checkout in using `derived.snowplow_ecommerce_checkout_interactions:`**
```sql

-- entrance per step in checkout process
select
    checkout_step_number,
    COUNT(DISTINCT CASE WHEN session_entered_at_step THEN event_id END) as number_entrance_step,
    COUNT(DISTINCT event_id) as number_total_views

from
    YOUR_CUSTOM_SCHEMA.snowplow_ecommerce_checkout_interactions
group by 1

```

***

Check out the **database** section of the [documentation site](https://snowplow.github.io/dbt-snowplow-ecommerce/#!/overview/snowplow_ecommerce) for a full breakdown of what the output should look like.

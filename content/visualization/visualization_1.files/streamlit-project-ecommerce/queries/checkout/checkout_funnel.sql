WITH
    unique_steps AS (
    SELECT
        DISTINCT ecommerce_page_type,
        checkout_step_number
    FROM
        `$1`.`$2`.snowplow_ecommerce_checkout_interactions a
    WHERE
        DATE(a.derived_tstamp) >= "2022-10-01"
    ),

    session_steps AS (
    SELECT
        domain_sessionid,
        MIN(checkout_step_number) AS earliest_step,
        MAX(checkout_step_number) AS latest_step
    FROM
        `$1`.`$2`.snowplow_ecommerce_checkout_interactions a
    WHERE
        DATE(a.derived_tstamp) >= "2022-10-01"
    GROUP BY
        1
    )

SELECT
    ecommerce_page_type as Step,
    checkout_step_number,
    CASE
        WHEN earliest_step > 1 THEN TRUE
    ELSE
    FALSE
END
    AS session_entered_at_step,
    COUNT(*) AS Volume
FROM
    session_steps a
LEFT JOIN
    unique_steps b
ON
    b.checkout_step_number BETWEEN a.earliest_step
    AND a.latest_step
GROUP BY
    1, 2, 3
ORDER BY
    1

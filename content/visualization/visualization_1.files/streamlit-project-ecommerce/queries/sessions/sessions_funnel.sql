WITH
    step_numbers AS (
    SELECT
        'session' AS step,
        0 AS step_number
    UNION ALL
    SELECT
        'viewed_product' AS step,
        1 AS step_number
    UNION ALL
    SELECT
        'added_to_cart' AS step,
        2 AS step_number
    UNION ALL
    SELECT
        'checked_out' AS step,
        3 AS step_number
    UNION ALL
    SELECT
        'transacted' AS step,
        4 AS step_number
    ),

    funnel_steps AS (
    SELECT
        domain_sessionid,
        1 AS session,
        CASE
            WHEN number_product_views > 0 THEN 1
        ELSE
        0
    END
        AS viewed_product,
        CASE
            WHEN number_add_to_carts > 0 THEN 1
        ELSE
        0
    END
        AS added_to_cart,
        CASE
            WHEN number_unique_checkout_steps_attempted > 0 THEN 1
        ELSE
        0
    END
        AS checked_out,
        CASE
            WHEN number_product_transactions > 0 THEN 1
        ELSE
        0
    END
        AS transacted
    FROM
        `$1`.`$2`.snowplow_ecommerce_sessions
    WHERE
        DATE(start_tstamp) >= "2022-10-01"
    ),

    unpivoted AS(
    SELECT
        *
    FROM
        funnel_steps UNPIVOT(had_step FOR step IN (session,
                viewed_product,
                added_to_cart,
                checked_out,
                transacted))
    ),

    check_entered_step AS (
    SELECT
        a.*,
        b.step_number,
        CASE
            WHEN MIN(CASE
                WHEN step_number !=0 THEN step_number
        END
            ) OVER (PARTITION BY domain_sessionid) = step_number
        AND step_number != 1 THEN TRUE
        ELSE
        FALSE
    END
        AS session_entered_at_step
    FROM
        unpivoted a
    LEFT JOIN
        step_numbers b
    ON
        a.step = b.step
    )

SELECT
    Step,
    step_number,
    session_entered_at_step,
    SUM(had_step) AS Volume
FROM
    check_entered_step
GROUP BY
    1, 2, 3
ORDER BY
    2

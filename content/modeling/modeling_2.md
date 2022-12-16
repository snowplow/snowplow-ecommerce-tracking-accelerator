+++
title= "Set-up and run dbt Package"
weight = 2
post = ""
+++

This step assumes you have data in a table named `ATOMIC.EVENTS` which will be used to run the snowplow-ecommerce dbt package to model Snowplow e-commerce data.

#### **Step 1:** Set-up Variables

The snowplow_ecommerce dbt package comes with a list of variables, each with a default value that you may need to overwrite in your own dbt project's `dbt_project.yml` file. For details you can have a look at the installed package's default variables which can be found at `[dbt_project_name]/dbt_packages/snowplow_ecommerce/dbt_project.yml` or check out the [package docs](https://docs.snowplow.io/docs/modeling-your-data/modeling-your-data-with-dbt/).

For the sake of simplicity we have selected the variables that you will most likely need to overwrite, the rest can be changed at a later stage if and when it is needed.

- `snowplow__start_date`: The date of the first tracked event.
- `snowplow__ecommerce_event_names`: List of event names to include in our e-commerce data, default is just `snowplow_ecommerce_action`
- `snowplow__events`: Variable to overwrite the events table in case it is named differently.
- `snowplow__number_category_levels`: Variable to overwrite the maximum number of levels you have in your product categories e.g. `books/fiction/magical-fiction` has 3 levels
- `snowplow__number_checkout_steps`: The index of the checkout step which represents a completed transaction. This is required to enable working checkout funnel analysis.

To overwrite these, add the following snippet to the `dbt_project.yml`:

```yml
vars:
  snowplow_web:
    snowplow__start_date: '2022-10-01'
    snowplow__ecommerce_event_names: ['snowplow_ecommerce_action']
    snowplow__events: 'atomic.events'
    snowplow__number_category_levels: 4
    snowplow__number_checkout_steps: 4
```
#### **Step 2:** Add the selectors.yml to your project

The web package provides a suite of suggested selectors to help run and test the models.

These are defined in the [selectors.yml](https://github.com/snowplow/dbt-snowplow-ecommerce/blob/main/selectors.yml) file within the package, however to use these model selections you will need to copy this file into your own dbt project directory.

This is a top-level file and therefore should sit alongside your `dbt_project.yml` file.

***
#### **Step 3:** Run the model

Execute the following either through your CLI or from within dbt Cloud. If your data is spread over a period of more than 30 days you will need to run the model more than once to fully process your data.

```
dbt run --selector snowplow_ecommerce
```

This should take a couple of minutes to run each time, depending on how many events you have per day.

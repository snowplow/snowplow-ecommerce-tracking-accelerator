+++
title = "Install Snowplow dbt Package"
weight = 1
post = ""
+++

#### **Step 1:** Add snowplow-ecommerce package
Add the snowplow-ecommerce package to your `packages.yml` file. The latest version can be found [here](https://hub.getdbt.com/snowplow/snowplow_ecommerce/latest/)

```yml
packages:
  - package: snowplow/snowplow_ecommerce
    version: {{<component name="snowplow_ecommerce_latest">}} 
```

***

#### **Step 2:** Install the package
Install the package by running:

```
dbt deps
```

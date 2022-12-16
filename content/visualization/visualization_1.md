+++
title = "Streamlit"
post = ""
weight = 1
+++

Streamlit uses Python to build shareable dashboards without the need for front-end development experience.

Download the `streamlit-project-ecommerce` template and copy the unzipped folder to your project directory to get started.

{{% attachments style="blue" %}}
{{% /attachments %}}


#### **Step 1:** Install requirements
Run the command below to install the project requirements and run the virtual environment.

❗❗ **This implementation has been tested with the following dependencies: *python=3.9.13, streamlit=1.12.0, pandas_gbq=0.17.9*. If you run into package compatibility issues or encounter any errors try using them to build your own environment.**


```bash
pipenv install
pipenv shell
```

#### **Step 2:** Set-up Database Connection
Open `secrets.toml` and add your bigquery service account details. Make sure you specify your custom `derived` dataset which will be the source schema for the dashboard.

{{% notice warning %}}
Ensure `secrets.toml` is in `.gitignore` to keep your information safe.
{{% /notice %}}

```toml
# .streamlit/secrets.toml

[gcp_service_account]
type = "service_account"
project_id = "xxx"
private_key_id = "xxx"
private_key = "xxx"
client_email = "xxx"
client_id = "xxx"
auth_uri = "https://accounts.google.com/o/oauth2/auth"
token_uri = "https://oauth2.googleapis.com/token"
auth_provider_x509_cert_url = "https://www.googleapis.com/oauth2/v1/certs"
client_x509_cert_url = "xxx"

[bigquery]
project_id = "xxx"
dataset = "dbt_xxx_derived"

```
#### **Step 3:** Run the Streamlit dashboard
Run the command below to run the streamlit locally

```bash
streamlit run Dashboard.py
```

The dashboard contains a selection of common e-commerce visualizations including shopping behavior, top abandoned products, product list performance and checkout abandonment. This is a great starting point to build further analysis on top of.

!['Streamlit Dashboard Example'](../images/streamlit_dashboard.png?height=40pc)

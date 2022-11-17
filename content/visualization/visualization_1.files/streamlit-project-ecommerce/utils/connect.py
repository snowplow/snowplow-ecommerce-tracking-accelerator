#!/usr/bin/env python
from google.oauth2 import service_account
import pandas_gbq
import streamlit as st

WAREHOUSE = "bigquery"

# Perform query.
def get_data_from_bigquery(filename):
    with open(filename, "r") as f:
        query = f.read()

    db_creds = st.secrets["bigquery"]
    project = db_creds["project_id"]
    dataset = db_creds["dataset"]

    query = query.replace('$1', project)
    query = query.replace('$2', dataset)

    df = pandas_gbq.read_gbq(query, credentials = service_account.Credentials.from_service_account_info(st.secrets["gcp_service_account"]))

    return df


def get_data(query_file):
    if WAREHOUSE == "bigquery":
        df = get_data_from_bigquery(query_file)

    return df

from utils.connect import get_data
import streamlit as st
import plotly.express as px
import pandas as pd
import datetime


def main():

    st.set_page_config(layout="wide", page_title="Products")
    current_hour = datetime.datetime.now().hour
    if current_hour < 12:
        greeting = 'morning'
    elif current_hour < 18:
        greeting = 'afternoon'
    else:
        greeting = 'evening'

    st.title(f"Good {greeting}, welcome to your Snowplow Ecommerce Insights dashboard")

    data_load_state = st.text("Loading data...")
    brand_revenues = get_data("queries/products/brand_revenues.sql")
    # cart_removal_rate = get_data('queries/products/cart_removal_rate.sql')
    # out_of_stock_entrances = get_data('queries/products/out_of_stock_entrances.sql')
    out_of_stock_views = get_data('queries/products/out_of_stock_views.sql')
    product_engagement_score = get_data('queries/products/product_engagement_score.sql')
    revenue_categories = get_data('queries/products/revenue_categories.sql')
    # variant_popularity_carts = get_data('queries/products/variant_popularity_carts.sql')
    variant_popularity_transactions = get_data('queries/products/variant_popularity_transactions.sql')
    # view_to_cart_rate = get_data('queries/products/view_to_cart_rate.sql')
    # view_to_transaction_rate = get_data('queries/products/view_to_transaction_rate.sql')
    views_and_transactions = get_data('queries/products/views_and_transactions.sql')
    product_list_performance = get_data('queries/products/product_list_performance.sql')

    checkout_abandonment_rate = get_data('queries/checkout/checkout_abandonment_rate.sql')
    checkout_funnel = get_data('queries/checkout/checkout_funnel.sql')
    customer_order_count = get_data('queries/checkout/customer_order_count.sql')
    # entrance_per_step = get_data('queries/checkout/entrance_per_step.sql')
    guest_checkout_rate = get_data('queries/checkout/guest_checkout_rate.sql')
    payment_methods = get_data('queries/checkout/payment_methods.sql')
    transaction_quantity = get_data('queries/checkout/transaction_quantity.sql')
    transaction_value = get_data('queries/checkout/transaction_value.sql')

    cart_abandonment_rate = get_data('queries/carts/cart_abandonment_rate.sql')
    abandoned_products_top_5 = get_data('queries/carts/abandoned_products_top_5.sql')

    sessions_funnel = get_data('queries/sessions/sessions_funnel.sql')

    data_load_state.text("")

    st.subheader("Summary")

    col1, col2, col3, col4, col5 = st.columns([1, 1, 1, 1, 1])

    with col1:
        st.metric(
            label = 'Transactions',
            value = sum(customer_order_count.iloc[:,1])
        )

    with col2:
        st.metric(
            label = 'Avg. Order Value',
            value = '€' + str(round(transaction_value.at[0, 'average_transaction_quantity'], 2))
        )

    with col3:
        st.metric(
            label = 'Avg. Basket Size',
            value = str(round(transaction_quantity.at[0, 'average_transaction_quantity'], 2))
        )


    with col4:
        st.metric(
            label = 'Top Brand',
            value = brand_revenues.at[0, 'product_brand'],
            delta= '€' + str(brand_revenues.at[0, 'total_revenue'])
        )

    with col5:
        st.metric(
            label = 'Top Category',
            value = revenue_categories.at[0, 'product_category'],
            delta= str(revenue_categories.at[0, 'total_revenue']) + ' Units'
        )


    st.subheader("Products")

    col1, col2 = st.columns([1, 2])
    with col1:
        fig = px.scatter(views_and_transactions, x = 'Views', y= 'Transactions', hover_data = ['Views', 'Transactions', 'product_id'])

        fig.update_layout(
            height=300,
            width=700,
            margin={"l": 20, "r": 20, "t": 25, "b": 0},
            legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
            title_text="Views and Transactions of products"
        )
        st.plotly_chart(fig, use_container_width=True)

    with col2:
        fig = px.line(out_of_stock_views.rename(columns = {'out_of_stock_views': 'Number of Views'}), x = 'Date', y = 'Number of Views')
        fig.update_layout(
            height=300,
            width=700,
            margin={"l": 20, "r": 20, "t": 25, "b": 0},
            legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
            title_text="Out of stock product views"
        )
        st.plotly_chart(fig, use_container_width=True)

    st.caption('Product List Performance')
    st.dataframe(product_list_performance.rename(columns = {'product_list_name': 'Product List', 'list_views': 'List Views', 'product_viewed': 'Product List Clicks', 'cart_product': 'Product Adds to Basket', 'transact_product': 'Product Checkouts', 'unique_transactions': 'Unique Purchases', 'product_revenue': 'Product Revenue', 'CTR': ' Product List CTR'}), use_container_width = True)

    st.subheader("Checkouts")

    checkout_funnel = checkout_funnel.rename(columns = {'session_entered_at_step' : 'Session Entered at Step'})
    fig = px.funnel(checkout_funnel, y='Volume', x='Step', color='Session Entered at Step')

    fig.update_layout(
        height=300,
        width=700,
        margin={"l": 20, "r": 20, "t": 25, "b": 0},
        legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
        title_text="Checkout Funnel"
    )
    st.plotly_chart(fig, use_container_width=True)

    grouped_checkout = checkout_funnel.drop(columns='Session Entered at Step').groupby(by = ['Step', 'checkout_step_number'], as_index=False).agg(Volume = ('Volume','sum')).sort_values('checkout_step_number')
    # st.dataframe(grouped_checkout)

    n_steps = max(grouped_checkout.loc[:,'checkout_step_number'])

    cols = st.columns([1 for i in range(n_steps-1)])
    for i, col in enumerate(cols):
        with col:
            lost_num = grouped_checkout.at[i, 'Volume'] - grouped_checkout.at[i +1, 'Volume']
            lost_perc = round(lost_num/grouped_checkout.at[i, 'Volume']*100, 1)
            st.metric(
                label = '🔻'+ '\n' + f'Step {i+1} Dropoff',
                value =  str(lost_num)+ ' (' + str(lost_perc) +'%)'
                )

    st.write('\n')
    st.write('\n')

    col1, col2, col3 = st.columns([1, 2, 1])
    with col1:
        st.metric(
                label = 'Checkout Abandonment Rate',
                value = str(round(checkout_abandonment_rate.iat[0,0]* 100, 1)) + '%'
                )

    with col2:
        fig = px.pie(payment_methods, values = 'number_transactions', names = 'transaction_payment_method')
        fig.update_layout(
            height=300,
            width=700,
            xaxis=dict(tickformat=".2%"),
            yaxis=dict(tickformat=".2%"),
            margin={"l": 20, "r": 20, "t": 25, "b": 0},
            legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
            title_text="Payment Methods"
        )
        st.plotly_chart(fig, use_container_width=True)

    with col3:
        st.metric(
                label = 'Guest Checkout Rate',
                value = str(round(guest_checkout_rate.iat[0,0]* 100, 1)) + '%'
                )



    st.subheader("Carts")

    col1, col2 = st.columns([1, 2])

    with col1:
        st.metric(
            label = 'Cart Abandonment Rate (daily)',
            value = str(round(cart_abandonment_rate.at[0,'cart_abandonment_rate'] * 100, 1))+'%',
            delta = str(round((cart_abandonment_rate.at[0,'cart_abandonment_rate'] - cart_abandonment_rate.at[1,'cart_abandonment_rate'])*100, 1)) + '%',
            delta_color='inverse'
            )

    with col2:
        #TODO Last 5 abandoned products?
        fig = px.bar(abandoned_products_top_5.rename(columns = {'total_abandoned': 'Total Abandoned'}), x = 'product_id', y = 'Total Abandoned')
        fig.update_layout(
            height=300,
            width=700,
            margin={"l": 20, "r": 20, "t": 25, "b": 0},
            legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
            title_text="Top 5 abandoned products"
        )
        st.plotly_chart(fig, use_container_width=True)


    st.subheader("Sessions")


    sessions_funnel = sessions_funnel.rename(columns = {'session_entered_at_step' : 'Session Entered at Step'})
    fig = px.funnel(sessions_funnel, y='Volume', x='Step', color='Session Entered at Step')

    fig.update_layout(
        height=300,
        width=700,
        margin={"l": 20, "r": 20, "t": 25, "b": 0},
        legend=dict(yanchor="top", y=0.99, xanchor="right", x=0.99),
        title_text="Sessions Funnel"
    )
    # fig.update_traces(marker_colorbar_yanchor='bottom', selector=dict(type='funnel'))
    fig.update_traces(marker_colorbar_xanchor='left', selector=dict(type='funnel'))
    st.plotly_chart(fig, use_container_width=True)

    col1, col2, col3, col4 , _ = st.columns([1, 1, 1, 1, 1])

    with col1:
        no_shop_num = sessions_funnel.at[0, 'Volume'] - sessions_funnel.at[1, 'Volume']
        no_shop_perc = round(no_shop_num/sessions_funnel.at[0, 'Volume']*100, 1)
        st.metric(
            label = '🔻'+ '\n' + 'No Shopping Activity',
            value = str(no_shop_num)+ ' (' + str(no_shop_perc) +'%)'
            )

    with col2:
        no_bask_num = sessions_funnel.at[1, 'Volume'] - sessions_funnel.at[2, 'Volume']
        no_bask_perc =  round(no_shop_num/sessions_funnel.at[1, 'Volume']*100, 1)
        st.metric(
            label = '🔻'+ '\n' + 'No Basket Addition',
            value = str(no_bask_num)+ ' (' + str(no_bask_perc) +'%)'
            )

    with col3:
        bask_adban_num = sessions_funnel.at[2, 'Volume'] - sessions_funnel.at[3, 'Volume']
        bask_adban_perc =  round(no_shop_num/sessions_funnel.at[2, 'Volume']*100, 1)
        st.metric(
            label = '🔻'+ '\n' + 'Basket Abandonment',
            value = str(bask_adban_num)+ ' (' + str(bask_adban_perc) +'%)'
            )

    with col4:
        check_aband_num = sessions_funnel.at[3, 'Volume'] - sessions_funnel.at[4, 'Volume']
        check_aband_perc =  round(check_aband_num/sessions_funnel.at[3, 'Volume']*100, 1)
        st.metric(
            label = '🔻'+ '\n' + 'Checkout Abandonment',
            value = str(check_aband_num)+ ' (' + str(check_aband_perc) +'%)'
            )


if __name__ == "__main__":
    main()

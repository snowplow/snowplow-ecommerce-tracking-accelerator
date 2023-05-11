+++
title = "Migrating from Enhanced Ecommerce or Google Analytics 4 Ecommerce"
weight = 1.5
post = ""
+++

If you already use Google Analytics 4 ecommerce or Universal Analytics Enhanced Ecommerce to collect information about the shopping behavior of your users, we have prepared a way to quickly implement Snowplow Ecommerce without making many changes on your current setup.

The _transitional_ API that we provide, depends on the standardized [dataLayer](https://developers.google.com/tag-platform/tag-manager/web/datalayer) structure for both Google Analytics ecommerce implementations. This would make it easier for the transition to happen either through Google Tag Manager, which has more control over the dataLayer, or custom code that uses the standard ecommerce structures. 

When using Google Tag Manager, you have straightforward access to the dataLayer ecommerce object. This can be achieved with a dataLayer variable as follows:
![ecommerce dataLayer variable](../images/gtm_ecommerce_v1.png?width=60pc&classes=shadow)
The *version* of the dataLayer variable will matter if it happens that you use the [recursive merge](https://www.simoahava.com/gtm-tips/data-layer-variable-versions-explained/#so-what) feature of Version 2 Google Tag Manager variables. Otherwise, any reference to the `ecommerce` attribute on the dataLayer would do just fine as input on the _transitional API_.

{{% notice info %}}
This should be considered a way to quickly collect data and extract value from the Snowplow Ecommerce implementation without making many code changes but to get the full value of it, you should properly plan a full migration.
{{% /notice %}}

You can follow the sections below depending on you implementation:
- [Universal Analytics Enhanced Ecommerce](#universal-analytics-enhanced-ecommerce)
- [Google Analytics 4 ecommerce](#google-analytics-4-ecommerce)

### Universal Analytics Enhanced Ecommerce

The standard Universal Analytics Enhanced Ecommerce implementation is based on the official [guide reference](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce).

Every API method receives as a first argument the `ecommerce` attribute of the `dataLayer` including the information of the most current ecommerce interaction you wish to track.

**Important:** The `dataLayer.currencyCode` attribute must be available for all product interactions. Otherwise, almost all methods accept an `Options` object which can include the currency code as follows:

```ts
method( {{dataLayer.ecommerce reference}} , { currency: "currency code" });
```

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### Measuring Product Impressions

This method corresponds to the equivalent Enhanced Ecommerce [product impressions event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#product-impressions).

```ts
import { trackEnhancedEcommerceProductListView } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommerceProductListView( {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measuring Product Clicks

This method corresponds to the equivalent Enhanced Ecommerce [product list click event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#product-clicks).

```ts
import { trackEnhancedEcommerceProductListClick } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommerceProductListClick( {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measuring Views of Product Details

This method corresponds to the equivalent Enhanced Ecommerce [product detail event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#details).

```ts
import { trackEnhancedEcommerceProductDetail } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommerceProductDetail( {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measuring Promotion Impressions

This method corresponds to the equivalent Enhanced Ecommerce [promotion view event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#promo-impressions).

```ts
import { trackEnhancedEcommercePromoView } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommercePromoView( {{dataLayer.ecommerce reference}} );
```

#### Measuring Promotion Clicks

This method corresponds to the equivalent Enhanced Ecommerce [promotion click event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#promo-clicks).

```ts
import { trackEnhancedEcommercePromoClick } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommercePromoClick( {{dataLayer.ecommerce reference}} );
```

#### Adding a Product to a Shopping Cart

This method corresponds to the equivalent Enhanced Ecommerce [add to cart event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#cart).

```ts
import { trackEnhancedEcommerceAddToCart } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommerceAddToCart( {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the addition.

#### Removing a Product from a Shopping Cart

This method corresponds to the equivalent Enhanced Ecommerce [remove from cart event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#remove).

```ts
import { trackEnhancedEcommerceRemoveFromCart } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommerceRemoveFromCart( {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the removal.

#### Measuring Checkout Steps

This method corresponds to the equivalent Enhanced Ecommerce [checkout event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#checkoutstep).

```ts
import { trackEnhancedEcommerceCheckoutStep } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommerceCheckoutStep( {{dataLayer.ecommerce reference}}, checkoutOption);
```

- Where `checkoutOption` is a key value pair object of available [Snowplow checkout options](https://github.com/snowplow/iglu-central/trenhancedecommerce/master/schemas/com.snowplowanalytics.snowplow.ecommerce/checkout_step/jsonschema), except `step` which is retrieved from the dataLayer directly.

#### Measuring Purchases

This method corresponds to the equivalent Enhanced Ecommerce [purchase event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#purchases).

```ts
import { trackEnhancedEcommercePurchase } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackEnhancedEcommercePurchase( {{dataLayer.ecommerce reference}}, {
    paymentMethod: string,
    currency?: string
});
```

- Where `paymentMethod` is the payment method selected in this transaction. This attributes corresponds to the `payment_method` of the [transaction schema](https://github.com/snowplow/iglu-central/blob/master/schemas/com.snowplowanalytics.snowplow.ecommerce/transaction/jsonschema/1-0-0#L30). Defaults to `unknown`. 


{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### Measuring Product Impressions

This method corresponds to the equivalent Enhanced Ecommerce [product impressions event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#product-impressions) for a single list.

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommerceProductListView:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measuring Product Clicks

This method corresponds to the equivalent Enhanced Ecommerce [product list click event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#product-clicks).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommerceProductListClick:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measuring Views of Product Details

This method corresponds to the equivalent Enhanced Ecommerce [product detail event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#details).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommerceProductDetail:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measuring Promotion Impressions

This method corresponds to the equivalent Enhanced Ecommerce [promotion view event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#promo-impressions).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommercePromoView:{trackerName}", {{dataLayer.ecommerce reference}} );
```

#### Measuring Promotion Clicks

This method corresponds to the equivalent Enhanced Ecommerce [promotion click event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#promo-clicks).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommercePromoClick:{trackerName}", {{dataLayer.ecommerce reference}} );
```

#### Adding a Product to a Shopping Cart

This method corresponds to the equivalent Enhanced Ecommerce [add to cart event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#cart).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommerceAddToCart:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the addition.

#### Removing a Product from a Shopping Cart

This method corresponds to the equivalent Enhanced Ecommerce [remove from cart event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#remove).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommerceRemoveFromCart:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the removal.

#### Measuring Checkout Steps

This method corresponds to the equivalent Enhanced Ecommerce [checkout event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#checkoutstep).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommerceCheckoutStep:{trackerName}",  {{dataLayer.ecommerce reference}}, checkoutOption);
```

- Where `checkoutOption` is a key value pair object of available [Snowplow checkout options](https://github.com/snowplow/iglu-central/trenhancedecommerce/master/schemas/com.snowplowanalytics.snowplow.ecommerce/checkout_step/jsonschema), except `step` which is retrieved from the dataLayer directly.

#### Measuring Purchases

This method corresponds to the equivalent Enhanced Ecommerce [purchase event](https://developers.google.com/analytics/devguides/collection/ua/gtm/enhanced-ecommerce#purchases).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackEnhancedEcommercePurchase:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

- Where `paymentMethod` is the payment method selected in this transaction. This attributes corresponds to the `payment_method` of the [transaction schema](https://github.com/snowplow/iglu-central/blob/master/schemas/com.snowplowanalytics.snowplow.ecommerce/transaction/jsonschema/1-0-0#L30). Defaults to `unknown`. 

{{% /tab %}}

{{< /tabs >}}

### Google Analytics 4 ecommerce

The Google Analytics 4 ecommerce implementation is based on the official [guide reference](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm).

Every API method receives as a first argument the `ecommerce` attribute of the `dataLayer` including the information of the most current ecommerce interaction you wish to track.

**Important:** The `dataLayer.ecommerce.currency` attribute must be available for all product interactions. Otherwise, almost all methods accept an `Options` object which can include the currency code as follows:

```ts
method( {{dataLayer.ecommerce reference}} , { currency: "currency code" });
```

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### Measure viewing an item list 

This method corresponds to the equivalent [view_item_list event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#select_an_item_from_a_list).

```ts
import { trackGA4ViewItemList } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4ViewItemList( {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measure selecting an item from a list

This method corresponds to the equivalent [select_item event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#select_item-gtm).

```ts
import { trackGA4SelectItem } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4SelectItem( {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measure an item details view

This method corresponds to the equivalent [view_item event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#view_item_details).

```ts
import { trackGA4ViewItem } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4ViewItem( {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measure promotion views

This method corresponds to the equivalent [view_promotion event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#view_promotion-gtm).

```ts
import { trackGA4ViewPromotion } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4ViewPromotion( {{dataLayer.ecommerce reference}} );
```

#### Measure promotion selection

This method corresponds to the equivalent [select_promotion event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#select_promotion-gtm).

```ts
import { trackGA4SelectPromotion } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4SelectPromotion( {{dataLayer.ecommerce reference}} );
```

#### Measure an addition to a shopping cart

This method corresponds to the equivalent [add_to_cart event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_or_remove_an_item_from_a_shopping_cart).

```ts
import { trackGA4AddToCart } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4AddToCart( {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the addition.

#### Measure a removal from a shopping cart

This method corresponds to the equivalent [remove_from_cart event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_or_remove_an_item_from_a_shopping_cart).

```ts
import { trackGA4RemoveFromCart } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4RemoveFromCart( {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the removal.

#### Measure the beginning of a checkout process

This method corresponds to the equivalent [begin_checkout event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#initiate_the_checkout_process).

```ts
import { trackGA4BeginCheckout } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4BeginCheckout(step, {
    step?: number
});
```

- Where `step` is a number representing the step of the checkout funnel. Defaults to 1, mimicking the `begin_checkout` GA4 event.

#### Measure the selection of shipping information during checkout

This method corresponds to the equivalent [add_shipping_info event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_shipping_info-gtm).

```ts
import { trackGA4AddShippingInfo } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4AddShippingInfo( {{dataLayer.ecommerce reference}}, {
    step: number
});
```

- Where `step` is a number representing the step of the checkout funnel.

#### Measure the selection of payment info during checkout

This method corresponds to the equivalent [add_payment_info event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_payment_info-gtm).

```ts
import { trackGA4AddPaymentOptions } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4AddPaymentOptions( {{dataLayer.ecommerce reference}}, {
    step: number
});
```

- Where `step` is a number representing the step of the checkout funnel.

#### Measure a purchase

This method corresponds to the equivalent [purchase event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#make_a_purchase_or_issue_a_refund).

```ts
import { trackGA4Transaction } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackGA4Transaction( {{dataLayer.ecommerce reference}}, {
    paymentMethod: string,
    currency?: string
});
```

- Where `paymentMethod` is the payment method selected in this transaction. This attributes corresponds to the `payment_method` of the [transaction schema](https://github.com/snowplow/iglu-central/blob/master/schemas/com.snowplowanalytics.snowplow.ecommerce/transaction/jsonschema/1-0-0#L30). Defaults to `unknown`. 


{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### Measure viewing an item list

This method corresponds to the equivalent [view_item_list event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#select_an_item_from_a_list).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4ViewItemList:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measure selecting an item from a list

This method corresponds to the equivalent [select_item event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#select_item-gtm).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4SelectItem:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measure an item details view

This method corresponds to the equivalent [view_item event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#view_item_details).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4ViewItem:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    currency?: string
});
```

#### Measure promotion views

This method corresponds to the equivalent [view_promotion event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#view_promotion-gtm).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4ViewPromotion:{trackerName}", {{dataLayer.ecommerce reference}} );
```

#### Measure promotion selection

This method corresponds to the equivalent [select_promotion event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#select_promotion-gtm).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4SelectPromotion:{trackerName}", {{dataLayer.ecommerce reference}} );
```

####  Measure an addition to a shopping cart

This method corresponds to the equivalent [add_to_cart event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_or_remove_an_item_from_a_shopping_cart).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4AddToCart:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the addition.

#### Measure an removal from a shopping cart

This method corresponds to the equivalent [remove_from_cart event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_or_remove_an_item_from_a_shopping_cart).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4RemoveFromCart:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    finalCartValue: number,
    currency?: string,
});
```

- Where `finalCartValue` is the value of the cart after the removal.

#### Measure the beginning of a checkout process

This method corresponds to the equivalent [begin_checkout event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#initiate_the_checkout_process).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4BeginCheckout:{trackerName}", {
    step?: number
});
```

- Where `step` is a number representing the step of the checkout funnel. Defaults to 1, mimicking the `begin_checkout` GA4 event.

#### Measure the selection of shipping information during checkout

This method corresponds to the equivalent [add_shipping_info event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_shipping_info-gtm).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4AddShippingInfo:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    step: number
});
```

- Where `step` is a number representing the step of the checkout funnel.

#### Measure the selection of payment info during checkout

This method corresponds to the equivalent [add_payment_info event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#add_payment_info-gtm).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4AddPaymentOptions:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    step: number
});
```

- Where `step` is a number representing the step of the checkout funnel.

#### Measure a purchase

This method corresponds to the equivalent [purchase event](https://developers.google.com/analytics/devguides/collection/ga4/ecommerce?client_type=gtm#make_a_purchase_or_issue_a_refund).

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackGA4Transaction:{trackerName}",  {{dataLayer.ecommerce reference}}, {
    paymentMethod: string,
    currency?: string
});
```

- Where `paymentMethod` is the payment method selected in this transaction. This attributes corresponds to the `payment_method` of the [transaction schema](https://github.com/snowplow/iglu-central/blob/master/schemas/com.snowplowanalytics.snowplow.ecommerce/transaction/jsonschema/1-0-0#L30). Defaults to `unknown`. 

{{% /tab %}}

{{< /tabs >}}

+++
title = "Track Transaction Errors"
weight = 8
post = ""
+++

Transaction error events can be used to track issues during any step of a transaction being processed by the system. The API is generic and can be used in any case of an incomplete transaction, including payment processor/gateway errors. These data can be combined with the rich Snowplow schema to provide insights such as:
- Fraud rejections and other risk related rejections
- Processor/gateway internal errors

Additionally by tracking the error types, soft or hard, and the resolution selected by your system, you can test and optimize the flows and experience you provide to your customers facing issues with completing a transaction.

---

#### Tracking transaction errors

In this section, we will showcase how to track a transaction error event for a transaction. In many cases, transaction processing is completed through a backend system and not the website frontend, that is why we also showcase a server-side language examples. You can use any of our trackers to achieve the same result.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackTransactionError`

To track a transaction error you can use the `trackTransactionError` method with the following attributes:

```ts
import { trackTransactionError } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackTransactionError({
  resolution,
  error_code,
  error_shortcode,
  error_description,
  error_type,
  transaction
});
```

- Where `resolution` is the system action selected in this failure event E.g. Allowing retries, blocking the payment gateway, contacting the user or other.
- Where `error_code` is the error-identifying code for the transaction issue E.g. E522.
- Where `error_shortcode` is the shortcode for the transaction error E.g declined_by_api, pm_card_radarBlock.
- Where `error_description` is the longer description for the transaction error.
- Where `error_type` is the type of error the specific issue is regarded as in the standard classification of _hard_ and _soft_. Hard error types mean the customer must provide another form of payment e.g. an expired card. Soft errors can be the result of temporary issues where retrying might be successful e.g. processor declined the transaction.
- Where `transaction` is the transaction the issue occurred in.

**Example usage:**

```ts
import { trackTransactionError } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackTransactionError({
  resolution: "rejection",
  error_code: "E123",
  error_shortcode: "CARD_DECLINE",
  error_description: "Card has been declined by the issuing bank.",
  error_type: "hard",
  transaction: {
    revenue: 45,
    currency: "EUR",
    transaction_id: "T12345",
    payment_method: "card" 
  }
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackTransactionError`

To track a transaction error you can use the `trackTransactionError` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackTransactionError:{trackerName}", {
  resolution,
  error_code,
  error_shortcode,
  error_description,
  error_type,
  transaction
});
```

- Where `resolution` is the system action selected in this failure event E.g. Allowing retries, blocking the payment gateway, contacting the user or other.
- Where `error_code` is the error-identifying code for the transaction issue E.g. E522.
- Where `error_shortcode` is the shortcode for the transaction error E.g declined_by_api, pm_card_radarBlock.
- Where `error_description` is the longer description for the transaction error.
- Where `error_type` is the type of error the specific issue is regarded as in the standard classification of _hard_ and _soft_. Hard error types mean the customer must provide another form of payment e.g. an expired card. Soft errors can be the result of temporary issues where retrying might be successful e.g. processor declined the transaction.
- Where `transaction` is the transaction the issue occurred in.

**Example usage:**

```ts
window.snowplow("trackTransactionError:{trackerName}", {
  resolution: "rejection",
  error_code: "E123",
  error_shortcode: "CARD_DECLINE",
  error_description: "Card has been declined by the issuing bank.",
  error_type: "hard",
  transaction: {
    revenue: 45,
    currency: "EUR",
    transaction_id: "T12345",
    payment_method: "card" 
  }
});
```

{{% /tab %}}

{{% tab name="Node.js" %}}
#### Track transaction errors using a self describing event

To track transaction errors in the Node.js tracker, you can use the `buildSelfDescribingEvent` method together with the correct parameters for the transaction error event.

```ts
/* Where `t` is a placeholder for the initialized tracker instance on your application.  */

t.track(buildSelfDescribingEvent({
  event: {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/snowplow_ecommerce_action/jsonschema/1-0-2",
    data: {
      type: "trns_error"
    }
  }
}), [
  /* Transaction Error context */
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/transaction_error/jsonschema/1-0-0",
    data: { 
      /* ...Transaction error data */
    }
  },
  /* Transaction context */
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/transaction/jsonschema/1-0-0",
    data: {
      /* ...Transaction data */
    }
  }
]);
```
Where transaction error data can include:
- `resolution` as the system action selected in this failure event E.g. Allowing retries, blocking the payment gateway, contacting the user or other.
- `error_code` as the error-identifying code for the transaction issue E.g. E522.
- `error_shortcode` as the shortcode for the transaction error E.g declined_by_api, pm_card_radarBlock.
- `error_description` as the longer description for the transaction error.
- `error_type` as the type of error the specific issue is regarded as in the standard classification of _hard_ and _soft_. Hard error types mean the customer must provide another form of payment e.g. an expired card. Soft errors can be the result of temporary issues where retrying might be successful e.g. processor declined the transaction.
For the transaction taking part in the process, an additional transaction data context is added on the contexts to be sent with the event.


**Example usage:**

```ts
/* Where `t` is a placeholder for the initialized tracker instance on your application.  */

t.track(buildSelfDescribingEvent({
  event: {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/snowplow_ecommerce_action/jsonschema/1-0-2",
    data: {
      type: "trns_error"
    }
  }
}), [
  /* Transaction Error context */
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/transaction_error/jsonschema/1-0-0",
    data: { 
      resolution: "rejection",
      error_code: "E123",
      error_shortcode: "CARD_DECLINE",
      error_description: "Card has been declined by the issuing bank.",
      error_type: "hard",
    }
  },
  /* Transaction context */
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/transaction/jsonschema/1-0-0",
    data: {
      revenue: 45,
      currency: "EUR",
      transaction_id: "T12345",
      payment_method: "card" 
    }
  }
]);
```

To learn more about tracking self describing events in Node.js take a look at the `buildSelfDescribingEvent` [documentation](https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/javascript-trackers/node-js-tracker/node-js-tracker-v3/tracking-events/#track-self-describing-events-withbuildselfdescribingevent).

{{% /tab %}}

{{< /tabs >}}

Where `transaction` can have the following attributes:
| attribute | type | description | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
| transaction_id | `string` | The ID of the transaction | ✅ |
| currency | `string` | The currency used for the transaction (ISO 4217). | ✅ |
| revenue | `number` | The revenue of the transaction. | ✅ |
| payment_method | `string` | The payment method used for the transaction. | ✅ |
| total_quantity | `number` | Total quantity of items in the transaction. | ✅ |
| tax | `number` | Total amount of tax on the transaction. | ✘ |
| shipping | `number` | Total cost of shipping on the transaction. | ✘ |
| discount_code | `string` | Discount code used. | ✘ |
| discount_amount | `number` | Discount amount taken off. | ✘ |
| credit_order | `boolean` | Whether the transaction is a credit order or not. | ✘ |
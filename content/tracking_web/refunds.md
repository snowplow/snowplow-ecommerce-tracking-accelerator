+++
title = "Track Refunds"
weight = 7
post = ""
+++

Transaction refund events can be used to track products, or transactions as a whole, that ultimately ended on a refund request.

---

#### Tracking refunds

In this section, we will showcase how to track a refund request for a transaction. In many cases, refunds are completed through a backend system and not the website frontend, that is why we also showcase a server-side language example. You can use any of our trackers to achieve the same result.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackRefund`

To track a refund you can use the `trackRefund` method with the following attributes:

```ts
import { trackRefund } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackRefund({
  transaction_id,
  currency,
  refund_amount,
  refund_reason,
  products,
});
```

- Where `transaction_id` is the ID of the transaction to be refunded.
- Where `currency` is the currency used for the transaction.
- Where `refund_amount` is the monetary amount that was refunded.
- Where `refund_reason` is the reason the refund took place.
- Where `products` is the array of products which were refunded on the transaction. Refunds might be partial, so only the products that were refunded should be sent.

**Example usage:**

```ts
import { trackRefund } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackRefund({
  transaction_id: "T12345",
  currency: "USD",
  refund_amount: 200,
  refund_reason: "false_size",
  products: [
    {
      id: "P125",
      name: "Baseball T",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 200,
      currency: "USD",
    },
  ],
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackRefund`

To track a refund you can use the `trackRefund` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackRefund:{trackerName}", {
  transaction_id,
  currency,
  refund_amount,
  refund_reason,
  products,
});
```

- Where `transaction_id` is the ID of the transaction to be refunded.
- Where `currency` is the currency used for the transaction.
- Where `refund_amount` is the monetary amount that was refunded.
- Where `refund_reason` is the reason the refund took place.
- Where `products` is the array of products which were refunded on the transaction. Refunds might be partial, so only the products that were refunded should be sent.

**Example usage:**

```ts
window.snowplow("trackRefund:{trackerName}", {
  transaction_id: "T12345",
  currency: "USD",
  refund_amount: 200,
  refund_reason: "false_size",
  products: [
    {
      id: "P125",
      name: "Baseball T",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 200,
      currency: "USD",
    },
  ],
});
```

{{% /tab %}}

{{% tab name="Node.js" %}}
#### Track refunds using a self describing event

To track refunds in the Node.js tracker, you can use the `buildSelfDescribingEvent` method together with the correct parameters for the refund event.

```ts
/* Where `t` is a placeholder for the initialized tracker instance on your application.  */

t.track(buildSelfDescribingEvent({
  event: {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/snowplow_ecommerce_action/jsonschema/1-0-1",
    data: {
      type: "refund"
    }
  }
}, [
  /* Refund context */
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/refund/jsonschema/1-0-0",
    data: { 
      /* ...Refund data */
    }
  },
  /* Product context */
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/product/jsonschema/1-0-0",
    data: {
      /* ...Product data */
    }
  }
]));
```
Where refund data can include:
- `transaction_id` as the ID of the transaction to be refunded.
- `currency` as the currency used for the transaction.
- `refund_amount` as the monetary amount that was refunded.
- `refund_reason` as the reason the refund took place.
For each product taking part in the refund process, an additional product data context is added on the contexts to be sent with the event.


**Example usage:**

```ts
/* Where `t` is a placeholder for the initialized tracker instance on your application.  */

t.track(buildSelfDescribingEvent({
  event: {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/snowplow_ecommerce_action/jsonschema/1-0-1",
    data: {
      type: "refund"
    }
  }
}, [
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/refund/jsonschema/1-0-0",
    data: { 
      refund_amount: 200,
      currency: "USD", 
      transaction_id: "T12345", 
      refund_reason: "false_size" 
    }
  },
  {
    schema: "iglu:com.snowplowanalytics.snowplow.ecommerce/product/jsonschema/1-0-0",
    data: {
      id: "P125",
      name: "Baseball T",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 200,
      currency: "USD",
    }
  }
]));
```

To learn more about tracking self describing events in Node.js take a look at the `buildSelfDescribingEvent` [documentation](https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/javascript-trackers/node-js-tracker/node-js-tracker-v3/tracking-events/#track-self-describing-events-withbuildselfdescribingevent).

{{% /tab %}}

{{< /tabs >}}

Where `product` can have the following attributes:
| attribute | type | description | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
| id | `string` | SKU or product ID. | ✅ |
| currency | `string` | Currency in which the product is being priced (ISO 4217). | ✅ |
| price | `number` | Price of the product at the current time. | ✅ |
| name | `string` | Name or title of the product. | ✘ |
| category | `string` | Category the product belongs to. Use a consistent separator to express multiple levels. E.g. Woman/Shoes/Sneakers. The number of levels is defined by the user. | ✘ |
| list_price | `number` | Recommended or list price of a product. | ✘ |
| quantity | `number` | Quantity of the product taking part in the action. Used for Cart events. | ✘ |
| size | `string` | Size of the product. E.g. XL, XS, M. | ✘ |
| variant | `string` | Variant of the product. E.g. Red, Heavy, Leather. | ✘ |
| brand | `string` | Brand of the product. | ✘ |
| inventory_status | `string` | Inventory status of the product. E.g. in stock, out of stock, preorder, backorder. | ✘ |
| position | `number` | Position the product was presented in a list of products. Used in Product List events. | ✘ |
| creative_id | `string` | Identifier/Name/Url for the creative presented on a list or product view. | ✘ |

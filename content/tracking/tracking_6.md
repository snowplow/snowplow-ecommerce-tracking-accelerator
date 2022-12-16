+++
title = "Track Transactions"
weight = 6
post = ""
+++

Transaction events are used to track the successful completion of a purchase/transaction on your e-commerce store.

---

### Tracking transaction completion

In this section, we will showcase how to track a completed transaction.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackTransaction`

To track a completed transaction you can use the `trackTransaction` method with the following attributes:

```ts
import { trackTransaction } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackTransaction({
  transaction_id,
  revenue,
  currency,
  payment_method,
  total_quantity,
  tax,
  shipping,
  discount_code,
  discount_amount,
  credit_order,
  products,
});
```

- Where `transaction_id` is the ID of the transaction.
- Where `revenue` is the total value of the transaction.
- Where `currency` is the currency used for the transaction.
- Where `payment_method` is the payment method used for the transaction.
- Where `total_quantity` is the total quantity of items in the transaction.
- Where `tax` is the total amount of tax on the transaction.
- Where `shipping` is the total cost of shipping on the transaction.
- Where `discount_code` is the discount code used.
- Where `discount_amount` is the discount amount taken off.
- Where `credit_order` is whether the transaction is a credit order or not.
- Where `products` is an array of products included on the transaction.

**Example usage:**

```ts
import { trackTransaction } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackTransaction({
  transaction_id: "T12345",
  revenue: 230,
  currency: "USD",
  payment_method: "credit_card",
  total_quantity: 1,
  tax: 20,
  shipping: 10,
  products: [
    {
      id: "P125",
      name: "Baseball T",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 200,
      inventory_status: "in stock",
      currency: "USD",
      position: 3,
    },
  ],
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackTransaction`

To track a completed transaction you can use the `trackTransaction` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackTransaction:{trackerName}", {
  transaction_id,
  revenue,
  currency,
  payment_method,
  total_quantity,
  tax,
  shipping,
  discount_code,
  discount_amount,
  credit_order,
  products,
});
```

- Where `transaction_id` is the ID of the transaction.
- Where `revenue` is the total value of the transaction.
- Where `currency` is the currency used for the transaction.
- Where `payment_method` is the payment method used for the transaction.
- Where `total_quantity` is the total quantity of items in the transaction.
- Where `tax` is the total amount of tax on the transaction.
- Where `shipping` is the total cost of shipping on the transaction.
- Where `discount_code` is the discount code used.
- Where `discount_amount` is the discount amount taken off.
- Where `credit_order` is whether the transaction is a credit order or not.
- Where `products` is an array of products included on the transaction.

**Example usage:**

```ts
window.snowplow("trackTransaction:{trackerName}", {
  transaction_id: "T12345",
  revenue: 230,
  currency: "USD",
  payment_method: "credit_card",
  total_quantity: 1,
  tax: 20,
  shipping: 10,
  products: [
    {
      id: "P125",
      name: "Baseball T",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 200,
      inventory_status: "in stock",
      currency: "USD",
      position: 3,
    },
  ],
});
```

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

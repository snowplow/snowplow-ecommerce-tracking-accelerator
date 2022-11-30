+++
title = "Track Cart Events"
weight = 3
post = ""
+++

Cart events are used for tracking additions and removals from a shopping cart.

---

### Add to cart event

In this section, we will showcase how to track product additions to the cart.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackAddToCart`

To track a product/s addition to the cart you can use the `trackAddToCart` method with the following attributes:

```ts
import { trackAddToCart } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackAddToCart({ products: Product[], total_value, currency, cart_id });
```

- Where `products` is an array with the product/s added to cart.
- Where `total_value` is the value of the cart after the addition.
- Where `currency` is the currency of the cart.
- Where `cart_id` is an identifier for the current cart instance.

**Example usage:**

```ts
import { trackAddToCart } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackAddToCart({
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
  total_value: 200,
  currency: "USD",
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackAddToCart`

To track a product/s addition to the cart you can use the `trackAddToCart` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackAddToCart:{trackerName}", { products: Product[], total_value, currency, cart_id });
```

- Where `products` is an array with the product/s added to cart.
- Where `total_value` is the value of the cart after the addition.
- Where `currency` is the currency of the cart.
- Where `cart_id` is an identifier for the current cart instance.

**Example usage:**

```ts
window.snowplow("trackAddToCart:{trackerName}", {
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
  total_value: 200,
  currency: "USD",
});
```

{{% /tab %}}

{{< /tabs >}}

### Remove from cart event

In this section, we will showcase how to track product removals from the cart.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackRemoveFromCart`

To track a product view you can use the `trackRemoveFromCart` method with the following attributes:

```ts
import { trackRemoveFromCart } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackRemoveFromCart({ products: Product[], total_value, currency, cart_id });
```

- Where `products` is an array with the product/s removed from cart.
- Where `total_value` is the value of the cart after the removal.
- Where `currency` is the currency of the cart.
- Where `cart_id` is an identifier for the current cart instance.

**Example usage:**

```ts
import { trackRemoveFromCart } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackRemoveFromCart({
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
  total_value: 0, /* Total cart value after removal of the product */
  currency: "USD",
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackRemoveFromCart`

To track a product view you can use the `trackRemoveFromCart` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackRemoveFromCart:{trackerName}", { products: Product[], total_value, currency, cart_id });
```

- Where `products` is an array with the product/s removed from cart.
- Where `total_value` is the value of the cart after the removal.
- Where `currency` is the currency of the cart.
- Where `cart_id` is an identifier for the current cart instance.

**Example usage:**

```ts
window.snowplow("trackRemoveFromCart:{trackerName}", {
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
  total_value: 0,
  currency: "USD",
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
| category | `string` | Category the product belongs to. Use a consistent separator to express multiple levels. E.g. Woman/Shoes/Sneakers. | ✘ |
| list_price | `number` | Recommended or list price of a product. | ✘ |
| quantity | `number` | Quantity of the product taking part in the action. Used for Cart events. | ✘ |
| size | `string` | Size of the product. E.g. XL, XS, M. | ✘ |
| variant | `string` | Variant of the product. E.g. Red, Heavy, Leather. | ✘ |
| brand | `string` | Brand of the product. | ✘ |
| inventory_status | `string` | Inventory status of the product. E.g. in stock, out of stock, preorder, backorder. | ✘ |
| position | `number` | Position the product was presented in a list of products. Used in Product List events. | ✘ |
| creative_id | `string` | Identifier/Name/Url for the creative presented on a list or product view. | ✘ |

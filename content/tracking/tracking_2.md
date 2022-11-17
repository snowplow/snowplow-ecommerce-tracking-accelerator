+++
title = "Track Product Views"
weight = 2
post = ""
+++

Product view events are commonly used to track a user visiting a product page.

![Product view](../images/product_view.png)

---

#### Product view events

In this section, we will showcase how to track product view events.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackProductView`

To track a product view you can use the `trackProductView` method with the following attributes:

```ts
import { trackProductView } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackProductView(product: Product);
```

**Example usage:**

```ts
import { trackProductView } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackProductView({
    id: "P125",
    name: "Baseball T",
    brand: "Snowplow",
    category: "Mens/Apparel",
    price: 200,
    currency: "USD",
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackProductView`

To track a product view you can use the `trackProductView` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackProductView:{trackerName}", product: Product);
```

**Example usage:**

```ts
window.snowplow("trackProductView:{trackerName}", {
    id: "12345",
    name: "Baseball T",
    brand: "Snowplow",
    category: "apparel",
    price: 200,
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

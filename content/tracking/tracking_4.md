+++
title = "Track Product List Events"
weight = 4.5
post = ""
+++

Product List events are used for tracking views and interactions of any kind of list of products on an ecommerce store. These events are more commonly used for the product list pages, but can also be used to track similar list-like elements such as:

- Shop-The-Look lists.
- Frequently-Bought-With lists.
- Product recommendations.
- Product search results.

![Product list](../images/product_list.png)

---

### Product list view event

In this section, we will showcase how to track product list views.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackProductListView`

To track a product list view you can use the `trackProductListView` method with the following attributes:

```ts
import { trackProductListView } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackProductListView({ products: Product[], name });
```

- Where `products` is an array of products being viewed from the list.
- Where `name` is the name of the list being viewed. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```ts
import { trackProductListView } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackProductListView({
  products: [
    {
      id: "P123",
      name: "Fashion red",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 100,
      inventory_status: "in stock",
      currency: "USD",
      position: 1,
    },
    {
      id: "P124",
      name: "Fashion green",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 119,
      inventory_status: "in stock",
      currency: "USD",
      position: 2,
    },
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
  name: "Recommended Products",
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackProductListView`

To track a product/s addition to the cart you can use the `trackProductListView` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackProductListView:{trackerName}", { products: Product[], name });
```

- Where `products` is an array of products being viewed from the list.
- Where `name` is the name of the list being viewed. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```ts
window.snowplow("trackProductListView:{trackerName}", {
  products: [
    {
      id: "P123",
      name: "Fashion red",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 100,
      inventory_status: "in stock",
      currency: "USD",
      position: 1,
    },
    {
      id: "P124",
      name: "Fashion green",
      brand: "Snowplow",
      category: "Mens/Apparel",
      price: 119,
      inventory_status: "in stock",
      currency: "USD",
      position: 2,
    },
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
  name: "Recommended Products",
});
```

{{% /tab %}}

{{< /tabs >}}

### Product list click event

In this section, we will showcase how to track a click/selection of a product in a product list.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackProductListClick`

To track a click/selection of a product in a product list you can use the `trackProductListClick` method with the following attributes:

```ts
import { trackProductListClick } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackProductListClick({ product: Product, name });
```

- Where `product` is the product being clicked/selected from the list.
- Where `name` is the name of the list the product is currently in. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```ts
import { trackProductListClick } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackProductListClick({
  product: {
    id: "P124",
    name: "Fashion green",
    brand: "Snowplow",
    category: "Mens/Apparel",
    price: 119,
    inventory_status: "in stock",
    currency: "USD",
    position: 2,
  },
  name: "Recommended Products",
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackProductListClick`

To track a click/selection of a product in a product list you can use the `trackProductListClick` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackProductListClick:{trackerName}", { product: Product[], name });
```

- Where `product` is the product being clicked/selected from the list.
- Where `name` is the name of the list the product is currently in. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```ts
window.snowplow("trackProductListClick:{trackerName}", {
  product: {
    id: "P124",
    name: "Fashion green",
    brand: "Snowplow",
    category: "Mens/Apparel",
    price: 119,
    inventory_status: "in stock",
    currency: "USD",
    position: 2,
  },
  name: "Recommended Products",
});
```

{{% /tab %}}

{{< /tabs >}}

Where `product` can have the following attributes:

|    attribute     |   type   |                                                    description                                                     | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
|        id        | `string` |                                                 SKU or product ID.                                                 |    ✅    |
|     currency     | `string` |                             Currency in which the product is being priced (ISO 4217).                              |    ✅    |
|      price       | `number` |                                     Price of the product at the current time.                                      |    ✅    |
|       name       | `string` |                                           Name or title of the product.                                            |    ✘     |
|     category     | `string` | Category the product belongs to. Use a consistent separator to express multiple levels. E.g. Woman/Shoes/Sneakers. |    ✘     |
|    list_price    | `number` |                                      Recommended or list price of a product.                                       |    ✘     |
|     quantity     | `number` |                      Quantity of the product taking part in the action. Used for Cart events.                      |    ✘     |
|       size       | `string` |                                        Size of the product. E.g. XL, XS, M.                                        |    ✘     |
|     variant      | `string` |                                 Variant of the product. E.g. Red, Heavy, Leather.                                  |    ✘     |
|      brand       | `string` |                                               Brand of the product.                                                |    ✘     |
| inventory_status | `string` |                 Inventory status of the product. E.g. in stock, out of stock, preorder, backorder.                 |    ✘     |
|     position     | `number` |               Position the product was presented in a list of products. Used in Product List events.               |    ✘     |
|   creative_id    | `string` |                     Identifier/Name/Url for the creative presented on a list or product view.                      |    ✘     |

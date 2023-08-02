+++
title = "Track Product List Events"
weight = 4.5
post = ""
+++

Product List events are used for tracking views and interactions of any kind of list of products on an e-commerce store. These events are more commonly used for the product list screens, but can also be used to track similar list-like elements such as:

- Shop-The-Look lists.
- Frequently-Bought-With lists.
- Product recommendations.
- Product search results.

![Product list](../images/product_list.png)

---

### Product list view event

In this section, we will showcase how to track product list views.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `ProductListViewEvent`

To track a product list view you can use the `ProductListViewEvent` with the following attributes:

```swift
ProductListViewEvent(products: [ProductEntity], name: String?)
```

- Where `products` is an array of products being viewed from the list.
- Where `name` is the name of the list being viewed. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```swift
let product = ProductEntity(id: "productId", category: "software", currency: "USD", price: 99.99)
let event = ProductListViewEvent(products: [product], name: "snowplowProducts")

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `ProductListViewEvent`

To track a product list view you can use the `ProductListViewEvent` with the following attributes:

```kotlin
ProductListViewEvent(products: List<ProductEntity>, name: String?)
```

- Where `products` is an array of products being viewed from the list.
- Where `name` is the name of the list being viewed. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```kotlin
val product = ProductEntity(
  id = "productId", 
  category = "software", 
  currency = "USD", 
  price = 99.99
)
val event = ProductListViewEvent(listOf(product), name = "snowplowProducts")

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `ProductListViewEvent`

To track a product list view you can use the `ProductListViewEvent` with the following attributes:

```java
ProductListViewEvent(products: List<ProductEntity>, name: String?)
```

- Where `products` is an array of products being viewed from the list.
- Where `name` is the name of the list being viewed. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```java
ProductEntity product = new ProductEntity(
  "productId", // id
  "software", // category
  "USD", // currency
  99.99 // price
);
List<Product> products = new ArrayList<>();
products.add(product);
ProductListViewEvent event = new ProductListViewEvent(
  products, // products
  "snowplowProducts" // name
);

tracker.track(event);
```

{{% /tab %}}

{{< /tabs >}}

### Product list click event

In this section, we will showcase how to track a click/selection of a product in a product list.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `ProductListClickEvent`

To track a click/selection of a product in a product list you can use the `ProductListClickEvent` with the following attributes:

```swift
ProductListViewEvent(product: ProductEntity, name: String?)
```

- Where `product` is the product being clicked/selected from the list.
- Where `name` is the name of the list the product is currently in. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```swift
let product = ProductEntity(id: "productId", category: "software", currency: "USD", price: 99.99)
let event = ProductListClickEvent(product: product, name: "snowplowProducts")

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `ProductListClickEvent`

To track a click/selection of a product in a product list you can use the `ProductListClickEvent` with the following attributes:

```kotlin
ProductListViewEvent(product: ProductEntity, name: String?)
```

- Where `product` is the product being clicked/selected from the list.
- Where `name` is the name of the list the product is currently in. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```kotlin
val product = ProductEntity(
  id = "productId", 
  category = "software", 
  currency = "USD", 
  price = 99.99
)
val event = ProductListClickEvent(product, name = "snowplowProducts")

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `ProductListClickEvent`

To track a click/selection of a product in a product list you can use the `ProductListClickEvent` with the following attributes:

```java
ProductListViewEvent(product: ProductEntity, name: String?)
```

- Where `product` is the product being clicked/selected from the list.
- Where `name` is the name of the list the product is currently in. For the list names, you can use any kind of friendly name or a codified language to express the labeling of the list. E.g. 'Shoes - Men - Sneakers','Search results: "unisex shoes"', 'Product page upsells'

**Example usage:**

```java
ProductEntity product = new ProductEntity(
  "productId", // id
  "software", // category
  "USD", // currency
  99.99 // price
);
ProductListClickEvent event = new ProductListClickEvent(
  product, // product
  "snowplowProducts" // name
);

tracker.track(event);
```

{{% /tab %}}
{{< /tabs >}}

Where `ProductEntity` can have the following attributes:
|    attribute    |   type   |                                                                           description                                                                           | required |
|:---------------:|:--------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------:|
|       id        | `string` |                                                                       SKU or product ID.                                                                        |    ✅     |
|    currency     | `string` |                                                    Currency in which the product is being priced (ISO 4217).                                                    |    ✅     |
|      price      | `number` |                                                            Price of the product at the current time.                                                            |    ✅     |
|      name       | `string` |                                                                  Name or title of the product.                                                                  |    ✘     |
|    category     | `string` | Category the product belongs to. Use a consistent separator to express multiple levels. E.g. Woman/Shoes/Sneakers. The number of levels is defined by the user. |    ✘     |
|    listPrice    | `number` |                                                             Recommended or list price of a product.                                                             |    ✘     |
|    quantity     | `number` |                                            Quantity of the product taking part in the action. Used for Cart events.                                             |    ✘     |
|      size       | `string` |                                                              Size of the product. E.g. XL, XS, M.                                                               |    ✘     |
|     variant     | `string` |                                                        Variant of the product. E.g. Red, Heavy, Leather.                                                        |    ✘     |
|      brand      | `string` |                                                                      Brand of the product.                                                                      |    ✘     |
| inventoryStatus | `string` |                                       Inventory status of the product. E.g. in stock, out of stock, preorder, backorder.                                        |    ✘     |
|    position     | `number` |                                     Position the product was presented in a list of products. Used in Product List events.                                      |    ✘     |
|   creativeId    | `string` |                                            Identifier/Name/Url for the creative presented on a list or product view.                                            |    ✘     |

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

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `ProductViewEvent`

To track a product view you can use the `ProductViewEvent` with the following attributes:

```swift
ProductViewEvent(product: ProductEntity)
```
- Where `product` is the product being viewed.

**Example usage:**

```swift
let product = ProductEntity(
  id: "plow2", 
  category: "snow.clearance.ploughs.large", 
  currency: "NOK", 
  price: 5000
)
let event = ProductViewEvent(product: product)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `ProductViewEvent`

To track a product view you can use the `ProductViewEvent` with the following attributes:

```kotlin
ProductViewEvent(product: ProductEntity)
```
- Where `product` is the product being viewed.

**Example usage:**

```kotlin
val product = ProductEntity(
    id = "plow2", 
    category = "snow.clearance.ploughs.large", 
    currency = "NOK", 
    price = 5000
)
val event = ProductViewEvent(product)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `ProductViewEvent`

To track a product view you can use the `ProductViewEvent` with the following attributes:

```java
ProductViewEvent(product: ProductEntity);
```
- Where `product` is the product being viewed.

**Example usage:**

```java
ProductViewEvent event = new ProductViewEvent(new ProductEntity(
    "plow2", // id
    "snow.clearance.ploughs.large",  // category
    "NOK", // currency
    5000 // price
  )
); 

tracker.track(event);
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

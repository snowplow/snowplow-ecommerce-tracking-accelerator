+++
title = "Track Refunds"
weight = 7
post = ""
+++

Transaction refund events can be used to track products, or transactions as a whole, that ultimately ended on a refund request.

---

#### Tracking refunds

In this section, we will showcase how to track a refund request for a transaction. In many cases, refunds are completed through a backend system. You can use any of our trackers to achieve the same result, by creating a custom refund event type based off `SelfDescribing` events and the same `transaction` schema.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `RefundEvent`

To track a refund you can use the `RefundEvent` with the following attributes:

```swift
RefundEvent(
  transactionId: String,
  currency: String,
  refundAmount: Number,
  refundReason: String?,
  products: [ProductEntity]?,
);
```

- Where `transactionId` is the ID of the transaction to be refunded.
- Where `currency` is the currency used for the transaction.
- Where `refundAmount` is the monetary amount that was refunded.
- Where `refundReason` is the reason the refund took place.
- Where `products` is the array of products which were refunded on the transaction. Refunds might be partial, so only the products that were refunded should be sent.

**Example usage:**

```swift
let product = ProductEntity(
  id: "P125", 
  name: "Baseball T",
  brand: "Snowplow",
  category: "Mens/Apparel",
  price: 200,
  currency: "USD"
)
let event = RefundEvent(
  transactionId: "id-123", // use the transaction ID from the original Transaction event
  refundAmount: 200, 
  currency: "USD",
  products: [product]
)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `RefundEvent`

To track a refund you can use the `RefundEvent` with the following attributes:

```kotlin
RefundEvent(
  transactionId: String,
  currency: String,
  refundAmount: Number,
  refundReason: String?,
  products: List<ProductEntity>?,
);
```

- Where `transactionId` is the ID of the transaction to be refunded.
- Where `currency` is the currency used for the transaction.
- Where `refundAmount` is the monetary amount that was refunded.
- Where `refundReason` is the reason the refund took place.
- Where `products` is the array of products which were refunded on the transaction. Refunds might be partial, so only the products that were refunded should be sent.

**Example usage:**

```kotlin
val product = ProductEntity(
  id = "P125", 
  name = "Baseball T",
  brand = "Snowplow",
  category = "Mens/Apparel",
  price = 200,
  currency = "USD"
)
val event = RefundEvent(
  transactionId = "id-123", // use the transaction ID from the original Transaction event
  refundAmount = 200, 
  currency = "USD",
  products = listOf(product)
)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `RefundEvent`

To track a refund you can use the `RefundEvent` with the following attributes:

```java
RefundEvent(
  transactionId: String,
  currency: String,
  refundAmount: Number,
  refundReason: String?,
  products: List<ProductEntity>?,
);
```

- Where `transactionId` is the ID of the transaction to be refunded.
- Where `currency` is the currency used for the transaction.
- Where `refundAmount` is the monetary amount that was refunded.
- Where `refundReason` is the reason the refund took place.
- Where `products` is the array of products which were refunded on the transaction. Refunds might be partial, so only the products that were refunded should be sent.

**Example usage:**

```java
ProductEntity product = new ProductEntity(
  "P125", // id
  "Mens/Apparel",  // category
  "USD", // currency
  200, // price
  null, // listPrice
  "Baseball T", // name
  null, // quantity
  null, // size
  null, // variant
  "Snowplow" // brand
);
RefundEvent event = new RefundEvent(
    "id-123", // id; use the transaction ID from the original Transaction event
    200, // refundAmount
    "USD", // currency
    null, // refundReason
    Arrays.asList(product) // products
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

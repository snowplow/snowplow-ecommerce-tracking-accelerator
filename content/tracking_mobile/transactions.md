+++
title = "Track Transactions"
weight = 6
post = ""
+++

Transaction events are used to track the successful completion of a purchase/transaction on your e-commerce store.

---

### Tracking transaction completion

In this section, we will showcase how to track a completed transaction.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `TransactionEvent`

To track a completed transaction you can use the `TransactionEvent` with the following attributes:

```swift
AddToCartEvent(transaction: TransactionEntity, products: [ProductEntity]?)
```

- Where `transaction` is a transaction object.
- Where `products` is an array with the product/s in the transaction.

**Example usage:**

```swift
let transaction = TransactionEntity(
  transactionId: "id-123", 
  revenue: 230, 
  currency: "GBP", 
  paymentMethod: "debit", 
  totalQuantity: 2,
  tax: 20,
  shipping: 10
)
let product = ProductEntity(
  id: "productId", 
  category: "clothes/shirts", 
  currency: "GBP", 
  price: 100
)

tracker.track(TransactionEvent(transaction: transaction, products: [product]))
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `TransactionEvent`

To track a completed transaction you can use the `TransactionEvent` with the following attributes:

```kotlin
AddToCartEvent(transaction: TransactionEntity, products: List<ProductEntity>?)
```

- Where `transaction` is a transaction object.
- Where `products` is an array with the product/s in the transaction.

**Example usage:**

```kotlin
val transaction = TransactionEntity(
  transactionId = "id-123", 
  revenue = 230, 
  currency = "GBP", 
  paymentMethod = "debit", 
  totalQuantity = 2,
  tax = 20,
  shipping = 10
)
val product = ProductEntity(
  id = "productId", 
  category = "clothes/shirts", 
  currency = "GBP", 
  price = 100
)

tracker.track(TransactionEvent(transaction: transaction, products: listOf(product)))
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `TransactionEvent`

To track a completed transaction you can use the `TransactionEvent` with the following attributes:

```java
AddToCartEvent(transaction: TransactionEntity, products: List<ProductEntity>?)
```

- Where `transaction` is a transaction object.
- Where `products` is an array with the product/s in the transaction.

**Example usage:**

```java
TransactionEntity transaction = TransactionEntity(
  "id-123", // transactionId
  230, // revenue
  "GBP", // currency
  "debit", // paymentMethod
  2, // totalQuantity
  20, // tax
  10 // shipping
);
ProductEntity product = new ProductEntity(
  "productId", // id
  "clothes/shirts", // category
  "GBP", // currency
  100 // price
);

tracker.track(TransactionEvent(transaction, Arrays.asList(product)))
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

Where `TransactionEntity` can have the following attributes:
|   attribute    |   type    |                    description                    | required |
|:--------------:|:---------:|:-------------------------------------------------:|:--------:|
| transactionId  | `string`  |             The ID of the transaction             |    ✅     |
|    currency    | `string`  | The currency used for the transaction (ISO 4217). |    ✅     |
|    revenue     | `number`  |          The revenue of the transaction.          |    ✅     |
| paymentMethod  | `string`  |   The payment method used for the transaction.    |    ✅     |
| totalQuantity  | `number`  |    Total quantity of items in the transaction.    |    ✅     |
|      tax       | `number`  |      Total amount of tax on the transaction.      |    ✘     |
|    shipping    | `number`  |    Total cost of shipping on the transaction.     |    ✘     |
|  discountCode  | `string`  |                Discount code used.                |    ✘     |
| discountAmount | `number`  |            Discount amount taken off.             |    ✘     |
|  creditOrder   | `boolean` | Whether the transaction is a credit order or not. |    ✘     |

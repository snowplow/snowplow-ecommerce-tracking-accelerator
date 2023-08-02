+++
title = "Track Cart Events"
weight = 3
post = ""
+++

Cart events are used for tracking additions and removals from a shopping cart.

---

### Add to cart event

In this section, we will showcase how to track product additions to the cart.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `AddToCartEvent`

To track a product/s addition to the cart you can use the `AddToCartEvent` with the following attributes:

```swift
AddToCartEvent(products: [ProductEntity], cart: CartEntity)
```

- Where `products` is an array with the product/s added to cart.
- Where `cart` is a cart object.

**Example usage:**

```swift
let product = ProductEntity(id: "productId", category: "clothes/shirts", currency: "EUR", price: 100.50)
let cart = CartEntity(totalValue: 200, currency: "EUR")
let event = AddToCartEvent(products: [product], cart: cart)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `AddToCartEvent`

To track a product/s addition to the cart you can use the `AddToCartEvent` with the following attributes:

```kotlin
AddToCartEvent(products: List<ProductEntity>, cart: CartEntity)
```

- Where `products` is an array with the product/s added to cart.
- Where `cart` is a cart object.

**Example usage:**

```kotlin
val product = ProductEntity(
  id = "productId", 
  category = "clothes/shirts", 
  currency = "EUR", 
  price = 100.50
)
val cart = CartEntity(totalValue = 200, currency = "EUR")
val event = AddToCartEvent(listOf(product), cart)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `AddToCartEvent`

To track a product/s addition to the cart you can use the `AddToCartEvent` with the following attributes:

```java
AddToCartEvent(products: List<ProductEntity>, cart: CartEntity)
```

- Where `products` is an array with the product/s added to cart.
- Where `cart` is a cart object.

**Example usage:**

```java
ProductEntity product = new ProductEntity(
  "productId", // id
  "clothes/shirts", // category
  "EUR", // currency
  100.50 // price
);
List<Product> products = new ArrayList<>();
products.add(product);

CartEntity cart = new CartEntity(
  200, // totalValue
  "EUR" // currency
);
AddToCartEvent event = new AddToCartEvent(products, cart);

tracker.track(event);
```

{{% /tab %}}

{{< /tabs >}}

### Remove from cart event

In this section, we will showcase how to track product removals from the cart.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `RemoveFromCartEvent`

To track a product/s removal from the cart you can use the `RemoveFromCartEvent` with the following attributes:

```swift
RemoveFromCartEvent(products: [ProductEntity], cart: CartEntity)
```

- Where `products` is an array with the product/s added to cart.
- Where `cart` is a cart object.

**Example usage:**

```swift
let product = ProductEntity(id: "productId", category: "clothes/shirts", currency: "EUR", price: 100.50)
let cart = CartEntity(totalValue: 200, currency: "EUR")
let event = RemoveFromCartEvent(products: [product], cart: cart)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `RemoveFromCartEvent`

To track a product/s removal from the cart you can use the `RemoveFromCartEvent` with the following attributes:

```kotlin
RemoveFromCartEvent(products: List<ProductEntity>, cart: CartEntity)
```

- Where `products` is an array with the product/s added to cart.
- Where `cart` is a cart object.

**Example usage:**

```kotlin
val product = ProductEntity(
  id = "productId", 
  category = "clothes/shirts", 
  currency = "EUR", 
  price = 100.50
)
val cart = CartEntity(totalValue = 200, currency = "EUR")
val event = RemoveFromCartEvent(listOf(product), cart)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `RemoveFromCartEvent`

To track a product/s removal from the cart you can use the `RemoveFromCartEvent` with the following attributes:

```java
RemoveFromCartEvent(products: List<ProductEntity>, cart: CartEntity)
```

- Where `products` is an array with the product/s added to cart.
- Where `cart` is a cart object.

**Example usage:**

```java
ProductEntity product = new ProductEntity(
  "productId", // id
  "clothes/shirts", // category
  "EUR", // currency
  100.50 // price
);
List<Product> products = new ArrayList<>();
products.add(product);

CartEntity cart = new CartEntity(
  200, // totalValue
  "EUR" // currency
);
RemoveFromCartEvent event = new RemoveFromCartEvent(products, cart);

tracker.track(event);
```

{{% /tab %}}

{{< /tabs >}}

Where `ProductEntity` can have the following attributes:
| attribute | type | description | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
| id | `string` | SKU or product ID. | ✅ |
| currency | `string` | Currency in which the product is being priced (ISO 4217). | ✅ |
| price | `number` | Price of the product at the current time. | ✅ |
| name | `string` | Name or title of the product. | ✘ |
| category | `string` | Category the product belongs to. Use a consistent separator to express multiple levels. E.g. Woman/Shoes/Sneakers. The number of levels is defined by the user. | ✘ |
| listPrice | `number` | Recommended or list price of a product. | ✘ |
| quantity | `number` | Quantity of the product taking part in the action. Used for Cart events. | ✘ |
| size | `string` | Size of the product. E.g. XL, XS, M. | ✘ |
| variant | `string` | Variant of the product. E.g. Red, Heavy, Leather. | ✘ |
| brand | `string` | Brand of the product. | ✘ |
| inventoryStatus | `string` | Inventory status of the product. E.g. in stock, out of stock, preorder, backorder. | ✘ |
| position | `number` | Position the product was presented in a list of products. Used in Product List events. | ✘ |
| creativeId | `string` | Identifier/Name/Url for the creative presented on a list or product view. | ✘ |

Where `CartEntity` can have the following attributes:
| attribute  |   type   |                     description                     | required |
|:----------:|:--------:|:---------------------------------------------------:|:--------:|
| totalValue | `number` | The total value of the cart after this interaction. |    ✅     |
|  currency  | `string` |       Currency used for this cart (ISO 4217).       |    ✅     |
|   cartId   | `string` |        The unique ID representing this cart.        |    ✘     |

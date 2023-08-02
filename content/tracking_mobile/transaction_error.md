+++
title = "Track Transaction Errors"
weight = 8
post = ""
+++

Transaction error events can be used to track issues during any step of a transaction being processed by the system. The API is generic and can be used in any case of an incomplete transaction, including payment processor/gateway errors. These data can be combined with the rich Snowplow schema to provide insights such as:
- Fraud rejections and other risk related rejections
- Processor/gateway internal errors

Additionally by tracking the error types, soft or hard, and the resolution selected by your system, you can test and optimize the flows and experience you provide to your customers facing issues with completing a transaction.

---

#### Tracking transaction errors

In this section, we will showcase how to track a transaction error event for a transaction. In many cases, transaction processing is completed through a backend system. You can use any of our trackers to achieve the same result, using custom `SelfDescribingEvent` and the same `transaction_error` schema.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `TransactionErrorEvent`

To track a transaction error you can use the `TransactionErrorEvent` with the following attributes:

```swift
TransactionErrorEvent(
  transaction: TransactionEntity,
  resolution: String?,
  erroCode: String?,
  errorShortcode: String?,
  errorDescription: String?,
  errorType: ErrorType?
)
```
- Where `transaction` is the transaction the issue occurred in.
- Where `resolution` is the system action selected in this failure event E.g. Allowing retries, blocking the payment gateway, contacting the user or other.
- Where `errorCode` is the error-identifying code for the transaction issue E.g. E522.
- Where `errorShortcode` is the shortcode for the transaction error E.g declined_by_api, pm_card_radarBlock.
- Where `errorDescription` is the longer description for the transaction error.
- Where `errorType` is the type of error the specific issue is regarded as in the standard classification of _hard_ and _soft_. Hard error types mean the customer must provide another form of payment e.g. an expired card. Soft errors can be the result of temporary issues where retrying might be successful e.g. processor declined the transaction. Provided as an `ErrorType` enum.

**Example usage:**

```swift
let transaction = TransactionEntity(
  transactionId: "id-123", 
  revenue: 50000, 
  currency: "JPY", 
  paymentMethod: "debit", 
  totalQuantity: 2
)
let event = TransactionErrorEvent(
  transaction: transaction, 
  errorCode: "E123", 
  errorShortcode: "CARD_DECLINE",
  errorDescription: "Card has been declined by the issuing bank.",
  resolution: "rejection",
  errorType: .hard
)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `TransactionErrorEvent`

To track a transaction error you can use the `TransactionErrorEvent` with the following attributes:

```kotlin
TransactionErrorEvent(
  transaction: TransactionEntity,
  resolution: String?,
  erroCode: String?,
  errorShortcode: String?,
  errorDescription: String?,
  errorType: ErrorType?
)
```
- Where `transaction` is the transaction the issue occurred in.
- Where `resolution` is the system action selected in this failure event E.g. Allowing retries, blocking the payment gateway, contacting the user or other.
- Where `errorCode` is the error-identifying code for the transaction issue E.g. E522.
- Where `errorShortcode` is the shortcode for the transaction error E.g declined_by_api, pm_card_radarBlock.
- Where `errorDescription` is the longer description for the transaction error.
- Where `errorType` is the type of error the specific issue is regarded as in the standard classification of _hard_ and _soft_. Hard error types mean the customer must provide another form of payment e.g. an expired card. Soft errors can be the result of temporary issues where retrying might be successful e.g. processor declined the transaction. Provided as an `ErrorType` enum.

**Example usage:**

```kotlin
val transaction = TransactionEntity(
  id = "id-123", 
  revenue = 50000,
  currency = "JPY",
  paymentMethod = "debit",
  totalQuantity = 2
)
val event = TransactionErrorEvent(
  transaction = transaction, 
  errorCode = "E123", 
  errorShortcode = "CARD_DECLINE",
  errorDescription = "Card has been declined by the issuing bank.",
  resolution = "rejection",
  errorType = ErrorType.Hard
)

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `TransactionErrorEvent`

To track a transaction error you can use the `TransactionErrorEvent` with the following attributes:

```java
TransactionErrorEvent(
  transaction: TransactionEntity,
  resolution: String?,
  erroCode: String?,
  errorShortcode: String?,
  errorDescription: String?,
  errorType: ErrorType?
)
```
- Where `transaction` is the transaction the issue occurred in.
- Where `resolution` is the system action selected in this failure event E.g. Allowing retries, blocking the payment gateway, contacting the user or other.
- Where `errorCode` is the error-identifying code for the transaction issue E.g. E522.
- Where `errorShortcode` is the shortcode for the transaction error E.g declined_by_api, pm_card_radarBlock.
- Where `errorDescription` is the longer description for the transaction error.
- Where `errorType` is the type of error the specific issue is regarded as in the standard classification of _hard_ and _soft_. Hard error types mean the customer must provide another form of payment e.g. an expired card. Soft errors can be the result of temporary issues where retrying might be successful e.g. processor declined the transaction. Provided as an `ErrorType` enum.

**Example usage:**

```java
TransactionEntity transaction = new TransactionEntity(
  "id-123", // id
  50000, // revenue
  "JPY", // currency
  "debit", // paymentMethod
  2 // totalQuantity
);
TransactionErrorEvent event = TransactionErrorEvent(
  transaction, // transaction
  "E123", // errorCode
  "CARD_DECLINE", // errorShortcode
  "Card has been declined by the issuing bank.", // errorDescription
  ErrorType.Hard // errorType
  "rejection" // resolution
)

tracker.track(event)
```

{{% /tab %}}

{{< /tabs >}}

Where `TransactionEntity` can have the following attributes:
| attribute | type | description | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
| transactionId | `string` | The ID of the transaction | ✅ |
| currency | `string` | The currency used for the transaction (ISO 4217). | ✅ |
| revenue | `number` | The revenue of the transaction. | ✅ |
| paymentMethod | `string` | The payment method used for the transaction. | ✅ |
| totalQuantity | `number` | Total quantity of items in the transaction. | ✅ |
| tax | `number` | Total amount of tax on the transaction. | ✘ |
| shipping | `number` | Total cost of shipping on the transaction. | ✘ |
| discountCode | `string` | Discount code used. | ✘ |
| discountAmount | `number` | Discount amount taken off. | ✘ |
| creditOrder | `boolean` | Whether the transaction is a credit order or not. | ✘ |

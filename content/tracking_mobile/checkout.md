+++
title = "Track Checkout Steps"
weight = 5
post = ""
+++

Checkout step events are used for tracking the progress and option selections of a user in the checkout funnel. These events can fit any multi-page or single-page checkout scenario, and we made sure to provide all sorts of options which can prove useful for further analysis.

![Checkout step](../images/checkout.png?width=60pc)

---

### Tracking a checkout step completion/progress

In this section, we will showcase how to track checkout process steps.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `CheckoutStepEvent`

To track a checkout step you can use the `CheckoutStepEvent` with the following attributes:

```swift
CheckoutStepEvent(
  step: Int,
  shippingPostcode: String?,
  billingPostcode: String?,
  shippingFullAddress: String?,
  billingFullAddress: String?,
  deliveryProvider: String?,
  deliveryMethod: String?,
  couponCode: String?,
  accountType: String?,
  paymentMethod: String?,
  proofOfPayment: String?,
  marketingOptIn: Bool?
);
```

Where the attributes are:

- **step** - Checkout step index.
- **shippingPostcode** - Shipping address postcode.
- **billingPostcode** - Billing address postcode.
- **shippingFullAddress** - Full shipping address.
- **billingFullAddress** - Full billing address.
- **deliveryProvider** - Can be used to discern delivery providers E.g. DHL, PostNL.
- **deliveryMethod** - Store pickup, standard delivery, express delivery, international.
- **couponCode** - Coupon applied at checkout.
- **accountType** - Selection of 'existing user' or 'guest checkout'.
- **paymentMethod** - Any kind of payment method the user selected to proceed. E.g. Card, PayPal, Alipay.
- **proofOfPayment** - Invoice or receipt.
- **marketingOptIn** - If opted in to marketing campaigns to the email address.

**Example usage:**

```swift
/* Step 1 - Account type selection */
let event = CheckoutStepEvent(step: 1, accountType: "guest checkout")

tracker.track(event)

/* Step 2 - Billing options selection */
let event = CheckoutStepEvent(step: 2, paymentMethod: "credit card", proofOfPayment: "invoice")

tracker.track(event)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `CheckoutStepEvent`

To track a checkout step you can use the `CheckoutStepEvent` with the following attributes:

```kotlin
CheckoutStepEvent(
  step: Int,
  shippingPostcode: String?,
  billingPostcode: String?,
  shippingFullAddress: String?,
  billingFullAddress: String?,
  deliveryProvider: String?,
  deliveryMethod: String?,
  couponCode: String?,
  accountType: String?,
  paymentMethod: String?,
  proofOfPayment: String?,
  marketingOptIn: Boolean?
);
```

Where the attributes are:

- **step** - Checkout step index.
- **shippingPostcode** - Shipping address postcode.
- **billingPostcode** - Billing address postcode.
- **shippingFullAddress** - Full shipping address.
- **billingFullAddress** - Full billing address.
- **deliveryProvider** - Can be used to discern delivery providers E.g. DHL, PostNL.
- **deliveryMethod** - Store pickup, standard delivery, express delivery, international.
- **couponCode** - Coupon applied at checkout.
- **accountType** - Selection of 'existing user' or 'guest checkout'.
- **paymentMethod** - Any kind of payment method the user selected to proceed. E.g. Card, PayPal, Alipay.
- **proofOfPayment** - Invoice or receipt.
- **marketingOptIn** - If opted in to marketing campaigns to the email address.

**Example usage:**

```kotlin
/* Step 1 - Account type selection */
val event = CheckoutStepEvent(step = 1, accountType = "guest checkout")

tracker.track(event)

/* Step 2 - Billing options selection */
val event = CheckoutStepEvent(step = 2, paymentMethod = "credit card", proofOfPayment = "invoice")

tracker.track(event)
```

{{% /tab %}}

{{% tab name="Java API" %}}

#### `CheckoutStepEvent`

To track a checkout step you can use the `CheckoutStepEvent` with the following attributes:

```java
CheckoutStepEvent(
  step: Int,
  shippingPostcode: String?,
  billingPostcode: String?,
  shippingFullAddress: String?,
  billingFullAddress: String?,
  deliveryProvider: String?,
  deliveryMethod: String?,
  couponCode: String?,
  accountType: String?,
  paymentMethod: String?,
  proofOfPayment: String?,
  marketingOptIn: Boolean?
);
```

Where the attributes are:

- **step** - Checkout step index.
- **shippingPostcode** - Shipping address postcode.
- **billingPostcode** - Billing address postcode.
- **shippingFullAddress** - Full shipping address.
- **billingFullAddress** - Full billing address.
- **deliveryProvider** - Can be used to discern delivery providers E.g. DHL, PostNL.
- **deliveryMethod** - Store pickup, standard delivery, express delivery, international.
- **couponCode** - Coupon applied at checkout.
- **accountType** - Selection of 'existing user' or 'guest checkout'.
- **paymentMethod** - Any kind of payment method the user selected to proceed. E.g. Card, PayPal, Alipay.
- **proofOfPayment** - Invoice or receipt.
- **marketingOptIn** - If opted in to marketing campaigns to the email address.

**Example usage:**

```java
/* Step 1 - Account type selection */
CheckoutStepEvent event = new CheckoutStepEvent(
  1, // step
  null, // shippingPostcode
  null, // billingPostcode
  null, // shippingFullAddress
  null, // billingFullAddress
  null, // deliveryProvider
  null, // deliveryMethod
  null, // couponCode
  "guest checkout" // accountType
);

tracker.track(event);

/* Step 2 - Billing options selection */
CheckoutStepEvent event = new CheckoutStepEvent(
  2, // step
  null, // shippingPostcode
  null, // billingPostcode
  null, // shippingFullAddress
  null, // billingFullAddress
  null, // deliveryProvider
  null, // deliveryMethod
  null, // couponCode
  null, // accountType
  "credit card", // paymentMethod
  "invoice" // proofOfPayment
);

tracker.track(event)
```

{{% /tab %}}
{{< /tabs >}}

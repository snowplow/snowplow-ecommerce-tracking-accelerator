+++
title = "Track Checkout Steps"
weight = 5
post = ""
+++

Checkout step events are used for tracking the progress and option selections of a user in the checkout funnel. These event can fit any multi-page or single-page checkout scenario and we made sure to provide all sorts of options which can prove useful for further analysis.

![Checkout step](../images/checkout.png)

---

### Tracking a checkout step completion/progress

In this section, we will showcase how to track checkout process steps.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackCheckoutStep`

To track a checkout step you can use the `trackCheckoutStep` method with the following attributes:

```ts
import { trackCheckoutStep } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackCheckoutStep(checkoutStep: CheckoutStep);
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackCheckoutStep`

To track a checkout step you can use the `trackCheckoutStep` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackCheckoutStep:{trackerName}", checkoutStep: CheckoutStep);
```

{{% /tab %}}

{{< /tabs >}}

Where `checkoutStep` can have the following attributes:

- **step** - Checkout step index.
- **shipping_postcode** - Shipping address postcode.
- **billing_postcode** - Billing address postcode.
- **shipping_full_address** - Full shipping address.
- **billing_full_address** - Full billing address.
- **delivery_provider** - Can be used to discern delivery providers E.g. DHL, PostNL.
- **delivery_method** - Store pickup, standard delivery, express delivery, international.
- **coupon_code** - Coupon applied at checkout.
- **account_type** - Selection of 'existing user' or 'guest checkout'.
- **payment_method** - Any kind of payment method the user selected to proceed. E.g. Card, PayPal, Alipay.
- **proof_of_payment** - Invoice or receipt.
- **marketing_opt_in** - If opted in to marketing campaigns to the email address.

+++
title = "Track Internal Promotion Events"
weight = 4
post = ""
+++

Internal promotion events are used for tracking views and interactions with internal promotion content on your e-commerce store. Such content can be:

- Hero banners/sliders on the homepage, category page etc.
- Sale specific banners e.g. seasonal sales, bundle discounts, free shipping.
- Category promotion on standard layout slots.

![Internal promotion banner](../images/internal_promotion.png?width=60pc)

---

### Internal promotion view event

In this section, we will showcase how to track promotion views.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackPromotionView`

To track a promotion view you can use the `trackPromotionView` method with the following attributes:

```ts
import { trackPromotionView } from '@snowplow/browser-plugin-snowplow-ecommerce';

trackPromotionView(promotion: Promotion);
```

- Where `promotion` is the description of the promotion currently being viewed.

**Example usage:**

```ts
import { trackPromotionView } from "@snowplow/browser-plugin-snowplow-ecommerce";

/* Carousel slide 1 viewed */
trackPromotionView({ 
    id: 'IP1234',
    name: 'promo_winter',
    type: 'carousel',
    position: 1,
    product_ids: ['P1234'],
});

/* On carousel slide 2 view */
trackPromotionView({ 
    id: 'IP1234',
    name: 'promo_winter',
    type: 'carousel',
    position: 2,
    product_ids: ['P1235'],
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackPromotionView`

To track a promotion view you can use the `trackPromotionView` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackPromotionView:{trackerName}", promotion: Promotion);
```

- Where `promotion` is the description of the promotion currently being viewed.

**Example usage:**

```ts
/* Carousel slide 1 viewed */
window.snowplow("trackPromotionView:{trackerName}", { 
    id: 'IP1234',
    name: 'promo_winter',
    type: 'carousel',
    position: 1,
    product_ids: ['P1234'],
});

/* On carousel slide 2 view */
window.snowplow("trackPromotionView:{trackerName}", { 
    id: 'IP1234',
    name: 'promo_winter',
    type: 'carousel',
    position: 2,
    product_ids: ['P1235'],
});

```

{{% /tab %}}

{{< /tabs >}}

### Internal promotion click event

In this section, we will showcase how to track a click/selection of an internal promotion.

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

#### `trackPromotionClick`

To track a click/selection of an internal promotion you can use the `trackPromotionClick` method with the following attributes:

```ts
import { trackPromotionClick } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackPromotionClick(promotion: Promotion);
```

- Where `promotion` is the description of the promotion clicked/selected.

**Example usage:**

```ts
import { trackPromotionClick } from "@snowplow/browser-plugin-snowplow-ecommerce";

trackPromotionClick({ 
    id: 'IP1234',
    name: 'promo_winter',
    type: 'carousel',
    position: 1,
    product_ids: ['P1234'],
});
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

#### `trackPromotionClick`

To track a click/selection of an internal promotion you can use the `trackPromotionClick` method with the following attributes:

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("trackPromotionClick:{trackerName}", promotion: Promotion);
```

- Where `promotion` is the description of the promotion clicked/selected.

**Example usage:**

```ts
window.snowplow("trackPromotionClick:{trackerName}", { 
    id: 'IP1234',
    name: 'promo_winter',
    type: 'carousel',
    position: 1,
    product_ids: ['P1234'],
});
```

{{% /tab %}}

{{< /tabs >}}

Where `promotion` can have the following attributes:

|    attribute     |   type   |                                                    description                                                     | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
|        id        | `string` |                                                 ID of the promotion.                                                 |    ✅    |
|     name     | `string` |                             Friendly name for the promotion.                              |    ✘    |
|      product_ids       | `string[]` |                                     Array of SKUs or product IDs showcased in the promotion.                                      |    ✘    |
|       position       | `number` |                                           position the promotion was presented in a list of promotions E.g. in a slider.                                            |    ✘     |
|     creative_id     | `string` | Identifier/Name/Url for the creative presented on the promotion. |    ✘     |
|    type    | `string` |                                      Type of the promotion delivery mechanism. E.g. popup, banner, intra-content.                                       |    ✘     |
|     slot     | `string` |  The website slot in which the promotional content was added to. E.g. Identifier for slot sidebar-1, intra-content-2.  |    ✘     |

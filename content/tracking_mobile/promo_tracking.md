+++
title = "Track Internal Promotion Events"
weight = 4
post = ""
+++

Internal promotion events are used for tracking views and interactions with internal promotion content on your e-commerce store. Such content can be:

- Hero banners/sliders on the home screen, category screen etc.
- Sale specific banners e.g. seasonal sales, bundle discounts, free shipping.
- Category promotion on standard layout slots.

![Internal promotion banner](../images/internal_promotion.png?width=60pc)

---

### Internal promotion view event

In this section, we will showcase how to track promotion views.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `PromotionViewEvent`

To track a promotion view you can use the `PromotionViewEvent` with the following attributes:

```swift
PromotionViewEvent(promotion: PromotionEntity)
```

- Where `promotion` is the description of the promotion currently being viewed.

**Example usage:**

```swift
/* Carousel slide 1 viewed */
let promotion1 = PromotionEntity(
    id: "IP1234",
    name: "promo_winter",
    type: "carousel",
    position: 1,
    productIds: ["P1234"]
)
tracker.track(PromotionViewEvent(promotion: promotion1))

/* On carousel slide 2 view */
let promotion2 = PromotionEntity(
    id: "IP1234",
    name: "promo_winter",
    type: "carousel",
    position: 2,
    productIds: ["P1235"]
)
tracker.track(PromotionViewEvent(promotion: promotion2))
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `PromotionViewEvent`

To track a promotion view you can use the `PromotionViewEvent` with the following attributes:

```kotlin
PromotionViewEvent(promotion: PromotionEntity)
```

- Where `promotion` is the description of the promotion currently being viewed.

**Example usage:**

```kotlin
/* Carousel slide 1 viewed */
val promotion1 = PromotionEntity(
    id = "IP1234",
    name = "promo_winter",
    type = "carousel",
    position = 1,
    productIds = listOf("P1234")
)
tracker.track(PromotionViewEvent(promotion1))

/* On carousel slide 2 view */
val promotion2 = PromotionEntity(
    id = "IP1234",
    name = "promo_winter",
    type = "carousel",
    position = 2,
    productIds = listOf("P1235")
)
tracker.track(PromotionViewEvent(promotion2))
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `PromotionViewEvent`

To track a promotion view you can use the `PromotionViewEvent` with the following attributes:

```java
PromotionViewEvent(promotion: PromotionEntity)
```

- Where `promotion` is the description of the promotion currently being viewed.

**Example usage:**

```java
/* Carousel slide 1 viewed */
PromotionEntity promotion1 = new PromotionEntity(
    "IP1234", // id
    "promo_winter", // name
    Arrays.asList("P1234"), // productIds
    1, // position
    null, // creativeId
    "carousel" // type
)
tracker.track(new PromotionViewEvent(promotion1))

/* On carousel slide 2 view */
PromotionEntity promotion2 = new PromotionEntity(
    "IP1234", // id
    "promo_winter", // name
    Arrays.asList("P1235"), // productIds
    2, // position
    null, // creativeId
    "carousel" // type
)
tracker.track(new PromotionViewEvent(promotion2))
```

{{% /tab %}}

{{< /tabs >}}

### Internal promotion click event

In this section, we will showcase how to track a click/selection of an internal promotion.

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

#### `PromotionClickEvent`

To track a click/selection of an internal promotion you can use the `PromotionClickEvent` with the following attributes:

```swift
PromotionClickEvent(promotion: PromotionEntity);
```

- Where `promotion` is the description of the promotion clicked/selected.

**Example usage:**

```swift
let promotion = PromotionEntity(
    id: "IP1234",
    name: "promo_winter",
    type: "carousel",
    position: 1,
    productIds: ["P1234"]
)

tracker.track(PromotionViewEvent(promotion: promotion))
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

#### `PromotionClickEvent`

To track a click/selection of an internal promotion you can use the `PromotionClickEvent` with the following attributes:

```kotlin
PromotionClickEvent(promotion: PromotionEntity);
```

- Where `promotion` is the description of the promotion clicked/selected.

**Example usage:**

```kotlin
val promotion = PromotionEntity(
    id = "IP1234",
    name = "promo_winter",
    type = "carousel",
    position = 1,
    productIds = listOf("P1234")
)

tracker.track(PromotionViewEvent(promotion))
```

{{% /tab %}}
{{% tab name="Java API" %}}

#### `PromotionClickEvent`

To track a click/selection of an internal promotion you can use the `PromotionClickEvent` with the following attributes:

```java
PromotionClickEvent(promotion: PromotionEntity);
```

- Where `promotion` is the description of the promotion clicked/selected.

**Example usage:**

```java
PromotionEntity promotion = new PromotionEntity(
    "IP1234", // id
    "promo_winter", // name
    Arrays.asList("P1234"), // productIds
    1, // position
    null, // creativeId
    "carousel" // type
)
tracker.track(new PromotionViewEvent(promotion))
```

{{% /tab %}}

{{< /tabs >}}

Where `PromotionEntity` can have the following attributes:

|    attribute     |   type   |                                                    description                                                     | required |
| :--------------: | :------: | :----------------------------------------------------------------------------------------------------------------: | :------: |
|        id        | `string` |                                                 ID of the promotion.                                                 |    ✅    |
|     name     | `string` |                             Friendly name for the promotion.                              |    ✘    |
|      productIds       | `string[]` |                                     Array of SKUs or product IDs showcased in the promotion.                                      |    ✘    |
|       position       | `number` |                                           position the promotion was presented in a list of promotions E.g. in a slider.                                            |    ✘     |
|     creativeId     | `string` | Identifier/Name/Url for the creative presented on the promotion. |    ✘     |
|    type    | `string` |                                      Type of the promotion delivery mechanism. E.g. popup, banner, intra-content.                                       |    ✘     |
|     slot     | `string` |  The website slot in which the promotional content was added to. E.g. Identifier for slot sidebar-1, intra-content-2.  |    ✘     |

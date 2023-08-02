+++
title = "Screen Type and User context entities"
weight = 9
post = ""
+++

When tracking actions on an e-commerce store, it can prove useful to be able to add extra and more generic contextual information such as the Screen/Page Type the visitor is currently on or User information for the user completing an action.

To do this, we provide you the `setEcommerceScreen` and `setEcommerceUser` methods, which allow you to set this information on events sent from the Snowplow tracker. These context entities will be attached to ALL events, not just e-commerce events.

#### `setEcommerceScreen`

For consistency with web tracking, this method adds a Page (rather than Screen) entity, defined by the schema `iglu:com.snowplowanalytics.snowplow.ecommerce/page/jsonschema/1-0-0`. The Ecommerce Screen/Page entity helps in grouping insights by screen/page type, e.g. Product description, Product list, Home screen.

To set a Screen/Page entity you can use the `EcommerceScreenEntity` with the following attributes:

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

```swift
EcommerceScreenEntity(type: String, language: String?, locale: String?)
```

- Where `type` is the type of page that was visited. E.g. homepage, product page, cart.
- Where `language` is the language the web page is based in.
- Where `locale` is the locale version of the site that is running.

**Example usage:**

```swift
let entity = EcommerceScreenEntity(type: "demo_app_screen")
tracker.ecommerce.setEcommerceScreen(entity)

// setting EcommerceScreen again will replace the original entity
let newEntity = EcommerceScreenEntity(type: "product_list", language: "EN-GB", locale: "UK")
tracker.ecommerce.setEcommerceScreen(newEntity)

// remove the saved properties and stop the Page entity being added
tracker.ecommerce.removeEcommerceScreen()
```
{{% /tab %}}
{{% tab name="Kotlin API" %}}

```kotlin
EcommerceScreenEntity(type: String, language: String?, locale: String?)
```

- Where `type` is the type of page that was visited. E.g. homepage, product page, cart.
- Where `language` is the language the web page is based in.
- Where `locale` is the locale version of the site that is running.

**Example usage:**

```kotlin
val entity = EcommerceScreenEntity(type = "demo_app_screen")
tracker.ecommerce.setEcommerceScreen(entity)

// setting EcommerceScreen again will replace the original entity
val newEntity = EcommerceScreenEntity(type = "product_list", language = "EN-GB", locale = "UK")
tracker.ecommerce.setEcommerceScreen(newEntity)

// remove the saved properties and stop the Page entity being added
tracker.ecommerce.removeEcommerceScreen()
```
{{% /tab %}}
{{% tab name="Java API" %}}

```java
EcommerceScreenEntity(type: String, language: String?, locale: String?)
```

- Where `type` is the type of page that was visited. E.g. homepage, product page, cart.
- Where `language` is the language the web page is based in.
- Where `locale` is the locale version of the site that is running.

**Example usage:**

```java
EcommerceScreenEntity entity = new EcommerceScreenEntity(
  "demo_app_screen" // type
)
tracker.getEcommerce().setEcommerceScreen(entity);

// setting EcommerceScreen again will replace the original entity
EcommerceScreenEntity newEntity = new EcommerceScreenEntity(
  "product_list", // type
  "EN-GB", // language
  "UK" // locale
)
tracker.getEcommerce().setEcommerceScreen(newEntity);

// remove the saved properties and stop the Page entity being added
tracker.getEcommerce().removeEcommerceScreen();
```
{{% /tab %}}
{{< /tabs >}}


#### `setEcommerceUser`

The Ecommerce User entity helps in modeling guest/non-guest account interactions. To set an Ecommerce User context you can use the `EcommerceUserEntity` with the following attributes:

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

```swift
EcommerceUserEntity(id: String, isGuest: Bool?, email: String?)
```

- Where `id` is the user identifier.
- Where `is_guest` is whether or not the user is a guest type.
- Where `email` is the user's email address.

**Example usage:**

```swift
let entity = EcommerceUserEntity(id: "userId12345", isGuest: true)
tracker.ecommerce.setEcommerceUser(entity)

// setting EcommerceUser again will replace the original entity
let newEntity = EcommerceUserEntity(id: "userId67890", isGuest: false, email: "email@email.com")
tracker.ecommerce.setEcommerceUser(newEntity)

// remove the saved properties and stop the User entity being added
tracker.ecommerce.removeEcommerceUser()
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}

```kotlin
EcommerceUserEntity(id: String, isGuest: Boolean?, email: String?)
```

- Where `id` is the user identifier.
- Where `is_guest` is whether or not the user is a guest type.
- Where `email` is the user's email address.

**Example usage:**

```kotlin
val entity = EcommerceUserEntity(id = "userId12345", isGuest = true)
tracker.ecommerce.setEcommerceUser(entity)

// setting EcommerceUser again will replace the original entity
val newEntity = EcommerceUserEntity(id = "userId67890", isGuest = false, email = "email@email.com")
tracker.ecommerce.setEcommerceUser(newEntity)

// remove the saved properties and stop the User entity being added
tracker.ecommerce.removeEcommerceUser()
```

{{% /tab %}}
{{% tab name="Java API" %}}

```java
EcommerceUserEntity(id: String, isGuest: Boolean?, email: String?)
```

- Where `id` is the user identifier.
- Where `is_guest` is whether or not the user is a guest type.
- Where `email` is the user's email address.

**Example usage:**

```java
EcommerceUserEntity entity = new EcommerceUserEntity(
  "userId12345", // id
  true // isGuest
)
tracker.getEcommerce().setEcommerceUser(entity);

// setting ScreenType again will replace the original entity
EcommerceUserEntity newEntity = new EcommerceUserEntity(
  "userId67890", // id
  false, // isGuest
  "email@email.com" // email
)
tracker.getEcommerce().setEcommerceUser(newEntity);

// remove the saved properties and stop the Page entity being added
tracker.getEcommerce().removeEcommerceUser();
```

{{% /tab %}}

{{< /tabs >}}


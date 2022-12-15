+++
title = "Page Type and User Context"
weight = 7
post = ""
+++

When tracking actions on an ecommerce store, it can prove useful to be able to add extra and more generic context information such as the Page Type the visitor is currently on or User information for the user completing an action.

To do this, we provide you the `setPageType` and `setEcommerceUser` methods, which allow you to set this information on events sent from the Snowplow tracker.

#### `setPageType`

To set a Page Type context you can use the `setPageType` method with the following attributes:

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

```ts
import { setPageType } from "@snowplow/browser-plugin-snowplow-ecommerce";

setPageType({ type, language, locale });
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}


```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("setPageType:{trackerName}", { type, language, locale });
```

{{% /tab %}}

{{< /tabs >}}

- Where `type` is the type of page that was visited. E.g. homepage, product page, cart.
- Where `language` is the language the web page is based in.
- Where `locale` is the locale version of the site that is running.

#### `setEcommerceUser`

To set an Ecommerce User context you can use the `setEcommerceUser` method with the following attributes:

{{< tabs groupId="select_js" >}}
{{% tab name="Browser API" %}}

```ts
import { setEcommerceUser } from "@snowplow/browser-plugin-snowplow-ecommerce";

setEcommerceUser({ id, is_guest, email });
```

{{% /tab %}}
{{% tab name="JavaScript API" %}}

```ts
/* {trackerName} is a placeholder for the initialized tracker on your page.  */

window.snowplow("setEcommerceUser:{trackerName}", { id, is_guest, email });
```

{{% /tab %}}

{{< /tabs >}}

- Where `id` is the user identifier.
- Where `is_guest` is whether or not the user is a guest type.
- Where `email` is the user's email address.

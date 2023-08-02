+++
title = "Testing"
weight = 10
post = ""
+++

For manual and automated development testing on mobile, the best option is [Snowplow Micro](https://docs.snowplow.io/docs/testing-debugging/snowplow-micro/what-is-micro/).

#### **Step 1:** Installation

Use Docker to start up a Micro pipeline. Follow these [simple instructions](https://docs.snowplow.io/docs/testing-debugging/snowplow-micro/basic-usage/) if you are using only out-of-the-box events, or [these instructions](https://docs.snowplow.io/docs/testing-debugging/snowplow-micro/adding-schemas/) if you have added custom events or entities with your own schemas.

Once your Micro container is running, configure your tracker to send events to it by providing the Micro URI at tracker initialization. The default URI is `http://0.0.0.0:9090`. For example:

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift API" %}}

```swift
let tracker = Snowplow.createTracker(
  namespace: "appTracker", 
  endpoint: "http://0.0.0.0:9090" // Micro URL
)
```

{{% /tab %}}
{{% tab name="Kotlin API" %}}
Replace `{{ip address goes here}}` with your network IP address. 

```kotlin
val tracker = Snowplow.createTracker(
    applicationContext, // Android context (LocalContext.current in Compose apps)
    "appTracker", // namespace
    "http://{{ip address goes here}}:9090" // Micro URL
)
```

{{% /tab %}}
{{% tab name="Java API" %}}

Replace `{{ip address goes here}}` with your network IP address. 

```java
TrackerController tracker = Snowplow.createTracker(
      getApplicationContext(), // Android context
      "appTracker", // namespace
      "http://{{ip address goes here}}:9090" // Micro URL
);
```

{{% /tab %}}
{{< /tabs >}}

Then interact with your app to track events.

#### **Step 2:** Check your data

Events are stored in Snowplow Micro in JSON format. Micro has three API endpoints. Access `localhost:9090/micro/good` to get all the valid events. Read more [here](https://docs.snowplow.io/docs/pipeline-components-and-applications/snowplow-micro/api/).




+++
title = "Set-up your tracking"
weight = 1
+++

Setting up Snowplow e-commerce tracking starts with installing and setting up the tracker as for any Snowplow implementation. Read more [here](https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/installation-and-set-up/).

{{< tabs groupId="select_mobile" >}}
{{% tab name="Swift for iOS" %}}

#### **Step 1:** Install tracker dependency

To install Snowplow Tracker with SPM:

1. In Xcode, select File > Swift Packages > Add Package Dependency.
2. Add the url where to download the library: https://github.com/snowplow/snowplow-ios-tracker

---

#### **Step 2:** Create the tracker

In your app, create the tracker. 

1. In your application delegate `AppDelegate.swift` add `import SnowplowTracker`.

2. In the `application(_:didFinishLaunchingWithOptions:)` method, set up the SDK as follows:
   
   ```swift
   let tracker = Snowplow.createTracker(
    namespace: "appTracker",
    endpoint: "https://snowplow-collector-url.com"
  )
   ```

   The URL path for your collector endpoint should include the protocol, "http" or "https". If not included in the URL, "https" connection will be used by default. The tracker namespace will be attached to all events, and is especially useful when multiple trackers are instrumented in the same app (with different configuration or endpoint).

3. It creates a tracker instance which can be used to track events like this:
   
  ```swift
  let event = PromotionViewEvent(promotion: PromotionEntity(id: "IP1234"))

  tracker?.track(event)
   ```
   
   If you prefer to access the tracker when the reference is not directly accessible, you can use the `defaultTracker` :
   
   ```swift
   Snowplow.defaultTracker()?.track(event)
   ```

{{% /tab %}}
{{% tab name="Kotlin for Android" %}}

#### **Step 1:** Install tracker dependency

The Android Tracker SDK can be installed using Gradle.

**Gradle**

Add into your `build.gradle` file:

```gradle
dependencies {
  ...
  // Snowplow Android Tracker
  implementation 'com.snowplowanalytics:snowplow-android-tracker:5.+'
  // In case 'lifecycleAutotracking' is enabled
  implementation 'androidx.lifecycle-extensions:2.2.+'
  ...
}
```

---

#### **Step 2:** Create the tracker

In your app, create the tracker. 

1. In your `Application` subclass, set up the SDK as follows:
   
   ```kotlin
    val tracker = Snowplow.createTracker(
      applicationContext, // Android context (LocalContext.current in Compose apps)
      "appTracker", // namespace
      "https://snowplow-collector-url.com" // Event collector URL
    )
   ```

   The URL path for your collector endpoint should include the protocol, "http" or "https". If not included in the URL, "https" connection will be used by default. The tracker namespace will be attached to all events, and is especially useful when multiple trackers are instrumented in the same app (with different configuration or endpoint).

2. It creates a tracker instance which can be used to track events like this:
   
  ```kotlin
  val event = PromotionViewEvent(PromotionEntity(id = "IP1234"))

  tracker.track(event)
   ```
   
   If you prefer to access the tracker when the reference is not directly accessible, you can use the `defaultTracker` :
   
   ```kotlin
   Snowplow.defaultTracker?.track(event)
   ```

{{% /tab %}}
{{% tab name="Java for Android" %}}

#### **Step 1:** Install tracker dependency

The Android Tracker SDK can be installed using Gradle.

**Gradle**

Add into your `build.gradle` file:

```gradle
dependencies {
  ...
  // Snowplow Android Tracker
  implementation 'com.snowplowanalytics:snowplow-android-tracker:5.+'
  // In case 'lifecycleAutotracking' is enabled
  implementation 'androidx.lifecycle-extensions:2.2.+'
  ...
}
```

---

#### **Step 2:** Create the tracker

In your app, create the tracker. 

1. In your `Application` subclass, set up the SDK as follows:
   
   ```java
    TrackerController tracker = Snowplow.createTracker(
      getApplicationContext(), // Android context
      "appTracker", // namespace
      "https://snowplow-collector-url.com" // Event collector URL
    );
   ```

   The URL path for your collector endpoint should include the protocol, "http" or "https". If not included in the URL, "https" connection will be used by default. The tracker namespace will be attached to all events, and is especially useful when multiple trackers are instrumented in the same app (with different configuration or endpoint).

2. It creates a tracker instance which can be used to track events like this:
   
  ```java
  Event event = new PromotionViewEvent(new PromotionEntity("IP1234"));

  tracker.track(event);
   ```
   
   If you prefer to access the tracker when the reference is not directly accessible, you can use the `defaultTracker` :
   
   ```java
   Snowplow.getDefaultTracker().track(event);
   ```

{{% /tab %}}
{{< /tabs >}}

# Add project specific ProGuard rules here.

# Stripe Push Provisioning
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# Stripe general
-keep class com.stripe.** { *; }
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.stripe.**
-dontwarn com.reactnativestripesdk.**

# React Native Stripe SDK
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }
-dontwarn com.reactnativestripesdk.pushprovisioning.**
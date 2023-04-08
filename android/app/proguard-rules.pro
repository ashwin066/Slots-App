-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-keepattributes JavascriptInterface
-keepattributes *Annotation*

-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}

-optimizations !method/inlining/*

-keep class androidx.lifecycle.DefaultLifecycleObserver

-keepclasseswithmembers class * {
  public void onPayment*(...);
}
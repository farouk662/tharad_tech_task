# Keep OkHttp
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }

# For ucrop
-dontwarn com.yalantis.ucrop.**
-keep class com.yalantis.ucrop.** { *; }

# Prevent removing Response classes
-keep class okhttp3.internal.** { *; }

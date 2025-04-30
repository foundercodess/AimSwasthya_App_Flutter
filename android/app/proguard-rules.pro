# Keep Razorpay classes
-keep class com.razorpay.** { *; }
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
-keep class proguard.annotation.KeepPublicClassMembers { *; }
-keep class proguard.annotation.KeepName { *; }

# Don't warn about Razorpay classes
-dontwarn com.razorpay.**

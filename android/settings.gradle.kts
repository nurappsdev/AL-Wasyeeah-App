// Fix AndroidLocationsException when both ANDROID_USER_HOME and ANDROID_PREFS_ROOT are set in environment
try {
    val processEnvironmentClass = Class.forName("java.lang.ProcessEnvironment")
    arrayOf("theEnvironment", "theCaseInsensitiveEnvironment").forEach { fieldName ->
        try {
            val field = processEnvironmentClass.getDeclaredField(fieldName)
            field.isAccessible = true
            @Suppress("UNCHECKED_CAST")
            val map = field.get(null) as MutableMap<String, String>
            map.remove("ANDROID_PREFS_ROOT")
            map.remove("ANDROID_SDK_HOME")
        } catch (e: Throwable) {
            // Ignore
        }
    }
} catch (e: Throwable) {
    // Ignore
}

pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.4.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
}

include(":app")

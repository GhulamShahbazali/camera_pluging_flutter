plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.jiangdg.demo"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    buildFeatures {
        viewBinding = true
        dataBinding = true
    }

    defaultConfig {
        applicationId = "com.jiangdg.ausbc"
        minSdk = 24
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        multiDexEnabled = true
        
        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    val androidXVersion = rootProject.extra.get("androidXVersion") as String
    val kotlinCoreVersion = rootProject.extra.get("kotlinCoreVersion") as String
    val materialVersion = rootProject.extra.get("materialVersion") as String
    val constraintlayoutVersion = rootProject.extra.get("constraintlayoutVersion") as String
    
    implementation("androidx.appcompat:appcompat:$androidXVersion")
    implementation("androidx.core:core-ktx:$kotlinCoreVersion")
    implementation("com.google.android.material:material:$materialVersion")
    implementation("androidx.constraintlayout:constraintlayout:$constraintlayoutVersion")
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.2.0")
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:2.2.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.2.0")
    implementation("com.github.CymChad:BaseRecyclerViewAdapterHelper:2.9.50")
    implementation("com.afollestad.material-dialogs:core:3.2.1")
    implementation("com.geyifeng.immersionbar:immersionbar:3.2.2")
    implementation("com.github.zjupure:webpdecoder:2.7.4.16.0")
    implementation("com.github.bumptech.glide:glide:4.10.0")
    implementation("com.github.bumptech.glide:okhttp3-integration:4.10.0")
    implementation("com.tencent:mmkv:1.2.12")
    implementation("com.tencent.bugly:crashreport:4.1.9.3")
    implementation("com.tencent.bugly:nativecrashreport:3.9.0")
    implementation(project(":libausbc"))
}

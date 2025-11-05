// ******************************************************************************
// PLUGINS BLOCK (ត្រូវតែមកមុនគេ)
// ******************************************************************************
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// ******************************************************************************
// ១. LOAD SIGNING PROPERTIES (អានពី android/key.properties)
// ******************************************************************************
// Import classes for reading the key.properties file
import java.io.FileInputStream
import java.util.Properties

val signingConfigProperties = Properties()
// ត្រូវប្រាកដថា Path នេះត្រឹមត្រូវទៅកាន់ឯកសារ key.properties របស់អ្នក
val localSigningPropsFile = rootProject.file("key.properties") 

if (localSigningPropsFile.exists()) {
    // ប្រើ use{} ដើម្បីធានាថា FileInputStream ត្រូវបានបិទ
    FileInputStream(localSigningPropsFile).use { signingConfigProperties.load(it) }
}

android {
    namespace = "com.ng.bunna"
    compileSdk = flutter.compileSdkVersion
    
    // កំណត់ NDK Version ទៅតាមតម្រូវការរបស់ Plugins (អ្នកបានបញ្ជាក់ 27.0.12077973)
    ndkVersion = "27.0.12077973" 

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    // ******************************************************************************
    // ២. DEFINE SIGNING CONFIGURATION (ប្រើព័ត៌មានពី key.properties)
    // ******************************************************************************
    signingConfigs {
        create("release") {
            // យើងប្រើ Full Path ពី key.properties ដោយផ្ទាល់ ដោយមិនបន្ថែម '../' ទេ
            storeFile = file(signingConfigProperties.getProperty("storeFile"))
            storePassword = signingConfigProperties.getProperty("storePassword")
            keyAlias = signingConfigProperties.getProperty("keyAlias")
            keyPassword = signingConfigProperties.getProperty("keyPassword")
        }
    }

    defaultConfig {
        applicationId = "com.ng.bunna"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode as Int
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ៣. APPLY SIGNING CONFIG
            // បើកការចុះហត្ថលេខាសម្រាប់ Release Build
            signingConfig = signingConfigs.getByName("release")
            
            // ការកំណត់រចនាសម្ព័ន្ធ Release ផ្សេងទៀត
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

// ******************************************************************************
// DEPENDENCIES (ជាទូទៅ Block នេះត្រូវបានដាក់នៅខាងក្រៅ android {})
// ******************************************************************************
dependencies {
    // មិនចាំបាច់មាន Dependency បើមិនមាន Native Code ទេ
}

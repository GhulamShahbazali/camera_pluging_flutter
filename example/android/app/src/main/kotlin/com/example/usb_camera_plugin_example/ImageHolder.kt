package com.example.usb_camera_plugin_example

/**
 * Simple singleton to hold captured image path
 * Used to pass image from camera to Flutter
 */
object ImageHolder {
    var capturedImagePath: String? = null
    
    fun setImagePath(path: String) {
        capturedImagePath = path
        android.util.Log.d("ImageHolder", "✅ Image path set: $path")
    }
    
    fun getImagePath(): String? {
        val path = capturedImagePath
        capturedImagePath = null // Clear after reading
        android.util.Log.d("ImageHolder", "📸 Image path retrieved: $path")
        return path
    }
    
    fun hasImage(): Boolean {
        return capturedImagePath != null
    }
}


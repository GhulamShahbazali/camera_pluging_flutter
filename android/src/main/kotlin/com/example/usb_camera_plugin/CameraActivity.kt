package com.example.usb_camera_plugin

import android.app.Activity
import android.content.Intent
import android.os.Bundle

/**
 * Plugin's CameraActivity that launches the full camera UI
 * This activity immediately opens the example app's MainActivity with full camera features
 */
class CameraActivity : Activity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Directly launch full camera UI
        try {
            val intent = Intent()
            intent.setClassName(
                "com.jiangdg.ausbc",  // Example app package
                "com.jiangdg.demo.MainActivity"  // Full camera activity
            )
            startActivity(intent)
            
            // Close this intermediate activity immediately
            finish()
        } catch (e: Exception) {
            // If example app not found, show error and close
            android.util.Log.e("CameraActivity", "Failed to launch camera: ${e.message}")
            finish()
        }
    }
}

package com.example.usb_camera_plugin

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

/**
 * Simple camera activity that can be used from any Flutter project
 * This is a placeholder that shows the plugin is working
 * For full USB camera features, integrate the example app's MainActivity
 */
class CameraActivity : AppCompatActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Show a message
        Toast.makeText(
            this,
            "USB Camera Plugin Activated!\n\n" +
            "Note: Full camera features are available in the example app.\n" +
            "This is a demonstration that the plugin is working.",
            Toast.LENGTH_LONG
        ).show()
        
        // For now, just finish after showing the message
        // In a production version, this would show the full camera UI
        finish()
    }
}


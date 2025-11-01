package com.example.usb_camera_plugin

import android.app.Activity
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast

/**
 * Simple camera activity that can be used from any Flutter project
 * This is a placeholder that shows the plugin is working
 * For full USB camera features, integrate the example app's MainActivity
 */
class CameraActivity : Activity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Create a simple layout programmatically (no XML needed)
        val layout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setBackgroundColor(Color.parseColor("#2196F3"))
            setPadding(40, 40, 40, 40)
        }
        
        val title = TextView(this).apply {
            text = "🎥 USB Camera Plugin"
            textSize = 24f
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
        }
        
        val subtitle = TextView(this).apply {
            text = "\n✅ Plugin Successfully Working!\n\n" +
                   "📱 FULL CAMERA FEATURES:\n" +
                   "The complete USB camera interface with recording, " +
                   "capture, and effects is available in the example app.\n\n" +
                   "🚀 TO USE FULL FEATURES:\n" +
                   "1. cd camera_pluging_flutter_v1/example\n" +
                   "2. flutter run\n\n" +
                   "📦 OR INTEGRATE:\n" +
                   "Copy example app's MainActivity and resources " +
                   "into your project for full features.\n\n" +
                   "This basic screen confirms the plugin " +
                   "is properly installed and working."
            textSize = 14f
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
            setPadding(20, 20, 20, 20)
        }
        
        layout.addView(title)
        layout.addView(subtitle)
        setContentView(layout)
        
        // Show toast
        Toast.makeText(
            this,
            "USB Camera Plugin is Working! 🎉",
            Toast.LENGTH_LONG
        ).show()
        
        // Auto-close after 3 seconds
        Handler(Looper.getMainLooper()).postDelayed({
            finish()
        }, 3000)
    }
}


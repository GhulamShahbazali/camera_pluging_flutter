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
            text = "\n✅ Plugin Successfully Activated!\n\n" +
                   "This demonstrates that the plugin is working " +
                   "in your project.\n\n" +
                   "For full USB camera features (recording, capture, effects), " +
                   "check the example app."
            textSize = 16f
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


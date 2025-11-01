package com.example.usb_camera_plugin_example

import android.app.Activity
import android.os.Bundle
import android.widget.TextView
import android.view.Gravity

class CameraActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val tv = TextView(this)
        tv.text = "🎥 Example CameraActivity Opened!"
        tv.gravity = Gravity.CENTER
        tv.textSize = 22f
        setContentView(tv)
    }
}

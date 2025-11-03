package com.example.usb_camera_plugin_example

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "usb_camera_plugin"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            android.util.Log.d("MainActivity", "📞 Method called: ${call.method}")
            
            when (call.method) {
                "openCamera" -> {
                    try {
                        val intent = Intent(this, com.jiangdg.demo.MainActivity::class.java)
                        startActivity(intent)
                        result.success("Camera opened")
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }
                }
                "getLastCapturedImage" -> {
                    // ✅ Get from ImageHolder
                    val imagePath = ImageHolder.getImagePath()
                    android.util.Log.d("MainActivity", "📸 Returning image: $imagePath")
                    result.success(imagePath)
                }
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }
                else -> result.notImplemented()
            }
        }
    }
}

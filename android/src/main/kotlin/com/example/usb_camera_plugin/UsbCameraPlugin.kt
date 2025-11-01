package com.example.usb_camera_plugin

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class UsbCameraPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "usb_camera_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "openCamera" -> {
        activity?.let {
          try {
            val className = "com.jiangdg.demo.MainActivity"
            val clazz = Class.forName(className)
            val intent = Intent(it, clazz)
            it.startActivity(intent)
            result.success("Camera opened")
          } catch (e: ClassNotFoundException) {
            result.error(
              "ERROR", 
              "Camera activity not found. This plugin requires the example app to run properly. " +
              "The camera functionality is only available in the example project. " +
              "Please navigate to the example folder and run: flutter run",
              mapOf(
                "suggestion" to "Use example app",
                "path" to "example/",
                "missing_class" to className
              )
            )
          } catch (e: Exception) {
            result.error("ERROR", "Failed to open camera: ${e.message}", null)
          }
        } ?: result.error("ERROR", "Activity not available", null)
      }
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}

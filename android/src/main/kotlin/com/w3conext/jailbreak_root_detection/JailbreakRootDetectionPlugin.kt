package com.w3conext.jailbreak_root_detection

import android.app.Activity
import com.anish.trust_fall.emulator.EmulatorCheck
import com.anish.trust_fall.externalstorage.ExternalStorageCheck
import com.anish.trust_fall.rooted.RootedCheck

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** JailbreakRootDetectionPlugin */
class JailbreakRootDetectionPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jailbreak_root_detection")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when(call.method) {
            "test" -> { result.success("hello") }
            "isJailBroken" -> result.success(RootedCheck.isJailBroken(activity))
            "isRealDevice" -> result.success(!EmulatorCheck.isEmulator)
            "isOnExternalStorage" -> result.success(ExternalStorageCheck.isOnExternalStorage(activity))
            else -> result.notImplemented()
        }
    }
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}

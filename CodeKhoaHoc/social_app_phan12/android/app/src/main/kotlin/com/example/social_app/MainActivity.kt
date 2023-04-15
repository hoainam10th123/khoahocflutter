package com.example.social_app

import android.Manifest
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.social_app.data.MessageHub
import com.example.social_app.model.Constanst
import com.example.social_app.service.Restarter
import com.example.social_app.service.SignalRService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "agu.chat/signalR"

    private val PERMISSION_REQ_ID = 22
    private val REQUESTED_PERMISSIONS = arrayOf(
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA
    )

    private fun checkSelfPermission(): Boolean {
        return !(ContextCompat.checkSelfPermission(
            this,
            REQUESTED_PERMISSIONS[0]
        ) != PackageManager.PERMISSION_GRANTED ||
                ContextCompat.checkSelfPermission(
                    this,
                    REQUESTED_PERMISSIONS[1]
                ) != PackageManager.PERMISSION_GRANTED)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        SignalRService.isInBackground = false
        super.onCreate(savedInstanceState)
        if (!checkSelfPermission()) {
            ActivityCompat.requestPermissions(this, REQUESTED_PERMISSIONS, PERMISSION_REQ_ID);
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "startSignalrService") {
                //val token: String = call.arguments as String;
                val token = call.argument<String>("token")
                Constanst.currentUsername = call.argument<String>("currentUsername").toString()
                startSignalrService(token.toString());
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startSignalrService(token: String) {
        MessageHub.token = token
        SignalRService.token = token
        //start service run in background whether app is killed
        Intent(this, SignalRService::class.java).also { intent ->
            if (!isMyServiceRunning(SignalRService::class.java)) {
                startService(intent)
            }
        }
    }

    private fun isMyServiceRunning(serviceClass: Class<*>): Boolean {
        val manager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        for (service in manager.getRunningServices(Int.MAX_VALUE)) {
            if (serviceClass.name == service.service.className) {
                Log.i("Service status", "Running")
                return true
            }
        }
        Log.i("Service status", "Not running")
        return false
    }

    override fun onDestroy() {
        //stopService(mServiceIntent)
        SignalRService.isInBackground = true
        val broadcastIntent = Intent()
        broadcastIntent.action = "restartservice"
        broadcastIntent.setClass(this, Restarter::class.java)
        this.sendBroadcast(broadcastIntent)
        super.onDestroy()
    }

    override fun onStart() {
        Log.d("MyApp", "App in foreground")
        SignalRService.isInBackground = false
        super.onStart()
    }

    override fun onStop() {
        Log.d("MyApp", "App in background")
        SignalRService.isInBackground = true
        super.onStop()
    }
}

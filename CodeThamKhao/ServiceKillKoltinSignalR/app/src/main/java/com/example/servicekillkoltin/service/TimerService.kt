package com.example.servicekillkoltin.service

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.*
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.example.servicekillkoltin.Constanst
import com.example.servicekillkoltin.models.Member
import com.google.gson.reflect.TypeToken
import com.microsoft.signalr.*
import io.reactivex.rxjava3.core.Single
import java.util.*


class TimerService : Service(){
    private var hubConnection: HubConnection? = null

    override fun onCreate() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.O) startMyOwnForeground() else startForeground(
            1,
            Notification()
        )
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun startMyOwnForeground() {
        val NOTIFICATION_CHANNEL_ID = "example.permanence"
        val channelName = "Background Service"
        val chan = NotificationChannel(
            NOTIFICATION_CHANNEL_ID,
            channelName,
            NotificationManager.IMPORTANCE_NONE
        )
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
        val manager = (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager)
        manager.createNotificationChannel(chan)
        val notificationBuilder = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
        val notification: Notification = notificationBuilder.setOngoing(true)
            .setContentTitle("App is running in background")
            .setPriority(NotificationManager.IMPORTANCE_MIN)
            .setCategory(Notification.CATEGORY_SERVICE)
            .build()
        startForeground(2, notification)
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        if(hubConnection == null){
            //Toast.makeText(this, "service starting", Toast.LENGTH_SHORT).show()
            Log.i("SignalR service", "service starting, createHubConnection")
            createHubConnection();
        }
        // If we get killed, after returning from here, restart
        return START_STICKY
    }

    override fun onBind(intent: Intent): IBinder? {
        // We don't provide binding, so return null
        return null
    }

    override fun onDestroy() {
        Toast.makeText(this, "service done", Toast.LENGTH_SHORT).show()
        stopHubConnection()
        val broadcastIntent = Intent()
        broadcastIntent.action = "restartservice"
        broadcastIntent.setClass(this, Restarter::class.java)
        this.sendBroadcast(broadcastIntent)
    }

    fun createHubConnection() {
        hubConnection = HubConnectionBuilder.create("${Constanst.HUB_URL}presence")
            .withAccessTokenProvider(Single.defer { Single.just("${Constanst.TOKEN}") })
            .build()

        hubConnection?.on("UserIsOnline",
            Action1 { member ->
                Log.i("UserIsOnline", "${member.displayName} online")
            },
            Member::class.java
        )

        hubConnection?.on("UserIsOffline",
            Action1 { username: String ->
                Log.i("UserIsOffline", "$username offline")
            },
            String::class.java
        )

        hubConnection?.on("NewMessageReceived",
            Action2 { member, contentMesage ->
                Log.i("NewMessageReceived", "Message Received from: ${member.displayName}")
            },
            Member::class.java, String::class.java
        )

        hubConnection?.on(
            "GetOnlineUsers",
            Action1 { usersOnline ->

                val json = Constanst.arrayToString(usersOnline);
                val type = object : TypeToken<List<Member>>() {}.type
                val result: List<Member> = Constanst.parseArray(json.toString(),type)
                for (member in result){
                    Log.i("GetOnlineUsers", "Onlines user: ${member.displayName}")
                }
                val array = arrayListOf<Member>()
                array.addAll(result)
            },
            List::class.java
        )

        hubConnection?.on(
            "DisplayInformationCaller",
            Action2 { member, channel ->
                Log.i("DisplayInformationCaller", "Caller: ${member.displayName} channel: $channel")
            },
            Member::class.java, String::class.java
        )

        hubConnection!!.start().blockingAwait()
        Log.i("SignalR service", "service starting: "+hubConnection!!.connectionState.toString() )
    }

    fun stopHubConnection(){
        if(hubConnection?.connectionState == HubConnectionState.CONNECTED){
            hubConnection!!.stop()
            hubConnection = null
        }
    }

}
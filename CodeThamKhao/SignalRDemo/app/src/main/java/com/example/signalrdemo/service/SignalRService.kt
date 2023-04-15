package com.example.signalrdemo.service

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
import com.example.signalrdemo.Constanst
import com.example.signalrdemo.Contact
import com.example.signalrdemo.Member
import com.example.signalrdemo.data.Chat
import com.example.signalrdemo.data.NotificationHelper
import com.google.gson.reflect.TypeToken
import com.microsoft.signalr.Action1
import com.microsoft.signalr.Action2
import com.microsoft.signalr.HubConnection
import com.microsoft.signalr.HubConnectionBuilder
import com.microsoft.signalr.HubConnectionState
import io.reactivex.rxjava3.core.Single

class SignalRService : Service(){
    private var hubConnection: HubConnection? = null
    private var notificationHelper: NotificationHelper? = null

    override fun onCreate() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.O) startMyOwnForeground() else startForeground(
            1,
            Notification()
        )
        notificationHelper = NotificationHelper(applicationContext)
        notificationHelper!!.setUpNotificationChannels()
        super.onCreate()
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
        stopHubConnection();
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
                Constanst.contacts.add(member)
            },
            Member::class.java
        )

        hubConnection?.on("UserIsOffline",
            Action1 { username: String ->
                Log.i("UserIsOffline", "$username offline")
                val memTemp = Constanst.contacts.find { member -> member.userName == username }
                if(memTemp != null){
                    Constanst.contacts.remove(memTemp)
                }
                    },
            String::class.java
        )

        hubConnection?.on("NewMessageReceived",
            Action2 { member, content ->
                Log.i("NewMessageReceived", "Message Received from: ${member.displayName}")
                /*val bubleIntent = Intent(this, BubbleActivity::class.java)
                bubleIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                val json = Constanst.objectToString(member)
                bubleIntent.putExtra("member", json)
                startActivity(bubleIntent)*/

                notificationHelper!!.showNotification(content, Constanst.contacts.toList(), member, true)
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
                Constanst.contacts = array
            },
            List::class.java
        )
        hubConnection!!.start().blockingAwait()
    }

    fun stopHubConnection(){
        if(hubConnection?.connectionState == HubConnectionState.CONNECTED){
            hubConnection!!.stop()
            hubConnection = null
        }
    }
}
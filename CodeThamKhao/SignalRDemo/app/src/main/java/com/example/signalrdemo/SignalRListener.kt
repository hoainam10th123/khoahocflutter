package com.example.signalrdemo

import com.google.gson.reflect.TypeToken
import com.microsoft.signalr.Action1
import com.microsoft.signalr.HubConnection
import com.microsoft.signalr.HubConnectionBuilder
import com.microsoft.signalr.HubConnectionState
import io.reactivex.rxjava3.core.Single

//Singleton, khong dung den
class SignalRListener private constructor(){
    private lateinit var hubConnection: HubConnection

    init {
        createHubConnection()
    }

    fun createHubConnection(){
        hubConnection = HubConnectionBuilder.create("http://10.0.2.2:5291/hubs/presence")
            .withAccessTokenProvider(Single.defer { Single.just("${Constanst.TOKEN}") })
            .build()

        hubConnection.on("UserIsOnline",
            Action1 { member ->
                println(member.displayName)
            },
            Member::class.java
        )

        hubConnection.on("UserIsOffline",
            Action1 { username: String -> println(username+" offline") },
            String::class.java
        )

        hubConnection.on("NewMessageReceived",
            Action1 { member -> println("NewMessageReceived from: "+member.displayName) },
            Member::class.java
        )

        hubConnection.on(
            "GetOnlineUsers",
            Action1 { usersOnline ->
                val json = Constanst.arrayToString(usersOnline);
                val type = object : TypeToken<List<Member>>() {}.type
                val result: List<Member> = Constanst.parseArray(json.toString(),type)
                for (member in result){
                    println("Onlines user: "+member.displayName)
                }
            },
            List::class.java
        )
        hubConnection.start().blockingAwait()
    }

    private object Holder { val INSTANCE = SignalRListener() }

    companion object {
        @JvmStatic
        fun getInstance(): SignalRListener{
            return Holder.INSTANCE
        }
    }

    fun stopHubConnection(){
        if(hubConnection.connectionState == HubConnectionState.CONNECTED){
            hubConnection.stop().blockingAwait()
        }
    }

    fun getConnectionState(): String{
        return hubConnection.connectionState.toString()
    }

    fun getConnectionId(): String{
        return hubConnection.connectionId
    }
}
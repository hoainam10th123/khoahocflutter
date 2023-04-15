package com.example.signalrdemo.data

import android.content.Context
import android.net.Uri
import androidx.annotation.MainThread
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.signalrdemo.CreateMessage
import com.example.signalrdemo.Member
import com.example.signalrdemo.Message
import com.example.signalrdemo.MessageHub
import java.util.concurrent.Executor
import java.util.concurrent.Executors

interface IChatRepository {
    fun activateChat(id: String)
    fun deactivateChat(id: String)
    fun canBubble(id: Member): Boolean
    fun updateNotification(id: Member)
    fun showAsBubble(member: Member)
    fun findMessages(username: String): LiveData<List<Message>>
    fun sendMessage(recipientUsername: String, content: String)
    fun stopHub()
    fun createHub(username: String)
}

class DefaultChatRepository internal constructor(
    private val notificationHelper: NotificationHelper,
    private val executor: Executor
) : IChatRepository {

    companion object {
        private var instance: DefaultChatRepository? = null

        fun getInstance(context: Context): DefaultChatRepository {
            return instance ?: synchronized(this) {
                instance ?: DefaultChatRepository(
                    NotificationHelper(context),
                    Executors.newFixedThreadPool(4)
                ).also {
                    instance = it
                }
            }
        }
    }


    private var currentChat: String? = null

    init {
        notificationHelper.setUpNotificationChannels()
    }

    override fun createHub(username: String){
        //chatHub.createHubConnection(username)
    }

    //@MainThread
    override fun findMessages(username: String): LiveData<List<Message>> {
        return object : LiveData<List<Message>>() {

            private val listener = { messages: List<Message> ->
                postValue(messages)
            }

            override fun onActive() {
                //value = chatHub.messages
                //chatHub.addListener(listener)
            }

            override fun onInactive() {
                //chatHub.removeListener(listener)
            }
        }
    }

    override fun sendMessage(recipientUsername: String, content: String) {
        //chatHub.sendMessage(CreateMessage(recipientUsername, content))
    }

    override fun updateNotification(id: Member) {
        //val chat = chats.getValue(id)
        //notificationHelper.showNotification(chat, false, true)
    }

    override fun activateChat(id: String) {
        currentChat = id
        notificationHelper.updateNotification(id, true)
    }

    override fun deactivateChat(id: String) {
        if (currentChat == id) {
            currentChat = null
        }
    }

    override fun showAsBubble(member: Member) {
        executor.execute {
            //notificationHelper.showNotification(member, true)
        }
    }

    override fun canBubble(id: Member): Boolean {
        //val chat = chats.getValue(id)
        //return notificationHelper.canBubble(chat.contact)
        return true
    }

    override fun stopHub(){
        //chatHub.stopHubConnection()
    }
}
package com.example.social_app.model

import com.google.gson.annotations.SerializedName

data class Settings(val uid: String, val channelName: String)

class ResToken{
    @SerializedName("token")
    val token: String = ""
}
package com.example.social_app.api

import com.example.social_app.model.ResToken
import com.example.social_app.model.Settings
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface AgoraService {
    @POST("agora/get-rtc-token")
    fun getRtcToken(@Body setting: Settings): Call<ResToken>
}
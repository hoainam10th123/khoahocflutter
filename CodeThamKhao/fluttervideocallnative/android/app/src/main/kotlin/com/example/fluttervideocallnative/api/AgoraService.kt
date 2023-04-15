package com.example.fluttervideocallnative.api

import com.example.fluttervideocallnative.model.ResToken
import com.example.fluttervideocallnative.model.Settings
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface AgoraService {
    @POST("agora/get-rtc-token")
    fun getRtcToken(@Body setting: Settings): Call<ResToken>
}
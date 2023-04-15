package com.example.api_retrofit.api

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.Header

import retrofit2.http.POST




interface AgoraService {
    @POST("agora/get-rtc-token")
    fun getRtcToken(@Body setting: Settings): Call<ResToken>
}
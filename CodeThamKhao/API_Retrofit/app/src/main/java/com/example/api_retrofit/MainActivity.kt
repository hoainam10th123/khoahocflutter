package com.example.api_retrofit

import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.api_retrofit.api.AgoraService
import com.example.api_retrofit.api.ResToken
import com.example.api_retrofit.api.Settings
import com.google.gson.GsonBuilder
import okhttp3.OkHttpClient
import okhttp3.Request
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


class MainActivity : AppCompatActivity() {
    val token = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiI4MDIxMTViMy1jYjZlLTQ0OWItYjI3Ny03ODBlZTM0NTg5MzUiLCJ1bmlxdWVfbmFtZSI6ImhvYWluYW0xMHRoIiwibmJmIjoxNjY1NjY2NzM5LCJleHAiOjE2NjU2NzM5MzksImlhdCI6MTY2NTY2NjczOX0.4Zo5LpwWqLXo5hadcOoY-w02vJNwkePBqfBRdATdoJ02-c5d84uKc2CKorC64FLz2ns16XpjMUAvmRlx3NaT1Q"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btnRtc: Button = findViewById(R.id.button)

        btnRtc.setOnClickListener {

            val gson = GsonBuilder()
                .setLenient()
                .create()

            val client = OkHttpClient.Builder().addInterceptor { chain ->
                val newRequest: Request = chain.request().newBuilder()
                    .addHeader("Authorization", "Bearer $token")
                    .build()
                chain.proceed(newRequest)
            }.build()

            val retrofit = Retrofit.Builder()
                .client(client)
                .baseUrl("http://10.0.2.2:5291/api/")
                .addConverterFactory(GsonConverterFactory.create(gson))
                .build()

            val service: AgoraService = retrofit.create(AgoraService::class.java)
            val call: Call<ResToken> = service.getRtcToken(Settings("hoainam10th", "ubuntu"))

            call.enqueue(object: Callback<ResToken> {
                override fun onFailure(call: Call<ResToken>, t: Throwable) {
                    Log.i("agora error token", t.message.toString())
                    Toast.makeText(applicationContext,"Error reading JSON", Toast.LENGTH_LONG).show()
                }

                override fun onResponse(call: Call<ResToken>, response: retrofit2.Response<ResToken>) {
                    val body = response.body()
                    if(response.code() == 200){
                        Log.i("agora token", body!!.token)
                    }
                }
            })
        }
    }
}
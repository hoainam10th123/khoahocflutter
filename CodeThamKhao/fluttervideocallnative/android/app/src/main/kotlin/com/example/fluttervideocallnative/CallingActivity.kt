package com.example.fluttervideocallnative

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.fluttervideocallnative.service.SignalRService


class CallingActivity: AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_calling)
        val tvTittle: TextView = findViewById(R.id.tvTittle)
        tvTittle.text = "Cuộc gọi đến từ ${SignalRService.callerDisplayName}"
    }

    fun answerCalling(view: View?) {
        SignalRService.stopAudio()
        val intent = Intent(this, CallingFromActivity::class.java)
        //intent.putExtra(Constanst.USER_NAME, etName.text.toString())
        startActivity(intent)
        finish()
    }
}
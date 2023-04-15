package com.example.servicekillkoltin

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import java.lang.reflect.Type

object Constanst {
    const val TOKEN: String = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiI3MmY0M2I5Ny04MzIzLTRmMmEtYWU4Zi1mZWI2NzU0M2E2NjMiLCJ1bmlxdWVfbmFtZSI6ImhvYWluYW0xMHRoIiwibmJmIjoxNjgwODc1MDY5LCJleHAiOjE2ODA4ODIyNjksImlhdCI6MTY4MDg3NTA2OX0.SzDHd4mxMdM53462aUKXq5T42fC4IJzVFP61HyzlHv19K3NIZddcGwUYdxy_ZLFirZ21VJgOZBnW-GPu6-lBCA"
    const val HUB_URL: String = "http://10.0.2.2:5291/hubs/"

    fun <T> arrayToString(list: List<T>?): String? {
        val g = Gson()
        return g.toJson(list)
    }

    fun <T> objectToString (member: T?):String?{
        val g = Gson()
        return g.toJson(member)
    }

    inline fun <reified T> parseArray(json: String, typeToken: Type): T {
        val gson = GsonBuilder().create()
        return gson.fromJson<T>(json, typeToken)
    }
}
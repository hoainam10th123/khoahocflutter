package com.example.fluttervideocallnative.model


import com.google.gson.Gson
import com.google.gson.GsonBuilder
import java.lang.reflect.Type

object Constanst {
    var TOKEN: String = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiI3MmY0M2I5Ny04MzIzLTRmMmEtYWU4Zi1mZWI2NzU0M2E2NjMiLCJ1bmlxdWVfbmFtZSI6ImhvYWluYW0xMHRoIiwibmJmIjoxNjgwMTQyNDI5LCJleHAiOjE2ODAxNDk2MjksImlhdCI6MTY4MDE0MjQyOX0.XYH5iyRvVmSIdiQJBVTs6cdxllB6hwyOusD1Aegamz9S9ihGMQT04DvzV2Ct0knIYJY3a9ER0Y24jDrfQZjHWg"
    const val HUB_URL: String = "http://192.168.1.8:5291/hubs/"
    const val API_URL: String = "http://192.168.1.8:5291/api/"

    var contacts = ArrayList<Member>()

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

    /*fun <T> stringToArray(s: String?, clazz: Class<Array<T>>?): MutableList<Array<T>> {
        val arr = Gson().fromJson(s, clazz)
        return Arrays.asList(arr)
    }*/

    /*
    fun test() {
    val json: String = "......."
    val type = object : TypeToken<List<MyObject>>() {}.type
    val result: List<MyObject> = parseArray<List<MyObject>>(json = json, typeToken = type)
    println(result)
}
    * */
}
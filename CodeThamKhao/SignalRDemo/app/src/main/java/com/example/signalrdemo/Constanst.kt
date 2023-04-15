package com.example.signalrdemo

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import java.lang.reflect.Type

object Constanst {
    const val TOKEN: String = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiI3MmY0M2I5Ny04MzIzLTRmMmEtYWU4Zi1mZWI2NzU0M2E2NjMiLCJ1bmlxdWVfbmFtZSI6ImhvYWluYW0xMHRoIiwibmJmIjoxNjgxMDI1NDM3LCJleHAiOjE2ODEwMzI2MzcsImlhdCI6MTY4MTAyNTQzN30.yqB8f_IW_49c0FaILMX_zGRlrK4wKvOhab5ueSM672PYYri0DPEbtLrLUDxZ63jCJqVcO3LNRV9ECkk1SkHARg"
    //const val BASE_URL: String = "http://10.0.2.2:5291"
    const val HUB_URL: String = "http://10.0.2.2:5291/hubs/"

    const val currentUsername = "hoainam10th"

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
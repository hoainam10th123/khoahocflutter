package com.example.signalrdemo

import androidx.core.net.toUri

abstract class Contact(
    val id: Long,
    val name: String,
    val icon: String
) {

    companion object {
        val CONTACTS = listOf(
            object : Contact(1L, "Cat", "cat.jpg") {

            },
            object : Contact(2L, "Dog", "dog.jpg") {

            },
            object : Contact(3L, "Parrot", "parrot.jpg") {

            },
            object : Contact(4L, "Sheep", "sheep.jpg") {

            }
        )
    }

    val iconUri = "content://com.example.android.people/icon/$id".toUri()

    val shortcutId = "contact_$id"

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as Contact

        if (id != other.id) return false
        if (name != other.name) return false
        if (icon != other.icon) return false

        return true
    }

    override fun hashCode(): Int {
        var result = id.hashCode()
        result = 31 * result + name.hashCode()
        result = 31 * result + icon.hashCode()
        return result
    }
}
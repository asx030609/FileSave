package com.chenxi1991.pccontrolserver.communicationmodels.touchpad

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel


class MouseClickModel(flag: Flag, button: Buttons, event: Events) : BaseModel() {
    var mButton: Buttons? = null
    var mEvent: Events? = null

    init {
        mFlag = flag
        mButton = button
        mEvent = event
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(3)
        values[0] = mFlag!!.value
        values[1] = mButton!!.flag
        values[2] = mEvent!!.flag
        mData = values
        return mData
    }

    enum class Buttons constructor(val flag: Byte) {
        LEFT(0x01.toByte()),
        MID(0x02.toByte()),
        RIGHT(0x03.toByte());

        companion object {
            fun getFlag(value: Byte): Buttons? {
                return Buttons.values().firstOrNull { it.flag == value }
            }
        }
    }

    enum class Events constructor(val flag: Byte) {
        DOWN(0x01.toByte()),
        RELEASE(0x02.toByte());

        companion object {
            fun getFlag(value: Byte): Events? {
                return Events.values().firstOrNull { it.flag == value }
            }
        }
    }
}
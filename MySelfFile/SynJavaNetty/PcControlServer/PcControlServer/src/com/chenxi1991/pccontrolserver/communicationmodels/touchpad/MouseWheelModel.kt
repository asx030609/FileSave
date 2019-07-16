package com.chenxi1991.pccontrolserver.communicationmodels.touchpad

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class MouseWheelModel(wheelY:Int) : BaseModel() {
    var mWheelY: Int? = null

    init {
        mFlag = Flag.MOUSE_WHEEL_SCROLL
        mWheelY = wheelY
    }

    override fun toByteArray(): ByteArray? {
        val temp = mWheelY!!.toByte()
        val values = ByteArray(2)
        values[0] = mFlag!!.value
        values[1] = temp
        mData = values
        return mData
    }
}
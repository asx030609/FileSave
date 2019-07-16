package com.chenxi1991.pccontrolserver.communicationmodels.touchpad

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class MouseMoveModel(moveX: Int, moveY: Int) : BaseModel() {
    var mMoveX: Int? = null
    var mMoveY: Int? = null

    init {
        mFlag = Flag.MOUSE_MOVE
        mMoveX = moveX
        mMoveY = moveY
    }

    override fun toByteArray(): ByteArray? {
        val xByte = mMoveX!!.toByte()
        val yByte = mMoveY!!.toByte()
        val values = ByteArray(3)
        values[0] = mFlag!!.value
        values[1] = xByte
        values[2] = yByte
        mData = values
        return mData
    }
}
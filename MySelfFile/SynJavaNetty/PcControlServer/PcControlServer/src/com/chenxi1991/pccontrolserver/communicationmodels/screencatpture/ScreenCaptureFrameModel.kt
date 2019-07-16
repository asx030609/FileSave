package com.chenxi1991.pccontrolserver.communicationmodels.screencatpture

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel


class ScreenCaptureFrameModel(frameType: FrameType, frameData: ByteArray) : BaseModel() {
    var mFrameType: FrameType? = null
    var mFrameData: ByteArray? = null

    init {
        mFlag = BaseModel.Flag.SCREEN_CAPTURE_FRAME
        mFrameType = frameType
        mFrameData = frameData
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1 + 1 + mFrameData!!.size)
        values[0] = mFlag!!.value
        values[1] = mFrameType!!.value
        System.arraycopy(mFrameData, 0, values, 2, mFrameData!!.size)
        mData = values
        return mData
    }

    enum class FrameType constructor(val value: Byte) {
        FRAME(0.toByte()),
        KEY_FRAME(1.toByte()),
        CONFIG(2.toByte()),
        END(4.toByte());

        companion object {
            fun getFrameType(value: Byte): FrameType? {
                return FrameType.values().firstOrNull { it.value == value }
            }
        }
    }
}
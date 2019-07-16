package com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.pc2android

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class Pc2AndroidCommandModel(flag: Flag) : BaseModel() {
    init {
        mFlag = flag
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1)
        values[0] = mFlag!!.value
        mData = values
        return mData
    }
}
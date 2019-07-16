package com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.android2pc

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class Android2PcCommandModel(flag: Flag) : BaseModel() {
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
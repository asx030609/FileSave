package com.chenxi1991.pccontrolserver.communicationmodels.keynote

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class PcEndShowModel : BaseModel() {
    init {
        mFlag = BaseModel.Flag.PC_END_SHOW
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1)
        values[0] = mFlag!!.value
        mData = values
        return mData
    }
}
package com.chenxi1991.pccontrolserver.communicationmodels.keynote

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class NextStepModel : BaseModel() {
    init {
        mFlag = BaseModel.Flag.NEXT_STEP
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1)
        values[0] = mFlag!!.value
        mData = values
        return mData
    }
}
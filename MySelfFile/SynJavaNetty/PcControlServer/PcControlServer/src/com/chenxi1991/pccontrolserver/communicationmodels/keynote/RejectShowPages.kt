package com.chenxi1991.pccontrolserver.communicationmodels.keynote

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class RejectShowPages : BaseModel() {
    init {
        mFlag = BaseModel.Flag.REJECT_SHOW_PAGES
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1)
        values[0] = mFlag!!.value
        mData = values
        return mData
    }
}
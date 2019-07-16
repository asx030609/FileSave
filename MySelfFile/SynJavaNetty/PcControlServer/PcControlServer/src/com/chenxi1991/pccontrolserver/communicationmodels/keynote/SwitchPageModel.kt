package com.chenxi1991.pccontrolserver.communicationmodels.keynote

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel


class SwitchPageModel(currentPage: Int) : BaseModel() {
    var mCurrentPage: Int? = null

    init {
        mFlag = BaseModel.Flag.SWITCH_PAGE
        mCurrentPage = currentPage
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(2)
        values[0] = mFlag!!.value
        values[1] = mCurrentPage!!.toByte()
        mData = values
        return mData
    }
}
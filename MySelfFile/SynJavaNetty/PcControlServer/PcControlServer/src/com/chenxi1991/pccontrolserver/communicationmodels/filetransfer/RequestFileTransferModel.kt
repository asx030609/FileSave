package com.chenxi1991.pccontrolserver.communicationmodels.filetransfer

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class RequestFileTransferModel : BaseModel() {
    init {
        mFlag = BaseModel.Flag.REQUEST_FILE_TRANSFER
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1)
        values[0] = mFlag!!.value
        mData = values
        return mData
    }
}
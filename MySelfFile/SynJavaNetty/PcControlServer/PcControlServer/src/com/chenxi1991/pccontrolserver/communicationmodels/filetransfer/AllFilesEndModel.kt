package com.chenxi1991.pccontrolserver.communicationmodels.filetransfer

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class AllFilesEndModel:BaseModel() {
    init {
        mFlag = BaseModel.Flag.ALL_FILES_END
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(1)
        values[0] = mFlag!!.value
        mData = values
        return mData
    }
}
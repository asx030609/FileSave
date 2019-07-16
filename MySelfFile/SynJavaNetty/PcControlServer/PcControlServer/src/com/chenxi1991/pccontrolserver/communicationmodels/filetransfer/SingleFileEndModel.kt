package com.chenxi1991.pccontrolserver.communicationmodels.filetransfer

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class SingleFileEndModel(filePath: String) : BaseModel() {
    var mFilePath: String? = null

    init {
        mFlag = BaseModel.Flag.SINGLE_FILE_END
        mFilePath = filePath
    }

    override fun toByteArray(): ByteArray? {
        val mFilePathByteArray = mFilePath!!.toByteArray()
        val values = ByteArray(1 + mFilePathByteArray.size)
        values[0] = mFlag!!.value
        System.arraycopy(mFilePathByteArray, 0, values, 1, mFilePathByteArray.size)
        mData = values
        return mData
    }
}
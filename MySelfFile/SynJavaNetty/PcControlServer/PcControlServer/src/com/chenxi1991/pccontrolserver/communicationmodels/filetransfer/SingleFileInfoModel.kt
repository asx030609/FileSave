package com.chenxi1991.pccontrolserver.communicationmodels.filetransfer

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class SingleFileInfoModel(filePath: String, fileSize: Int) : BaseModel() {
    var mFilePath: String? = null
    var mFileSize: Int? = null

    init {
        mFlag = BaseModel.Flag.SINGLE_FILE_INFO
        mFilePath = filePath
        mFileSize = fileSize
    }

    override fun toByteArray(): ByteArray? {
        val contentString = mFilePath!! + SEPREATOR + mFileSize.toString()
        val contentByteArray = contentString.toByteArray()
        val temp = ByteArray(1 + contentByteArray.size)
        temp[0] = mFlag!!.value
        System.arraycopy(contentByteArray, 0, temp, 1, contentByteArray.size)
        mData = temp
        return mData
    }
}
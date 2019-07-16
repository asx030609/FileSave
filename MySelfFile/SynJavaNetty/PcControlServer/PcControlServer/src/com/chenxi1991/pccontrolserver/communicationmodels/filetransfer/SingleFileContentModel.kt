package com.chenxi1991.pccontrolserver.communicationmodels.filetransfer

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class SingleFileContentModel(filePath: String, fileContent: ByteArray) : BaseModel() {
    var mFilePath: String? = null
    var mFileContent: ByteArray? = null

    init {
        mFlag = BaseModel.Flag.SINGLE_FILE_CONTENT
        mFilePath = filePath
        mFileContent = fileContent
    }

    override fun toByteArray(): ByteArray? {
        val mFilePathByteArray = mFilePath!!.toByteArray()
        val mFilePathLengthByte = mFilePath!!.length.toByte()
        val values = ByteArray(1 + 1 + mFilePathByteArray.size + mFileContent!!.size)
        values[0] = mFlag!!.value
        values[1] = mFilePathLengthByte
        System.arraycopy(mFilePathByteArray, 0, values, 2, mFilePathByteArray.size)
        System.arraycopy(mFileContent, 0, values, 2 + mFilePathByteArray.size, mFileContent!!.size)
        mData = values
        return mData
    }
}
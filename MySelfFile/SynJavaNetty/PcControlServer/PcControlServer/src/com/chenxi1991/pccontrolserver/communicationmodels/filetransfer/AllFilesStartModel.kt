package com.chenxi1991.pccontrolserver.communicationmodels.filetransfer

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class AllFilesStartModel(filePaths: MutableList<String>) : BaseModel() {
    var mFilePaths: MutableList<String>? = null

    init {
        mFlag = BaseModel.Flag.ALL_FILES_START
        mFilePaths = filePaths
    }

    override fun toByteArray(): ByteArray? {
        var filePathsString = ""
        val fileCount = mFilePaths!!.size
        mFilePaths!!.forEach {
            filePathsString += if (mFilePaths!!.indexOf(it) != fileCount!! - 1)
                it + SEPREATOR
            else
                it
        }
        val mFilePathsByteArray = filePathsString.toByteArray()
        val values = ByteArray(1 + mFilePathsByteArray.size)
        values[0] = mFlag!!.value
        System.arraycopy(mFilePathsByteArray, 0, values, 1, mFilePathsByteArray.size)
        mData = values
        return mData
    }
}
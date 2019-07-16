package com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.pc2android

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class AllowPcToAndroid(ip: String, port: Int) : BaseModel() {
    var mIp: String? = null
    var mPort: Int? = null

    init {
        mFlag = BaseModel.Flag.ALLOW_ANDROID_TO_PC
        mIp = ip
        mPort = port
    }

    override fun toByteArray(): ByteArray? {
        val temp = mIp + BaseModel.SEPREATOR + mPort.toString()
        val tempArray = temp.toByteArray()
        val values = ByteArray(1 + tempArray.size)
        values[0] = mFlag!!.value
        System.arraycopy(tempArray, 0, values, 1, tempArray.size)
        mData = values
        return mData
    }
}
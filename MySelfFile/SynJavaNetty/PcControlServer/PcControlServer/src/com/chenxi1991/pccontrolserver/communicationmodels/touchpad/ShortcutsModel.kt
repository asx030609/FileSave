package com.chenxi1991.pccontrolserver.communicationmodels.touchpad

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel

class ShortcutsModel(shortcut: Shortcuts) : BaseModel() {
    var mShortcut: Shortcuts? = null

    init {
        mFlag = Flag.SHORT_CUTS
        mShortcut = shortcut
    }

    override fun toByteArray(): ByteArray? {
        val values = ByteArray(2)
        values[0] = mFlag!!.value
        values[1] = mShortcut!!.flag
        mData = values
        return mData
    }

    enum class Shortcuts constructor(val flag: Byte) {
        SWITCH_WINDOW(0x01.toByte()),
        CLOSE_WINDOW(0x02.toByte()),
        SHOW_DESKTOP(0x03.toByte());

        companion object {
            fun getFlage(value: Byte): Shortcuts? {
                return Shortcuts.values().firstOrNull { it.flag == value }
            }
        }
    }
}
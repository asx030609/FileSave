package com.chenxi1991.pccontrolserver.communicationmodels

import com.chenxi1991.pccontrolserver.communicationmodels.filetransfer.*
import com.chenxi1991.pccontrolserver.communicationmodels.keynote.*
import com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.ScreenCaptureFrameModel
import com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.android2pc.AllowAndroidToPc
import com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.android2pc.Android2PcCommandModel
import com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.pc2android.AllowPcToAndroid
import com.chenxi1991.pccontrolserver.communicationmodels.screencatpture.pc2android.Pc2AndroidCommandModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.MouseClickModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.MouseMoveModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.MouseWheelModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.ShortcutsModel

open class BaseModel {
    var mFlag: Flag? = null
    var mData: ByteArray? = null

    open fun toByteArray(): ByteArray? {
        return null
    }

    companion object {
        val SEPREATOR = "\\"
        //TODO
        fun fromByteArray(byteArray: ByteArray, flag: Flag): BaseModel? {
            val values = ByteArray(byteArray.size - 1)
            System.arraycopy(byteArray, 1, values, 0, values.size)
            return when (flag) {
                Flag.MOUSE_MOVE -> {
                    MouseMoveModel(values[0].toInt(), values[1].toInt())

                }
                Flag.MOUSE_CLICK -> {
                    MouseClickModel(Flag.MOUSE_CLICK, MouseClickModel.Buttons.getFlag(values[0])!!, MouseClickModel.Events.getFlag(values[1])!!)
                }

                Flag.MOUSE_WHEEL_SCROLL -> {
                    MouseWheelModel(values[0].toInt())

                }
                Flag.SHORT_CUTS -> {
                    ShortcutsModel(ShortcutsModel.Shortcuts.getFlage(values[0])!!)
                }
                Flag.REQUEST_FILE_TRANSFER -> {
                    RequestFileTransferModel()
                }
                Flag.ALL_FILES_START -> {
                    val pathsString = String(values)
                    val paths = pathsString.split(SEPREATOR).toMutableList()
                    AllFilesStartModel(paths)
                }
                Flag.SINGLE_FILE_INFO -> {
                    val fileInfoString = String(values)
                    val infos = fileInfoString.split(SEPREATOR)
                    val path = infos[0]
                    val size = infos[1].toInt()
                    SingleFileInfoModel(path, size)
                }
                Flag.SINGLE_FILE_CONTENT -> {
                    val filePathByteLengs = values[0].toInt()
                    val filePathByteArray = ByteArray(filePathByteLengs)
                    System.arraycopy(values, 1, filePathByteArray, 0, filePathByteLengs)
                    val filePath = String(filePathByteArray)
                    val fileContent = ByteArray(values.size - 1 - filePathByteLengs)
                    System.arraycopy(values, 1 + filePathByteLengs, fileContent, 0, values.size - 1 - filePathByteLengs)
                    SingleFileContentModel(filePath, fileContent)
                }
                Flag.SINGLE_FILE_END -> {
                    val filePath = String(values)
                    SingleFileEndModel(filePath)
                }
                Flag.ALL_FILES_END -> {
                    AllFilesEndModel()
                }
                Flag.ALLOW_FILE_TRANSFER -> {
                    val temps = String(values).split(SEPREATOR)
                    val ip = temps[0]
                    val port = temps[1].toInt()
                    AllowFileTransferModel(ip, port)
                }
                Flag.REJECT_FILE_TRANSFER -> {
                    RejectFileTransferModel()
                }
                Flag.SCREEN_CAPTURE_FRAME -> {
                    val frameTypeByte = values[0]
                    val frameType = ScreenCaptureFrameModel.FrameType.getFrameType(frameTypeByte)
                    val frameDate = ByteArray(values.size - 1)
                    System.arraycopy(values, 1, frameDate, 0, values.size - 1)
                    ScreenCaptureFrameModel(frameType!!, frameDate)
                }
                Flag.REQUEST_ANDROID_TO_PC,
                Flag.ANDROID_DISCONNECT_ANDROID_TO_PC,
                Flag.REJECT_ANDROID_TO_PC,
                Flag.PC_DISCONNECT_ANDROID_TO_PC -> {
                    Android2PcCommandModel(flag)
                }
                Flag.ALLOW_ANDROID_TO_PC -> {
                    val temps = String(values).split(SEPREATOR)
                    val ip = temps[0]
                    val port = temps[1].toInt()
                    AllowAndroidToPc(ip, port)
                }
                Flag.REQUEST_PC_TO_ANDROID,
                Flag.ANDROID_DISCONNECT_PC_TO_ANDROID,
                Flag.PC_DISCONNECT_PC_TO_ANDROID,
                Flag.REJECT_PC_TO_ANDROID -> {
                    Pc2AndroidCommandModel(flag)
                }
                Flag.ALLOW_PC_TO_ANDROID -> {
                    val temps = String(values).split(SEPREATOR)
                    val ip = temps[0]
                    val port = temps[1].toInt()
                    AllowPcToAndroid(ip, port)
                }
                Flag.REQUEST_SHOW_PAGES -> {
                    RequestShowPagesModel()
                }
                Flag.SWITCH_PAGE -> {
                    val pageIndex = values[0].toInt()
                    SwitchPageModel(pageIndex)
                }
                Flag.NEXT_STEP -> {
                    NextStepModel()
                }
                Flag.ANDROID_END_SHOW -> {
                    AndroidEndShowModel()
                }
                Flag.PC_END_SHOW -> {
                    PcEndShowModel()
                }
                Flag.ALLOW_SHOW_PAGES -> {
                    val temps = String(values).split(SEPREATOR)
                    val ip = temps[0]
                    val port = temps[1].toInt()
                    AllowShowPages(ip, port)
                }
                Flag.REJECT_SHOW_PAGES -> {
                    RejectShowPages()
                }
            }
        }
    }

    enum class Flag constructor(val value: Byte) {
        //touchpad
        MOUSE_MOVE(0x31.toByte()),
        MOUSE_CLICK(0x30.toByte()),
        MOUSE_WHEEL_SCROLL(0x32.toByte()),
        SHORT_CUTS(0x33.toByte()),

        //filetransfer
        REQUEST_FILE_TRANSFER(0x20.toByte()),
        ALL_FILES_START(0x21.toByte()),
        SINGLE_FILE_INFO(0x22.toByte()),
        SINGLE_FILE_CONTENT(0x23.toByte()),
        SINGLE_FILE_END(0x24.toByte()),
        ALL_FILES_END(0x25.toByte()),

        ALLOW_FILE_TRANSFER(0x2E.toByte()),
        REJECT_FILE_TRANSFER(0x2F.toByte()),

        //screencapture
        SCREEN_CAPTURE_FRAME(0x18.toByte()),
        REQUEST_ANDROID_TO_PC(0x10.toByte()),
        ANDROID_DISCONNECT_ANDROID_TO_PC(0x11.toByte()),
        PC_DISCONNECT_ANDROID_TO_PC(0x1D.toByte()),
        ALLOW_ANDROID_TO_PC(0x1E.toByte()),
        REJECT_ANDROID_TO_PC(0x1F.toByte()),

        REQUEST_PC_TO_ANDROID(0x12.toByte()),
        ANDROID_DISCONNECT_PC_TO_ANDROID(0x13.toByte()),
        PC_DISCONNECT_PC_TO_ANDROID(0x1A.toByte()),
        ALLOW_PC_TO_ANDROID(0x1B.toByte()),
        REJECT_PC_TO_ANDROID(0x1C.toByte()),

        //keynote（ppt与UboradMate2？）
        REQUEST_SHOW_PAGES(0x51.toByte()),
        SWITCH_PAGE(0x52.toByte()),
        NEXT_STEP(0x53.toByte()),
        ANDROID_END_SHOW(0x54.toByte()),

        PC_END_SHOW(0x5D.toByte()),
        ALLOW_SHOW_PAGES(0x5E.toByte()),
        REJECT_SHOW_PAGES(0x5F.toByte());
        companion object {
            fun getFlag(value: Byte): Flag? {
                return Flag.values().firstOrNull { it.value == value }
            }
        }
    }
}
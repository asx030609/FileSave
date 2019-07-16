package com.chenxi1991.pccontrolserver.nettyserver.command

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel
import com.chenxi1991.pccontrolserver.communicationmodels.filetransfer.AllowFileTransferModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.MouseClickModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.MouseMoveModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.MouseWheelModel
import com.chenxi1991.pccontrolserver.communicationmodels.touchpad.ShortcutsModel
import io.netty.buffer.ByteBuf
import io.netty.channel.Channel
import io.netty.channel.ChannelHandlerContext
import io.netty.channel.SimpleChannelInboundHandler
import java.awt.MouseInfo
import java.awt.Robot
import java.awt.event.InputEvent
import java.awt.event.KeyEvent

class ServerHandler : SimpleChannelInboundHandler<ByteBuf>() {
    val mRobot = Robot()
    var notNullX = 0
    var notNullY = 0
    var currentX = 0
    var currentY = 0
    val osName = System.getProperty("os.name")

    override fun handlerAdded(ctx: ChannelHandlerContext?) {
        super.handlerAdded(ctx)
        if (mConnectClientChannel == null) {
            mConnectClientChannel = ctx!!.channel()!!
        } else {
            ctx!!.channel()!!.close()
        }
    }

    override fun channelRead0(channelHandlerContext: ChannelHandlerContext, byteBuf: ByteBuf) {
        val buf = ByteArray(byteBuf.readableBytes())
        byteBuf.readBytes(buf)
        onGetPacket(buf)
    }

    override fun channelInactive(ctx: ChannelHandlerContext) {
        super.channelInactive(ctx)
    }

    /**
     * 接收客户端发送过来的数据包
     */
    private fun onGetPacket(bys: ByteArray) {
        val flag = BaseModel.Flag.getFlag(bys[0]) ?: return
        when (flag) {
            BaseModel.Flag.MOUSE_MOVE -> {
                try {
                    val mouseMoveModel = BaseModel.fromByteArray(bys, flag) as MouseMoveModel
                    val pointInfo = MouseInfo.getPointerInfo()
                    if (pointInfo != null) {
                        currentX = pointInfo.location.x + mouseMoveModel.mMoveX!!
                        currentY = pointInfo.location.y + mouseMoveModel.mMoveY!!
                        notNullX = pointInfo.location.x
                        notNullY = pointInfo.location.y
                    } else {
                        currentX = notNullX + mouseMoveModel.mMoveX!!
                        currentY = notNullY + mouseMoveModel.mMoveY!!
                    }
                    mRobot.mouseMove(currentX, currentY)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
            BaseModel.Flag.MOUSE_CLICK -> {
                val mouseClickModel = BaseModel.fromByteArray(bys, flag) as MouseClickModel
                val button = when (mouseClickModel.mButton!!) {
                    MouseClickModel.Buttons.LEFT -> {
                        InputEvent.BUTTON1_MASK
                    }
                    MouseClickModel.Buttons.MID -> {
                        InputEvent.BUTTON2_MASK
                    }
                    MouseClickModel.Buttons.RIGHT -> {
                        InputEvent.BUTTON3_MASK
                    }
                }
                when (mouseClickModel.mEvent!!) {
                    MouseClickModel.Events.DOWN -> {
                        mRobot.mousePress(button)
                    }
                    MouseClickModel.Events.RELEASE -> {
                        mRobot.mouseRelease(button)
                    }
                }
            }
            BaseModel.Flag.MOUSE_WHEEL_SCROLL -> {
                val mouseWheelModel = BaseModel.fromByteArray(bys, flag) as MouseWheelModel
                mRobot.mouseWheel(mouseWheelModel.mWheelY!!.toInt())
            }
            BaseModel.Flag.SHORT_CUTS -> {
                val shortcutsModel = BaseModel.fromByteArray(bys, flag) as ShortcutsModel
                when (shortcutsModel.mShortcut!!) {
                //win:alt+F4
                    ShortcutsModel.Shortcuts.CLOSE_WINDOW -> {
                        when (osName) {
                            "Mac OS X" -> {
                                mRobot.keyPress(KeyEvent.VK_META)
                                mRobot.keyPress(KeyEvent.VK_Q)
                                mRobot.keyRelease(KeyEvent.VK_Q)
                                mRobot.keyRelease(KeyEvent.VK_META)
                            }
                            "Windows" -> {
                                mRobot.keyPress(KeyEvent.VK_ALT)
                                mRobot.keyPress(KeyEvent.VK_F4)
                                mRobot.keyRelease(KeyEvent.VK_F4)
                                mRobot.keyRelease(KeyEvent.VK_ALT)
                            }
                        }
                        mRobot.keyPress(KeyEvent.VK_ALT)
                        mRobot.keyPress(KeyEvent.VK_F4)
                        mRobot.keyRelease(KeyEvent.VK_F4)
                        mRobot.keyRelease(KeyEvent.VK_ALT)
                    }
                //win:alt+tab
                    ShortcutsModel.Shortcuts.SWITCH_WINDOW -> {
                        when (osName) {
                            "Mac OS X" -> {
                                mRobot.keyPress(KeyEvent.VK_META)
                                mRobot.keyPress(KeyEvent.VK_TAB)
                                mRobot.keyRelease(KeyEvent.VK_TAB)
                                mRobot.keyRelease(KeyEvent.VK_META)
                            }
                            "Windows" -> {
                                mRobot.keyPress(KeyEvent.VK_ALT)
                                mRobot.keyPress(KeyEvent.VK_TAB)
                                mRobot.keyRelease(KeyEvent.VK_TAB)
                                mRobot.keyRelease(KeyEvent.VK_ALT)
                            }
                        }

                    }
                //win:win+d
                    ShortcutsModel.Shortcuts.SHOW_DESKTOP -> {
                        when (osName) {
                            "Mac OS X" -> {
                                mRobot.keyPress(KeyEvent.VK_F11)
                                mRobot.keyRelease(KeyEvent.VK_F11)
                            }
                            "Windows" -> {
                                mRobot.keyPress(KeyEvent.VK_WINDOWS)
                                mRobot.keyPress(KeyEvent.VK_D)
                                mRobot.keyRelease(KeyEvent.VK_D)
                                mRobot.keyRelease(KeyEvent.VK_WINDOWS)
                            }
                        }
                    }
                }
            }
            BaseModel.Flag.REQUEST_FILE_TRANSFER -> {
                NettyServer.nettyServer.sendPacket(AllowFileTransferModel("192.168.110.119",7880).toByteArray()!!)
            }
        }
    }

    companion object {
        var mConnectClientChannel: Channel? = null
    }
}

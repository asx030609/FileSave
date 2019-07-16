package com.chenxi1991.pccontrolserver.nettyserver.io

import com.chenxi1991.pccontrolserver.communicationmodels.BaseModel
import com.chenxi1991.pccontrolserver.communicationmodels.filetransfer.*
import io.netty.buffer.ByteBuf
import io.netty.channel.Channel
import io.netty.channel.ChannelHandlerContext
import io.netty.channel.SimpleChannelInboundHandler

class IoServerHandler : SimpleChannelInboundHandler<ByteBuf>() {

    @Throws(Exception::class)
    override fun handlerAdded(ctx: ChannelHandlerContext?) {
        super.handlerAdded(ctx)
        if (mIoConnectClientChannel == null) {
            mIoConnectClientChannel = ctx!!.channel()
        } else {
            ctx!!.channel().close()
        }
    }

    @Throws(Exception::class)
    override fun channelRead0(p0: ChannelHandlerContext?, byteBuf: ByteBuf) {
        val buf = ByteArray(byteBuf.readableBytes())
        byteBuf.readBytes(buf)
        onGetPacket(buf)
    }

    @Throws(Exception::class)
    override fun channelInactive(ctx: ChannelHandlerContext?) {
        super.channelInactive(ctx)
    }

    @Throws(Exception::class)
    private fun onGetPacket(bys: ByteArray) {
        val flag = BaseModel.Flag.getFlag(bys[0]) ?: return
        when (flag) {
            BaseModel.Flag.ALL_FILES_START -> {
                val model = BaseModel.fromByteArray(bys, flag) as AllFilesStartModel
                println("allStart")
                model.mFilePaths!!.forEach {
                    println(it)
                }
            }

            BaseModel.Flag.SINGLE_FILE_INFO -> {
                val model = BaseModel.fromByteArray(bys, flag) as SingleFileInfoModel
                println("singleInfo: ${model.mFileSize}  ${model.mFilePath}")
            }
            BaseModel.Flag.SINGLE_FILE_CONTENT -> {
                val model = BaseModel.fromByteArray(bys, flag) as SingleFileContentModel
                println("singleContent: ${model.mFileContent!!.size} ${model.mFilePath}")
            }
            BaseModel.Flag.SINGLE_FILE_END -> {
                val model = BaseModel.fromByteArray(bys, flag) as SingleFileEndModel
                println("singleEnd: ${model.mFilePath}")
            }
            BaseModel.Flag.ALL_FILES_END -> {
                val model = BaseModel.fromByteArray(bys, flag) as AllFilesEndModel
                println("allEnd")
            }
        }
    }

    companion object {
        var mIoConnectClientChannel: Channel? = null
    }
}
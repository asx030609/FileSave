package com.chenxi1991.pccontrolserver.nettyserver.command

import io.netty.channel.Channel
import io.netty.channel.ChannelInitializer
import io.netty.handler.codec.LengthFieldBasedFrameDecoder
import io.netty.handler.codec.LengthFieldPrepender

class ServerInitializer : ChannelInitializer<Channel>() {
    override fun initChannel(channel: Channel) {
        val pipeline = channel.pipeline()
        pipeline.addLast("frameDecoder", LengthFieldBasedFrameDecoder(8 * 1024 * 1024, 0, 4, 0, 4))
        pipeline.addLast("frameEncoder", LengthFieldPrepender(4, false))
        pipeline.addLast("handler", ServerHandler())
    }
}

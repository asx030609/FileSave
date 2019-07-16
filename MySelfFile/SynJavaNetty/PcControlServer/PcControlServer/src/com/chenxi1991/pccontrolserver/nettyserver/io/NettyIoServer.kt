package com.chenxi1991.pccontrolserver.nettyserver.io

import io.netty.bootstrap.ServerBootstrap
import io.netty.channel.ChannelFuture
import io.netty.channel.ChannelFutureListener
import io.netty.channel.ChannelOption
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.nio.NioServerSocketChannel

class NettyIoServer(private var port:Int = 7880) {
    private var mFuture: ChannelFuture? = null
    private var mBossLoop: NioEventLoopGroup? = null
    private var mWorkLoop: NioEventLoopGroup? = null

    /**
     * 启动服务器
     */
    fun startServer() {
        mBossLoop = NioEventLoopGroup()
        mWorkLoop = NioEventLoopGroup()
        try {
            val serverBootstrap = ServerBootstrap()
            serverBootstrap.group(mBossLoop, mWorkLoop)
                    .option(ChannelOption.SO_RCVBUF, (1024 * 1024 * 0.3).toInt())
                    .option(ChannelOption.SO_BACKLOG, 1000)
                    .childOption(ChannelOption.SO_KEEPALIVE, true)
                    .childOption(ChannelOption.TCP_NODELAY, true)
                    .channel(NioServerSocketChannel::class.java)
                    .childHandler(IoServerInitializer())

            println("IO服务器已启动，等待客户端连接")
            mFuture = serverBootstrap.bind(port).sync()
            mFuture!!.channel().closeFuture().sync()
        } finally {
            mBossLoop?.shutdownGracefully()
            mWorkLoop?.shutdownGracefully()
        }
    }

    /**
     * 停止服务器
     */
    fun stopServer() {
        mFuture?.channel()?.closeFuture()
        mBossLoop?.shutdownGracefully()
        mWorkLoop?.shutdownGracefully()
    }

    /**
     * TODO
     * 发送数据包
     */
    fun sendPacket(toByteArray: ByteArray, listener: ChannelFutureListener = ChannelFutureListener {}) {
        val channel = IoServerHandler.mIoConnectClientChannel
        val buffer = channel?.alloc()?.buffer(toByteArray.size)
        buffer?.writeBytes(toByteArray, 0, toByteArray.size)
        channel?.writeAndFlush(buffer)
    }


    companion object {
        val nettyServer by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { NettyIoServer() }
    }
}
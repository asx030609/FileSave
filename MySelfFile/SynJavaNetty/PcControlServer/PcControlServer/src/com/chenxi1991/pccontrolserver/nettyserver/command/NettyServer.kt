package com.chenxi1991.pccontrolserver.nettyserver.command

import io.netty.bootstrap.ServerBootstrap
import io.netty.channel.ChannelFuture
import io.netty.channel.ChannelFutureListener
import io.netty.channel.ChannelOption
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.nio.NioServerSocketChannel


/**
 * 文 件 名: NettyServer
 * 创 建 人: sineom
 * 创建日期: 2017/8/8 15:16

 * 修改时间：
 * 修改备注：
 */

class NettyServer(private var port: Int = 7879) {

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
                    .childHandler(ServerInitializer())

            println("服务器已启动，等待客户端连接")
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
        val channel = ServerHandler.mConnectClientChannel
        val buffer = channel?.alloc()?.buffer(toByteArray.size)
        buffer?.writeBytes(toByteArray, 0, toByteArray.size)
        channel?.writeAndFlush(buffer)
    }


    companion object {
        val nettyServer by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { NettyServer() }
    }
}
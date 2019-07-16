package com.chenxi1991.pccontrolserver

import com.chenxi1991.pccontrolserver.nettyserver.command.NettyServer
import com.chenxi1991.pccontrolserver.nettyserver.io.NettyIoServer

object PcControlServer {
    @JvmStatic
    fun main(args: Array<String>) {
        Thread { NettyServer.nettyServer.startServer() }.start()
        Thread { NettyIoServer.nettyServer.startServer() }.start()
    }
}
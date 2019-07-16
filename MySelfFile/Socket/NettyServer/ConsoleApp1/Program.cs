using DotNetty.Handlers.Tls;
using DotNetty.Transport.Bootstrapping;
using DotNetty.Transport.Channels;
using DotNetty.Transport.Channels.Sockets;
using DotNetty.Transport.Libuv;
using Echo.Server;
using Examples.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static async Task RunServerAsync()
        {


            IEventLoopGroup bossGroup;
            IEventLoopGroup workerGroup;

            if (ServerSettings.UseLibuv)
            {
                var dispatcher = new DispatcherEventLoopGroup();
                bossGroup = dispatcher;
                workerGroup = new WorkerEventLoopGroup(dispatcher);
            }
            else
            {
                bossGroup = new MultithreadEventLoopGroup(1);
                workerGroup = new MultithreadEventLoopGroup();
            }

            X509Certificate2 tlsCertificate = null;
            if (ServerSettings.IsSsl)
            {
                //tlsCertificate = new X509Certificate2(Path.Combine(ExampleHelper.ProcessDirectory, "dotnetty.com.pfx"), "password");
            }
            try
            {
                var bootstrap = new ServerBootstrap();
                bootstrap.Group(bossGroup, workerGroup);

                if (ServerSettings.UseLibuv)
                {
                    bootstrap.Channel<TcpServerChannel>();
                }
                else
                {
                    bootstrap.Channel<TcpServerSocketChannel>();
                }

                bootstrap
                    .Option(ChannelOption.SoBacklog, 100)
                    // .Handler(new LoggingHandler("SRV-LSTN"))
                    .ChildHandler(new ActionChannelInitializer<IChannel>(channel =>
                    {
                        IChannelPipeline pipeline = channel.Pipeline;
                        if (tlsCertificate != null)
                        {
                            pipeline.AddLast("tls", TlsHandler.Server(tlsCertificate));
                        }
                        pipeline.AddLast("echo", new EchoServerHandler());
                        //pipeline.AddLast(new LoggingHandler("SRV-CONN"));
                        //pipeline.AddLast("framing-enc", new LengthFieldPrepender(2));
                        //pipeline.AddLast("framing-dec", new LengthFieldBasedFrameDecoder(ushort.MaxValue, 0, 2, 0, 2));



                        // pipeline.AddLast(new EchoServerHandler());

                    }));

                IChannel boundChannel = await bootstrap.BindAsync(ServerSettings.Port);

                Console.ReadLine();

                await boundChannel.CloseAsync();
            }
            finally
            {
                await Task.WhenAll(
                    bossGroup.ShutdownGracefullyAsync(TimeSpan.FromMilliseconds(100), TimeSpan.FromSeconds(1)),
                    workerGroup.ShutdownGracefullyAsync(TimeSpan.FromMilliseconds(100), TimeSpan.FromSeconds(1)));
            }
        }
        static void Main(string[] args)
        {
            RunServerAsync().Wait();
        }
    }
}

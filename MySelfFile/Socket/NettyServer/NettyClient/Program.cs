using DotNetty.Buffers;
using DotNetty.Handlers.Tls;
using DotNetty.Transport.Bootstrapping;
using DotNetty.Transport.Channels;
using DotNetty.Transport.Channels.Sockets;
using Echo.Client;
using Examples.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using MyNetty;
using System.Threading;

namespace NettyClient
{
    class Program
    {
        static async Task RunClientAsync()
        {


            var group = new MultithreadEventLoopGroup();

            X509Certificate2 cert = null;
            string targetHost = null;
            if (ClientSettings.IsSsl)
            {
                //cert = new X509Certificate2(Path.Combine(ExampleHelper.ProcessDirectory, "dotnetty.com.pfx"), "password");
                targetHost = cert.GetNameInfo(X509NameType.DnsName, false);
            }
            try
            {
                var bootstrap = new Bootstrap();
                bootstrap
                    .Group(group)
                    .Channel<TcpSocketChannel>()
                    .Option(ChannelOption.TcpNodelay, true)
                    .Handler(new ActionChannelInitializer<ISocketChannel>(channel =>
                    {
                        IChannelPipeline pipeline = channel.Pipeline;

                        if (cert != null)
                        {
                            pipeline.AddLast("tls", new TlsHandler(stream => new SslStream(stream, true, (sender, certificate, chain, errors) => true), new ClientTlsSettings(targetHost)));
                        }


                        pipeline.AddLast("echo", new EchoClientHandler());
                    }));

                IChannel clientChannel = await bootstrap.ConnectAsync(new IPEndPoint(ClientSettings.Host, ClientSettings.Port));
                var jt808cmd = "7e0100002c020000000";   // 0150025002c0133373039363054372d54383038000000000000000000000000003033323931373001d4c142383838387b7e";
                
                while (true)
                {
                    Thread.Sleep(2000);
                        Console.WriteLine("发送成功>>>>>>>>");
                    await clientChannel.WriteAndFlushAsync(Unpooled.WrappedBuffer(jt808cmd.HexToBytes()));
                }
               

                Console.ReadLine();

                await clientChannel.CloseAsync();
            }
            finally
            {
                await group.ShutdownGracefullyAsync(TimeSpan.FromMilliseconds(100), TimeSpan.FromSeconds(1));
            }
        }
        static void Main(string[] args)
        {
            RunClientAsync().Wait();
        }
    }
}

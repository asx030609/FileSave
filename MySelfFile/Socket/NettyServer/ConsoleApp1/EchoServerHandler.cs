// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

namespace Echo.Server
{
    using System;
    using System.Text;
    using DotNetty.Buffers;
    using DotNetty.Transport.Channels;
    using MyNetty;

    public class EchoServerHandler : ChannelHandlerAdapter
    {
        int i = 0;
        public override void ChannelRead(IChannelHandlerContext context, object message)
        {
            i += 1;
            var buffer = message as IByteBuffer;
            if (buffer != null)
            {
                Console.WriteLine(i.ToString() + "Received from client: " + this.Format(context, "RECEIVED", message));
            }
            string info = "AAA";
            //writeAndFlushv
            // var a = info as IByteBuffer;
            //context.WriteAndFlushAsync(a);

           
            context.WriteAndFlushAsync(Unpooled.WrappedBuffer(info.HexToBytes()));

        }

        /// <summary>
        ///     Formats an event and returns the formatted message.
        /// </summary>
        /// <param name="eventName">the name of the event</param>
        /// <param name="arg">the argument of the event</param>
        protected virtual string Format(IChannelHandlerContext ctx, string eventName, object arg)
        {
            if (arg is IByteBuffer)
            {
                return this.FormatByteBuffer(ctx, eventName, (IByteBuffer)arg);
            }
            else if (arg is IByteBufferHolder)
            {
                return this.FormatByteBufferHolder(ctx, eventName, (IByteBufferHolder)arg);
            }
            else
            {
                return this.FormatSimple(ctx, eventName, arg);
            }
        }
        /// <summary>
        ///     Generates the default log message of the specified event whose argument is an arbitrary object.
        /// </summary>
        string FormatSimple(IChannelHandlerContext ctx, string eventName, object msg)
        {
            string chStr = ctx.Channel.ToString();
            string msgStr = msg.ToString();
            var buf = new StringBuilder(chStr.Length + 1 + eventName.Length + 2 + msgStr.Length);
            return buf.Append(chStr).Append(' ').Append(eventName).Append(": ").Append(msgStr).ToString();
        }
        /// <summary>
        ///     Generates the default log message of the specified event whose argument is a <see cref="IByteBufferHolder" />.
        /// </summary>
        string FormatByteBufferHolder(IChannelHandlerContext ctx, string eventName, IByteBufferHolder msg)
        {
            string chStr = ctx.Channel.ToString();
            string msgStr = msg.ToString();
            IByteBuffer content = msg.Content;
            int length = content.ReadableBytes;
            if (length == 0)
            {
                var buf = new StringBuilder(chStr.Length + 1 + eventName.Length + 2 + msgStr.Length + 4);
                buf.Append(chStr).Append(' ').Append(eventName).Append(", ").Append(msgStr).Append(", 0B");
                return buf.ToString();
            }
            else
            {
                int rows = length / 16 + (length % 15 == 0 ? 0 : 1) + 4;
                var buf = new StringBuilder(
                    chStr.Length + 1 + eventName.Length + 2 + msgStr.Length + 2 + 10 + 1 + 2 + rows * 80);

                buf.Append(chStr).Append(' ').Append(eventName).Append(": ")
                    .Append(msgStr).Append(", ").Append(length).Append('B').Append('\n');
                ByteBufferUtil.AppendPrettyHexDump(buf, content);

                return buf.ToString();
            }
        }

        /// <summary>
        ///     Generates the default log message of the specified event whose argument is a  <see cref="IByteBuffer" />.
        /// </summary>
        string FormatByteBuffer(IChannelHandlerContext ctx, string eventName, IByteBuffer msg)
        {
            string chStr = ctx.Channel.ToString();
            int length = msg.ReadableBytes;
            if (length == 0)
            {
                var buf = new StringBuilder(chStr.Length + 1 + eventName.Length + 4);
                buf.Append(chStr).Append(' ').Append(eventName).Append(": 0B");
                return buf.ToString();
            }
            else
            {
                int rows = length / 16 + (length % 15 == 0 ? 0 : 1) + 4;
                var buf = new StringBuilder(chStr.Length + 1 + eventName.Length + 2 + 10 + 1 + 2 + rows * 80);

                buf.Append(chStr).Append(' ').Append(eventName).Append(": ").Append(length).Append('B').Append('\n');
                ByteBufferUtil.AppendPrettyHexDump(buf, msg);

                return buf.ToString();
            }
        }

        /// <summary>
        ///     Formats an event and returns the formatted message.  This method is currently only used for formatting
        ///     <see cref="IChannelHandler.ConnectAsync(IChannelHandlerContext, EndPoint, EndPoint)" />
        /// </summary>
        /// <param name="eventName">the name of the event</param>
        /// <param name="firstArg">the first argument of the event</param>
        /// <param name="secondArg">the second argument of the event</param>
        protected virtual string Format(IChannelHandlerContext ctx, string eventName, object firstArg, object secondArg)
        {
            if (secondArg == null)
            {
                return this.FormatSimple(ctx, eventName, firstArg);
            }
            string chStr = ctx.Channel.ToString();
            string arg1Str = firstArg.ToString();
            string arg2Str = secondArg.ToString();

            var buf = new StringBuilder(
                chStr.Length + 1 + eventName.Length + 2 + arg1Str.Length + 2 + arg2Str.Length);
            buf.Append(chStr).Append(' ').Append(eventName).Append(": ")
                .Append(arg1Str).Append(", ").Append(arg2Str);
            return buf.ToString();
        }


        public override void ChannelReadComplete(IChannelHandlerContext context)
        {
            context.Flush();
        }

        public override void ExceptionCaught(IChannelHandlerContext context, Exception exception)
        {
            Console.WriteLine("Exception: " + exception);
            Console.WriteLine(context.Name);
            context.CloseAsync();
        }
    }
}
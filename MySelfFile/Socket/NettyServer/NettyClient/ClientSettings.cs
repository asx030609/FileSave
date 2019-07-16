// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

namespace Examples.Common
{
    using System.Net;

    public class ClientSettings
    {
        public static bool IsSsl
        {
            get
            {
                string ssl = "false";// ExampleHelper.Configuration["ssl"];
                return !string.IsNullOrEmpty(ssl) && bool.Parse(ssl);
            }
        }

        public static IPAddress Host => IPAddress.Parse("127.0.0.1");

        public static int Port => int.Parse("7001");

        public static int Size => int.Parse("1024");
    }
}
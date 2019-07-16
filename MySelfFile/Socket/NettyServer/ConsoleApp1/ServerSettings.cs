// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

namespace Examples.Common
{
    public static class ServerSettings
    {
        public static bool IsSsl
        {
            get
            {
                string ssl = "false"; //ExampleHelper.Configuration["ssl"];
                return !string.IsNullOrEmpty(ssl) && bool.Parse(ssl);
            }
        }

        public static int Port => int.Parse("7001");

        public static bool UseLibuv
        {
            get
            {
                string libuv = "false"; //ExampleHelper.Configuration["libuv"];
                return !string.IsNullOrEmpty(libuv) && bool.Parse(libuv);
            }
        }
    }
}
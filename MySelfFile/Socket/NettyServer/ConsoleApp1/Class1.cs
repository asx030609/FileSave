using System;
using System.Collections.Generic;
using System.Text;

namespace MyNetty
{
    public static class Class1
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static byte[] HexToBytes(this string str)
        {
            return HexToBytes(str, 0, 0, 0);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="str"></param>
        /// <param name="offset"></param>
        /// <param name="step"></param>
        /// <param name="tail"></param>
        /// <returns></returns>
        public static byte[] HexToBytes(this string str, int offset, int step, int tail)
        {
            byte[] b = new byte[(str.Length - offset - tail + step) / (2 + step)];
            byte c1, c2;
            int l = str.Length - tail;
            int s = step + 1;
            for (int y = 0, x = offset; x < l; ++y, x += s)
            {
                c1 = (byte)str[x];
                if (c1 > 0x60)
                {
                    c1 -= 0x57;
                }
                else if (c1 > 0x40)
                {
                    c1 -= 0x37;
                }
                else
                {
                    c1 -= 0x30;
                }

                c2 = (byte)str[++x];
                if (c2 > 0x60)
                {
                    c2 -= 0x57;
                }
                else if (c2 > 0x40)
                {
                    c2 -= 0x37;
                }
                else
                {
                    c2 -= 0x30;
                }
                //b[y] = (byte)((c1 << 4) + c2);
                b[y] = (byte)((c1 << 4) | c2);
            }
            return b;
        }
    }
}

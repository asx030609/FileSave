using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using com.itstack.bean;
using System.IO;
using Google.ProtocolBuffers;

namespace TestSocketSendProtobufToJavaNettyServer
{
    class Program
    {
        private static byte[] result = new byte[1024];

        static void Main(string[] args)
        {

            //设定服务器IP地址  
            IPAddress ip = IPAddress.Parse("192.168.1.102");
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

            try
            {
                clientSocket.Connect(new IPEndPoint(ip, 8007)); //配置服务器IP与端口  
                Console.WriteLine("连接服务器成功");
            }
            catch (Exception ex)
            {
                Console.WriteLine("连接服务器失败，请按回车键退出！" + ex);
                return;
            }

            //通过clientSocket接收数据 [暂不使用]
            //int receiveLength = clientSocket.Receive(result);
            //Console.WriteLine("接收服务器消息：{0}", receiveLength);

            //通过 clientSocket 发送数据  
            for (int i = 0; i < 500; i++)
            {
                try
                {
                    #region 构建数据

                    //封装protobuf empBean实例化
                    EmpBean.Builder empBeanBuilder = EmpBean.CreateBuilder();

                    empBeanBuilder.SetEmpName("付政委");
                    empBeanBuilder.SetEmpQQ("184172133");
                    empBeanBuilder.SetEmpInDate("20090101");
                    empBeanBuilder.SetEmpType(EmpEnum.Harmast);

                    #region 创建公司信息1个

                    CompanyBean.Builder companyBeanBuilder_Sinosoft = CompanyBean.CreateBuilder();
                    companyBeanBuilder_Sinosoft.SetJobSeniority("1");
                    companyBeanBuilder_Sinosoft.SetCompanyName("中科软科技");
                    companyBeanBuilder_Sinosoft.SetSalary("1000");

                    empBeanBuilder.AddEmpCompany(companyBeanBuilder_Sinosoft);

                    #endregion

                    #region 创建公司信息1个

                    CompanyBean.Builder companyBeanBuilder_Chinasofti = CompanyBean.CreateBuilder();
                    companyBeanBuilder_Chinasofti.SetJobSeniority("3");
                    companyBeanBuilder_Chinasofti.SetCompanyName("中软国际信息技术有限公司");
                    companyBeanBuilder_Chinasofti.SetSalary("2000");

                    empBeanBuilder.AddEmpCompany(companyBeanBuilder_Chinasofti);

                    #endregion

                    //建立Bean
                    EmpBean SendEmpBean = empBeanBuilder.Build();

                    #endregion

                    #region 发送数据

                    //转为byte字节
                    byte[] buf = SendEmpBean.ToByteArray();
                    //通过socket发送
                    clientSocket.Send(buf);
                    //休眠500毫秒
                    Thread.Sleep(500);

                    #endregion

                    Console.WriteLine("向服务器发送消息");
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                    break;
                }
            }
            Console.WriteLine("发送完毕，按回车键退出");
            Console.ReadLine();

        }
    }

}

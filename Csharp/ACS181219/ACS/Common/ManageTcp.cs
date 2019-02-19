using System;
using System.Net.Sockets;
using System.Threading;

namespace ACS
{
    public class ManageTcp
    {
        /// <summary>
        /// 服务侦听
        /// </summary>
        /// <param name="Backlog">挂起的连接请求</param>
        /// <param name="SvrSocket">服务套接字</param>
        public static void ServerListen(int Backlog, Socket SvrSocket)
        {
            SvrSocket.Listen(Backlog);//开始监听

            while (true)
            {
                if (Commond.IsClose)
                    break;

                //服务器监听，建立socket
                Socket ClientSocket = SvrSocket.Accept();
                ClientSocket.ReceiveTimeout = 3000;
                //创建线程
                Thread thSocket = new Thread(new ParameterizedThreadStart(DealAgvMsg));
                //线程启动，参数为socket
                thSocket.Start(ClientSocket);
                //MultiSocket(ClientSocket);
            }
        }

        /// <summary>
        /// 处理AGV消息
        /// </summary>
        /// <param name="ClientSocket">客户端对象</param>
        public static void DealAgvMsg(Object ClientSocket)
        {
            Socket cSocket = ClientSocket as Socket;

            try
            {
                byte[] ReceiveData = new byte[1024];
                cSocket.ReceiveTimeout = 3000;
                if (cSocket.Poll(3000000, SelectMode.SelectRead))
                {
                    int DataLength = cSocket.Receive(ReceiveData);
                    if (DataLength > 0)
                    {
                        SocketOpt SRece = new SocketOpt(cSocket, ReceiveData);

                        if (SRece != null)
                        {
                            TimeSpan ts1 = new TimeSpan(DateTime.Now.Ticks);

                            MsgManage.DataTranslate(SRece);


                            TimeSpan ts2 = new TimeSpan(DateTime.Now.Ticks);
                            TimeSpan ts3 = ts2.Subtract(ts1).Duration();
                            SRece.dealTime = ts3.Milliseconds - SRece.dealTime;

                            //string sql = string.Format("INSERT INTO T_Config_Record (agvNo,expDealTimeUpdate,dealTime) VALUES('{0}','{1}','{2}')", SRece.agv.agvNo, SRece.dealTime, ts3.Milliseconds);
                            //DbHelperSQL.ExecuteSql(sql);
                        }

                        Thread.Sleep(20);
                    }
                }
            }
            catch (Exception Ex)
            {
                App.ExFile.MessageError("TranMultiSocket", Ex.ToString());
                //throw Ex;
            }
            finally
            {
                cSocket.Close();
            }
        }

        /// <summary>
        /// Tcp指令发送
        /// </summary>
        /// <param name="ClientSocket">自定义Socket对象</param>
        /// <returns>发送结果</returns>
        public static void Send(SocketOpt ClientSocket)
        {
            Socket s = ClientSocket.Sct;
            try
            {
                if (ClientSocket.SendData != null)
                {
                    s.Send(ClientSocket.SendData, ClientSocket.SendData.Length, 0);
                    //记录回给小车的信息
                    App.ExFile.MessageLog("Send" + ClientSocket.agv.agvNo, BitConverter.ToString(ClientSocket.SendData));
                }
                else
                {
                    s.Send(new byte[1], 1, 0);
                }
            }
            catch (Exception Ex)
            {
                throw Ex;
            }
            finally
            {
                s.Close();
            }
        }
    }
}

using System.Linq;
using System.Net.NetworkInformation;

namespace client
{
    public class Message
    {
        
        public string GetMac()
        {
           return (
                from nic in NetworkInterface.GetAllNetworkInterfaces()
                where nic.OperationalStatus == OperationalStatus.Up
                select nic.GetPhysicalAddress().ToString()
            ).FirstOrDefault();

        }
    }
}

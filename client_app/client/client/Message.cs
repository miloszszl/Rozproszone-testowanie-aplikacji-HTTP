using System.Linq;
using System.Net;
using System.Net.NetworkInformation;

namespace client
{
    public abstract class Message
    {
        public static Result Create(int elapsedMs)
        {
            //Stworzenie obiektów i wypełnienie danymi - to się wrzuci do osobnej metody
            var res = Result.Initialize();
            res.mac_address = GetMac();
            res.tests[0].pages_tests[0].download_time = elapsedMs;

            // NIE DZIAŁA! res.ipv4 = Dns.GetHostAddresses(Form1.GetAddress()).ToString();
            res.tests[0].batch[0].levels = Form1.GetLevel();
            res.tests[0].batch[0].page_address.address = Form1.GetAddress();

           // res.tests[0].pages_tests[0].page.page_connections[0].page_2.address = ;

            res.tests[0].batch[0].levels = 1;
            res.tests[0].pages_tests[0].redirection.address = "ala";
            res.tests[0].batch[0].page_address.address = "tomekk";
            //END
            return res;
        }

        private static string GetMac()
        {
           return (
                from nic in NetworkInterface.GetAllNetworkInterfaces()
                where nic.OperationalStatus == OperationalStatus.Up
                select nic.GetPhysicalAddress().ToString()
            ).FirstOrDefault();

        }
    }
}

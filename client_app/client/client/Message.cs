using System;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;

namespace client
{
    public abstract class Message
    {

        /// <summary>
        /// Tworzy obiekt Result i wypełnia podstawowymi danymi
        /// </summary>
        /// <param name="tab">Tablica zawierająca [0] - czas pobierania, [1] - wagę strony</param>
        /// <returns>Wypełniony obiekt</returns>
        
        public static Result Create(int[] tab, string address)
        {
            //Stworzenie obiektów i wypełnienie danymi 
            var res = Result.Initialize();

            res.tests[0].pages_tests[0].page.host.ipv4 = ipv4(address);
            res.ipv4 = GetLocalIPAddress();

            //level
            res.tests[0].batch[0].levels = Form1.GetLevel();
            //adres strony
            res.tests[0].batch[0].page_address.address = address;

           // res.tests[0].pages_tests[0].page.page_connections[0].page_2.address = ;

           //waga strony, czas, działanie i adres mac klienta
            res.tests[0].pages_tests[0].page.weight = tab[1];
            res.tests[0].pages_tests[0].page.address = address;
            res.tests[0].pages_tests[0].download_time = tab[0];
            if (tab[0] > 0)
            {
                res.tests[0].pages_tests[0].is_working = true;
            }
            res.mac_address = GetMac();

            // dodanie 
            res.tests[0].pages_tests[0].page.host.domain_name = address;

            
            //przekierowanie
            res.tests[0].pages_tests[0].redirection.address = null;

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

        public static string ipv4(string address)
        {

            //stworzenie URI do wyciągania adresu IP
            Uri myUri;

            myUri = new Uri(address);
            try
            {
                var ip = Dns.GetHostAddresses(myUri.Host)[0];
                return ip.ToString();
            }
            catch (Exception e)
            {
               return  null;
            }
        }

        public static string GetLocalIPAddress()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    return ip.ToString();
                }
            }
            return null;
        }
    }
}

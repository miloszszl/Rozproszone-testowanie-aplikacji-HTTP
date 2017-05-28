using System;
using System.Net;


namespace client
{
    public class WebPageDownloader
    {
        public int TestDownload(string address)
        {
            WebClient client = new WebClient();
           string htmlCode;

            var watch = System.Diagnostics.Stopwatch.StartNew();
            htmlCode = client.DownloadString(address);
            watch.Stop();

            int elapsedMs = Convert.ToInt32(watch.ElapsedMilliseconds);
            return elapsedMs;

            //Stworzenie obiektów i wypełnienie danymi - to się wrzuci do osobnej metody
            var res = Result.Initialize();
            res.tests[0].pages_tests[0].download_time = elapsedMs;

            res.ipv4 = "test1";
            
            res.tests[0].pages_tests[0].page.page_connections[0].page_2.address = "ala_ma_kota";

            res.tests[0].batch[0].levels = 1;
            res.tests[0].pages_tests[0].redirection.address = "ala";
            res.tests[0].batch[0].page_address.address = "tomekk";
            //END

            Communication.SendMessage(res);

            //Form2 f2 = new Form2();

            //test purposes
            // f2.Show(); 
            //  f2.LabelText = htmlCode;
        }
    }
}

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

            //Form2 f2 = new Form2();

            //test purposes
            // f2.Show(); 
            //  f2.LabelText = htmlCode;
        }
    }
}

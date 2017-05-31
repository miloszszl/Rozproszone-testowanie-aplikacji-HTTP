using System;
using System.Net;
using System.Text;


namespace client
{
    public class WebPageDownloader
    {
        /// <summary>
        /// zwraca czas i wagę strony
        /// </summary>
        /// <param name="address"> adres strony</param>
        public int[] TestDownload(string address)
        {
            WebClient client = new WebClient();
           string htmlCode;

            var watch = System.Diagnostics.Stopwatch.StartNew();
            htmlCode = client.DownloadString(address);
            watch.Stop();

            int elapsedMs = Convert.ToInt32(watch.ElapsedMilliseconds);
            int weight = ASCIIEncoding.Unicode.GetByteCount(htmlCode)/1024;
            int[] tab = {elapsedMs, weight};

            return tab;

            //Form2 f2 = new Form2();

            //test purposes
            // f2.Show(); 
            //  f2.LabelText = htmlCode;
        }
    }
}

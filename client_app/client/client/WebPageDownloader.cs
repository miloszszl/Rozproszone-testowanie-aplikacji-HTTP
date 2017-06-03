using System;
using System.Net;
using System.Text;
using System.Threading;
using System.Windows.Forms;


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
            try
            {
                htmlCode = client.DownloadString(address);
            }
            catch (Exception e)
            {
                var x = new Form2();
                x.Text = "Error!";
                x.LabelText = e.Message + "\n Check filed address!";
                x.Show();

                return null;
            }

            watch.Stop();

            int elapsedMs = Convert.ToInt32(watch.ElapsedMilliseconds);
            int weight = ASCIIEncoding.Unicode.GetByteCount(htmlCode)/1024;
            int[] tab = {elapsedMs, weight};

            return tab;
        }
    }
}

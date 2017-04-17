using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace client
{
    public class WebPageDownloader
    {
        public void TestDownload(String address)
        {
            WebClient client = new WebClient();
            String htmlCode;

            var watch = System.Diagnostics.Stopwatch.StartNew();
            htmlCode= client.DownloadString(address);
            watch.Stop();
            
            var elapsedMs = watch.ElapsedMilliseconds;
            Form2 f2 = new Form2();

            //test purposes
            f2.Show(); 
            f2.LabelText = htmlCode;
        }

    }
}

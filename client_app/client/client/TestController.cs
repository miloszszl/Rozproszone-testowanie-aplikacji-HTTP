using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace client
{
    public class TestController
    {
        public List<String> Addresses { get; set; }

        public TestController(List<String> addresses)
        {
            this.Addresses = addresses;
        }

        public void Test()
        {
            WebPageDownloader wbd = new WebPageDownloader();
            wbd.TestDownload("https://www.google.pl/");
        }
    }
}

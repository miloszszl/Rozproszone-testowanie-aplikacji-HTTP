using System.Net;

namespace client
{
    public class TestController
    {
        public string Address { get; set; }
        public int Levels { get; set; }

        public TestController(string address, int Levels)
        {
            this.Address = address;
            this.Levels = Levels;
        }

        public void Test()
        {
            WebPageDownloader wbd = new WebPageDownloader();
            int[] tab = wbd.TestDownload(Address);

            var res = Message.Create(tab);

            SeleniumTest Selenium = new SeleniumTest();
            res.tests[0].pages_tests[0].page.page_connections = Selenium.CheckLevels(Address, Levels);
            
            res.tests[0].pages_tests[0].page.cookies_present = Selenium.CheckCookies();

            //wywołanie destruktora
            Selenium = null;


            Communication.SendMessage(res);
        }

    }
}

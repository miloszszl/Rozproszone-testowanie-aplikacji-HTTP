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
            int elapsedTime = wbd.TestDownload(Address);
            
            SeleniumTest Selenium = new SeleniumTest();
            var x = Selenium.Test(Address, Levels);

            var res = Message.Create(elapsedTime);
            res.tests[0].pages_tests[0].page.page_connections = x;
            Communication.SendMessage(res);
        }

    }
}

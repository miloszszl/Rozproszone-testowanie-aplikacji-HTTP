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
            // WebPageDownloader wbd = new WebPageDownloader();
            // wbd.TestDownload("https://www.google.pl/");

            SeleniumTest Selenium = new SeleniumTest();
            Selenium.Test(Address, Levels);
        }

    }
}

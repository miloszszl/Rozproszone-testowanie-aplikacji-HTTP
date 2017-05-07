using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Windows.Forms;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;


namespace client
{
    public class TestController
    {
        public List<String> Addresses { get; set; }
        private IWebDriver driver;
        WebDriverWait wait;

        public TestController(List<String> addresses)
        {
            this.Addresses = addresses;
        }

        public void Test()
        {
           // WebPageDownloader wbd = new WebPageDownloader();
           // wbd.TestDownload("https://www.google.pl/");
            driver =  new ChromeDriver();
            wait = new WebDriverWait(driver, TimeSpan.FromSeconds(30));
            List<string> adr = new List<string>();
            adr.Add("www.google.pl");

            var x = new TestController(adr);

            driver.Manage().Window.Maximize();
            driver.Navigate().GoToUrl("http://www.wp.pl/");
            WaitForReady();

            var buttons = driver.FindElements(By.XPath("//button"));
            var a = driver.FindElements(By.XPath("//a"));
            var input = driver.FindElements(By.XPath("//input"));

            Check(buttons);
            Check(a);
            Check(input);

        }

        public void WaitForReady()
        {   
            while ((long)((IJavaScriptExecutor) driver).ExecuteScript("return jQuery.active") != 0)
            {
                Thread.Sleep(50);
            }
        }

        private void Check(IReadOnlyCollection<IWebElement> collection )
        {
                try
                {
                    var tmp = driver.Url;
                    foreach (IWebElement button in collection)
                    {
                        while (!button.Enabled)
                            Thread.Sleep(50);
                        if (button.Displayed)
                        {
                            ((IJavaScriptExecutor)driver).ExecuteScript("arguments[0].scrollIntoView(true);", button);
                            button.Click();
                            if (driver.Url != tmp)
                                driver.Navigate().Back();
                            WaitForReady();
                        }
                    }
                }
                catch (Exception e)
                {
                    //TODO: ZALOGOWANIE W TABLICY BŁĘDU
                }
        }
    }
}

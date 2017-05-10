using System;
using System.Collections.Generic;
using System.Threading;
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

            driver = new ChromeDriver();
            wait = new WebDriverWait(driver, TimeSpan.FromSeconds(60));

            //##########################################
            List<string> adr = new List<string>();
            adr.Add("http://www.google.pl");
            var x = new TestController(adr);
            //##########################################

            try
            {
                driver.Manage().Window.Maximize();
                driver.Navigate().GoToUrl("http://twojabiblia.pl/");
            }
            catch(Exception e)
            { 
                //Błąd drivera, zamykam przeglądarkę
                driver.Quit();
                driver.Close();
            }
;

            IReadOnlyCollection<IWebElement> buttons = null ;
            IReadOnlyCollection<IWebElement> a = null;
            IReadOnlyCollection<IWebElement> input = null;
            
            // Pobieranie wszystkich elementow o tagach: button, a oraz input.
            try
            {
                buttons = driver.FindElements(By.XPath("//button"));
                a = driver.FindElements(By.XPath("//a"));
                input = driver.FindElements(By.XPath("//input"));
            }
            catch (Exception)
            {
                //Jeśli strona wczytuje się dłużej jak 60 sekund - jakieś pomysły?
            }
            wait = new WebDriverWait(driver, TimeSpan.FromSeconds(5));
            
            //Metody zwracają słowniki z wynikami. Można je przetwarzać w dowolny sposób. 
            Check(buttons);
            Check(a);
            Check(input);

            //Zamykam driver i przeglądarkę po testach
            driver.Close();
            driver.Quit();
            
        }

        /// <summary>
        /// Metoda sprawdzająca czy jquery przestało działać na stronie. Do omówienia czy przydatna.
        /// </summary>
        private void WaitForReady()
        {
            while ((long) ((IJavaScriptExecutor) driver).ExecuteScript("return jQuery.active") != 0)
            {
                Thread.Sleep(50);
            }
        }

        /// <summary>
        /// Metoda sprawdzająca czy elementy są klikalne.
        /// </summary>
        /// <param name="collection"></param>
        private Dictionary<string,string> Check(IReadOnlyCollection<IWebElement> collection)
        {
            Dictionary<string, string> result = new Dictionary<string, string>();
            if (collection == null)
                return result;

            foreach (IWebElement button in collection)
            {
                try
                {
                    while (!button.Enabled)
                        Thread.Sleep(50);
                    if (button.Displayed)
                    {
                        try
                        {
                            ((IJavaScriptExecutor) driver).ExecuteScript("arguments[0].scrollIntoView(true);", button);
                        }
                        catch (Exception)
                        {
                            //Do elementu nie można scrollować.
                        }

                        if (wait.Until(ExpectedConditions.ElementToBeClickable(button)) == null)
                        {
                            result.Add(button.Text, "nie działa");
                        }
                        else
                        {
                            result.Add(button.Text, "działa");
                        }
                    }
                }

                catch (Exception e)
                {
                    //TODO obsługa błędu?
                }
            }
            return result;
        }
    }
}

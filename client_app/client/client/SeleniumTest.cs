using System;
using System.Collections.Generic;
using System.Threading;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;

namespace client
{
    public class SeleniumTest
    {
        private IWebDriver driver;
        WebDriverWait wait;
        private List<page_connections> ResultLink = new List<page_connections>();
        private List<string> Visited = new List<string>();

        public SeleniumTest(string Adress)
        {
            try
            {
                driver = new ChromeDriver();
                wait = new WebDriverWait(driver, TimeSpan.FromSeconds(60));
                driver.Manage().Window.Maximize();
                driver.Navigate().GoToUrl(Adress);
            }
            catch (Exception e)
            {
                //Błąd drivera, zamykam przeglądarkę
                driver.Quit();
                driver.Close();
            }
        }

        public void Close()
        {
            //Zamykam driver i przeglądarkę po testach
            driver.Close();
            driver.Quit();
        }

        /// <summary>
        /// Sprawdzanie poziomu zagłębień
        /// </summary>
        /// <param name="Adress">Adres strony</param>
        /// <param name="Levels">Poziom</param>
        /// <returns></returns>
        public List<page_connections> CheckLevels(int Levels)
        {

            //sprawdzanie zagnieżdzeń
            CheckLevelsP(Levels);

            return ResultLink;
        }


        public List<buttons> CheckButton()
        {

            IReadOnlyCollection<IWebElement> buttons = null;
            IReadOnlyCollection<IWebElement> input = null;

            // Pobieranie wszystkich elementow o tagach: button, a oraz input.
            try
            {
                buttons = driver.FindElements(By.XPath("//button"));
                input = driver.FindElements(By.XPath("//input"));
            }
            catch (Exception)
            {
               driver.Navigate().Refresh();
            }

            wait = new WebDriverWait(driver, TimeSpan.FromSeconds(5));

            //Metody zwracają słowniki z wynikami. Można je przetwarzać w dowolny sposób. 
            var buttonsChecked = Check(buttons);
            var inputChecked = Check(input);

            List<buttons> result = new List<buttons>();
            foreach (var element in buttonsChecked)
            {
                var x = new buttons();
                x.locator = element.Key;
                var y = new t_p_b();
                y.is_working = element.Value;

                x.t_p_b.Add(y);
                result.Add(x);
            }

            foreach (var element in inputChecked)
            {
                var x = new buttons();
                x.locator = element.Key;
                var y = new t_p_b();
                y.is_working = element.Value;

                x.t_p_b.Add(y);
                result.Add(x);
            }

            return result;
        }

        /// <summary>
        /// Sprawdzenie używania ciasteczek
        /// </summary>
        /// <returns></returns>
        public bool CheckCookies()
        {
            //sprawdzenie używania ciasteczek
            var cookies = driver.Manage().Cookies.AllCookies.Count;
            if (cookies != 0 && cookies != null)
                return true;
            return false;
        }


        /// <summary>
        /// Metoda sprawdzająca czy elementy są klikalne.
        /// </summary>
        /// <param name="collection"></param>
        /// <returns>Lokalizacja i czy działa</returns>
        private Dictionary<string, bool> Check(IReadOnlyCollection<IWebElement> collection)
        {
            wait = new WebDriverWait(driver, TimeSpan.FromSeconds(60));
            Dictionary<string, bool> result = new Dictionary<string, bool>();
            if (collection == null)
                return result;

            foreach (IWebElement button in collection)
            {
                try
                {
                    int loop = 0;
                    while (!button.Enabled && loop < 10)
                    {
                        Thread.Sleep(1000);
                        loop++;
                    }
                    if (loop < 10)
                    {
                        if (button.Displayed)
                        {
                            try
                            {
                                ((IJavaScriptExecutor) driver).ExecuteScript("arguments[0].scrollIntoView(true);",
                                    button);
                            }
                            catch (Exception)
                            {
                                //Do elementu nie można scrollować.
                            }

                            if (wait.Until(ExpectedConditions.ElementToBeClickable(button)) == null)
                            {
                                result.Add("Tag: " + button.TagName + " Text: " + button.Text + button.Location, false);
                            }
                            else
                            {
                                result.Add("Tag: " + button.TagName + " Text: " + button.Text + button.Location, true);
                            }
                        }
                    }
                }

                catch (Exception e)
                {
                   //Pominięcie elementu
                }
            }
            return result;
        }

        private List<string> RemoveRedundantLinks(List<string> li)
        {
            //usuwanie wszystkich zbędnych linków 
            Predicate<string> pre = delegate (string url) { return url == driver.Url; };
            li.RemoveAll(pre);
            Predicate<string> prej = delegate (string url) { return url == null; };
            li.RemoveAll(prej);
            prej = delegate (string url) { return url.Contains("javascript"); };
            li.RemoveAll(prej);
            prej = delegate (string url) { return url.Contains("None"); };
            li.RemoveAll(prej);
            return li;
        }

        private void CheckLevelsP(int levels)
        {
            IReadOnlyCollection<IWebElement> links = driver.FindElements(By.XPath("//a"));

            var MainPageLinks = new List<string>();
            var SubPageLinks = new List<string>();
            var CurrentURL = driver.Url;
            int CurrentLevel = 0;
            try
            {
                //zbieranie wszystkich linków ze strony głównej (tag <a>)
                MainPageLinks = GetLinks(links);
                //usuwanie wszystkich zbędnych linków 
                MainPageLinks = RemoveRedundantLinks(MainPageLinks);
                //dodanie linków do result
                AddLink(MainPageLinks);

                //dla kazdego linku na stronie glownej
                for (int i = MainPageLinks.Count - 1; i > 0; i--)
                {
                    CurrentLevel = 1;
                    string link = MainPageLinks[i];

                    //sprawdzenie czy juz tu nie bylismy
                    if (Visited.Contains(link))
                        continue;

                    if (CurrentLevel < levels)
                    {
                        driver.Url = link;
                        CurrentLevel++;
                        Visited.Add(link);

                        ////usunięcie wszystkich stron z MainPageLinks kierujących pod ten link - zle
                        //Predicate<string> preAdr = delegate(string url) { return url == link; };
                        //MainPageLinks.RemoveAll(preAdr);

                        //znalezienie linków na stronie
                        links = driver.FindElements(By.XPath("//a"));
                        SubPageLinks = GetLinks(links);

                        AddLink(SubPageLinks); //zapis linków z 1 poziomu (0 - strona główna)

                        //sprawdzenie czy wchodzimy jeszcze głębiej
                        if (CurrentLevel < levels)
                        {
                            SubPageLinks = DeleteVisitedLink(SubPageLinks);
                            if (SubPageLinks != null)
                            {
                                driver.Url = SubPageLinks[0];
                                CurrentLevel++;
                                Visited.Add(driver.Url);
                                TestOnePage(CurrentLevel, levels);
                            }
                        }
                    }

                    else
                    {
                        throw new Exception("Level nie może być mniejszy bądź równy 0");
                    }
                }
            }
            catch (Exception e)
            {
                Thread t2 = new Thread(delegate ()
                {
                    Form2 x = new Form2();
                    x.Text = "Błąd!";
                    x.LabelText = e.Message;
                    x.Show();
                });
                t2.Start();
            }
        }

        /// <summary>
        /// Zwrócenie linków z IWebElementów
        /// </summary>
        /// <param name="page"> Lista adresów</param>
        /// <returns></returns>
        private List<string> GetLinks(IReadOnlyCollection<IWebElement> page)
        {
            var hrefList = new List<string>();
            string hrefLink;

            foreach (var href in page)
            {
                hrefLink = href.GetAttribute("href");
                hrefList.Add(hrefLink);
            }

            return hrefList;
        }

        /// <summary>
        /// Dodanie linków z aktualnej strony do tablicy ResultLink
        /// </summary>
        /// <param name="lvl"></param>
        private void AddLink(List<string> links)
        {
            foreach (var ln in links)
            {
                var x = new page_connections();
                x.page_2.address = ln;
                ResultLink.Add(x);
            }
        }


        private void TestOnePage(int curlevel, int level, bool Add = true)
        {
            //ściągnięcie linków ze strony
            IReadOnlyCollection<IWebElement> links = driver.FindElements(By.XPath("//a"));
            var ln = GetLinks(links);
            if (Add)
                AddLink(ln);

            //usunięcie już odwiedzonych
            ln = DeleteVisitedLink(ln);
            if (ln == null)
            {
                driver.Navigate().Back();
                driver.Navigate().Back();
                curlevel -= 2;
                if (curlevel < 0)
                    return;
                TestOnePage(curlevel, level, false);
            }
            if (!Add)
            {
                driver.Url = ln[0];
                curlevel++;
                Visited.Add(driver.Url);
            }

            if (curlevel == level)
            {
                driver.Navigate().Back();
                driver.Navigate().Back();
                curlevel -= 2;
                if (curlevel < 0)
                    return;
                TestOnePage(curlevel, level, false);
            }
            else
            {
                try
                {
                    driver.Url = ln[0];
                }
                catch (Exception e)
                {
                }
                Visited.Add(ln[0]);
                curlevel++;
                TestOnePage(curlevel, level);
            }
        }


        private List<string> DeleteVisitedLink(List<string> lista)
        {
            for (int i = lista.Count - 1; i > 0; i--)
            {
                foreach (var v in Visited)
                {
                    if (v == lista[i])
                    {
                        lista.Remove(lista[i]);
                    }
                }
            }
            return lista;
        }
    }
}

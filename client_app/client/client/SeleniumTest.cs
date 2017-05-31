﻿using System;
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

        public SeleniumTest()
        {
        }

        ~SeleniumTest()
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
        public List<page_connections> CheckLevels(string Adress, int Levels)
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
                return null;
            }

            //sprawdzanie zagnieżdzeń
            CheckLevels(Levels);


            return ResultLink;
        }


        public List<string> CheckButton()
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
                //Jeśli strona wczytuje się dłużej jak 60 sekund - jakieś pomysły?
            }
            wait = new WebDriverWait(driver, TimeSpan.FromSeconds(5));
            //Metody zwracają słowniki z wynikami. Można je przetwarzać w dowolny sposób. 
            var buttonsChecked = Check(buttons);
            var inputChecked = Check(input);

            return null;
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
        private Dictionary<string, string> Check(IReadOnlyCollection<IWebElement> collection)
        {
           wait = new WebDriverWait(driver, TimeSpan.FromSeconds(60));
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


        private void CheckLevels(int levels)
        {
            IReadOnlyCollection<IWebElement> links = driver.FindElements(By.XPath("//a"));

            var PageLinks = new List<string>();
            var SubPageLinks = new List<string>();
            var PageUrl = driver.Url;
            int currentLevel = 0;
            try
            {
                //zbieranie wszystkich linków ze strony głównej (tag <a>)
                PageLinks = GetLinks(links);

                //usuwanie wszystkich linków kierujących do strony głównej
                Predicate<string> pre = delegate(string url) { return url == PageUrl; };
                PageLinks.RemoveAll(pre);
                Predicate<string> prej = delegate(string url) { return url == null; };
                PageLinks.RemoveAll(prej);
                prej = delegate(string url) { return url.Contains("javascript"); };
                PageLinks.RemoveAll(prej);


                AddLink(PageLinks);

                foreach (string link in PageLinks)
                {
                    currentLevel = 0;
                    if (currentLevel < levels)
                    {
                        driver.Url = link;
                        currentLevel++;
                        Visited.Add(link);

                        //usunięcie wszystkich stron z PageLinks kierujących pod ten link
                        Predicate<string> preAdr = delegate(string url) { return url == link; };
                        PageLinks.RemoveAll(preAdr);

                        links = driver.FindElements(By.XPath("//a"));
                        SubPageLinks = GetLinks(links);

                        AddLink(SubPageLinks); //zapis linków z 1 poziomu (0 - strona główna)

                        //sprawdzenie czy wchodzimy jeszcze głębiej
                        if (currentLevel < levels)
                        {
                            DeleteVisitedLink(SubPageLinks);
                            if (SubPageLinks != null)
                            {
                                driver.Url = SubPageLinks[0];
                                currentLevel++;
                                Visited.Add(driver.Url);
                                TestOnePage(currentLevel, levels);
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
                driver.Url = ln[0];
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

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Windows.Forms;
using OpenQA.Selenium.Remote;

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
            var watch = System.Diagnostics.Stopwatch.StartNew();

            WebPageDownloader wbd = new WebPageDownloader();

            int[] tab = null;
            try
            {
                tab = wbd.TestDownload(Address);
            }
            catch (Exception e)
            {
                //sprawdzenie poprawności adresu
                if (!CheckAdress.CheckAdressMethod(Address))
                {
                    Address = CheckAdress.CorrectAdress(Address);
                }
               
            }
            try
            {
                tab = wbd.TestDownload(Address);
            }
            catch (Exception e)
            {
                var x = new Form2();
                x.Text = "Error!";
                x.LabelText = e.Message + "\n Check filed address!";
                x.Show();
            }
          
            if (tab == null)
            {
                return;
            }

            var res = Message.Create(tab,Address);

            // zwrócenie response code ze strony 
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(res.tests[0].batch[0].page_address.address);
            request.Method = "GET";
            int statusCode;
            using (var response = request.GetResponse())
            {
                statusCode = Convert.ToInt32(((HttpWebResponse)response).StatusCode);
            }

            res.tests[0].pages_tests[0].response_code = statusCode;

            if (statusCode < 200 || statusCode > 300)
            {
                Communication.SendMessage(res);
                return;
            }
            int WeightAllPages = tab[1];
            int AmountOfButtons=0;
            int AmountOfPages = 1;
            SeleniumTest Selenium = new SeleniumTest(Address);
            try
            {
                res.tests[0].pages_tests[0].page.cookies_present = Selenium.CheckCookies();

                res.tests[0].pages_tests[0].page.buttons = Selenium.CheckButton();
                AmountOfButtons = res.tests[0].pages_tests[0].page.buttons.Count;

                var z = Selenium.CheckLevels(Levels);
                var y = z[0];
                foreach (var d in z)
                {
                    if(d != null)
                    foreach (var x in d.page.page_connections)
                    {
                        if (d.page.address != null)
                        {
                            d.page.address = d.page.address.Replace("\"", "");
                        }
                        if (x != null && x.page_2.address !=null)
                        {
                            x.page_2.address = x.page_2.address.Replace("\"", "");
                            x.page_2.address = x.page_2.address.Replace("]", "");
                            x.page_2.address = x.page_2.address.Replace("}", "");
                        }

                    }
                }
                res.tests[0].pages_tests[0].page.page_connections = y.page.page_connections;
                z.Remove(y);
                int code;
                HttpWebRequest req;
                request.Method = "GET";
                for (int i = z.Count - 1; i > 0; i--)
                {
                   string u;
                    try
                    {
                        u = z[i].page.address.ToLower();

                    }
                    catch (Exception e)
                    {
                        z.Remove(z[i]);
                        continue;
                    }                 
                    if (u == null || u.Contains("none")  || u.Contains("mailto") || u.Contains("javascript:"))
                        z.Remove(z[i]);
                }
                foreach (var x in z)
                {
                    try
                    {
                        req = (HttpWebRequest)WebRequest.Create(x.page.address);
                        using (var resp = req.GetResponse())
                        {
                            code = Convert.ToInt32(((HttpWebResponse)resp).StatusCode);
                        }
                    }
                    catch (Exception e)
                    {
                        x.is_working = false;
                        continue;
                    }
                    
                    if (code >= 200 && code < 300)
                    {
                        x.is_working = true;
                    }
                    else
                    {
                        x.is_working = false;
                        continue;
                    }
                    x.response_code = code;

                    x.page.buttons = Selenium.CheckButton(x.page.address);
                    x.page.cookies_present = Selenium.CheckCookies(x.page.address);
                    tab =  wbd.TestDownload(x.page.address);
                    x.page.weight = tab[1];
                    x.response_code = code;
                    x.page.host.ipv4 = Message.ipv4(x.page.address);
                    Uri myUri = new Uri(x.page.address);
                    string host = myUri.Host;
                    x.page.host.domain_name = host;
                    x.download_time = tab[0];
                    WeightAllPages += tab[1];
                    AmountOfButtons += x.page.buttons.Count;
                    AmountOfPages++;
                    x.page.host.domain_name = x.page.address;
                    x.page.host.ipv4 = Message.ipv4(x.page.address);
                    x.page.pictures_amount = Selenium.TestAmountPictures(x.page.address);
                    res.tests[0].total_pictures_amount += x.page.pictures_amount;
                    res.tests[0].pages_tests.Add(x);
                }

                res.tests[0].tested_pages_amount = AmountOfPages;
                res.tests[0].tested_buttons_amount = AmountOfButtons;
                res.tests[0].total_weight = WeightAllPages;
                

            }
            catch (Exception e)
            {
                Form2 x = new Form2();
                x.Text = "Error!";
                x.LabelText = e.Message + "\n Selenium test failed. Please contact with administrator." +
                              "\n \n Test result not sended.";
                x.Show();
                return;
            }

                //zakończenie testów Selenium
                Selenium.Close();
                watch.Stop();
                int elapsedSec = Convert.ToInt32(watch.ElapsedMilliseconds)/1000;
                res.tests[0].total_time = elapsedSec;
                
                //res.tests[0].total_weight_w_pictures =
            
            try
            {
                if (Communication.SendMessage(res))
                {
                    Form2 x = new Form2();
                    x.Text = "Success!";
                    x.LabelText = "Your test result succesfully sended \nResults:\n";
                    var avgResult = Communication.ReceiveMessage(Address);
                    string[] row = { "Average download time", avgResult[0].ToString() + " ms" };
                    var listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Minimum download time";
                    row[1] = avgResult[1].ToString() + " ms";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Maximum download time";
                    row[1] = avgResult[2].ToString() + " ms";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Global working percentage";
                    row[1] = avgResult[3].ToString() + " %";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Last month working percentage";
                    row[1] = avgResult[4].ToString() + " %";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Weight";
                    row[1] = res.tests[0].pages_tests[0].page.weight.ToString() + " kB";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Your download time";
                    row[1] = res.tests[0].pages_tests[0].download_time.ToString() + " ms";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Test time";
                    row[1] = elapsedSec.ToString() + "sec";
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "All tested pages";
                    row[1] = res.tests[0].pages_tests.Count.ToString();
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Weight of all pages";
                    row[1] = WeightAllPages.ToString();
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);

                    row[0] = "Amount of buttons";
                    row[1] = AmountOfButtons.ToString();
                    listViewItem = new ListViewItem(row);
                    x.listView.Items.Add(listViewItem);



                    x.listView.Visible = true;
                    
                    x.Show();
                    
                }
            }
            catch (Exception e)
            {
                var x = new Form2();
                x.Text = "Error!";
                x.LabelText = "Sending result failed! \n Try one more time";
                x.Show();
            }
        }


    }
}

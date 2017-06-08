using System;
using System.Collections.Generic;
using System.Net;
using System.Windows.Forms;

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

            if (tab == null)
            {
                return;
            }

            var res = Message.Create(tab);

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

            SeleniumTest Selenium = new SeleniumTest(Address);
            try
            {
                res.tests[0].pages_tests[0].page.cookies_present = Selenium.CheckCookies();

                res.tests[0].pages_tests[0].page.buttons = Selenium.CheckButton();
               
                var z = Selenium.CheckLevels(Levels);
                var y = z[0];
                res.tests[0].pages_tests[0].page.page_connections = y.page.page_connections;
                z.Remove(y);
                foreach (var x in z)
                {
                    x.is_working = true;
                    res.tests[0].pages_tests.Add(x);
                }
                
            }
            catch (Exception e)
            {
                Form2 x = new Form2();
                x.Text = "Error!";
                x.LabelText = e.Message + "\n Selenium test failed. Please contact with administrator." +
                              "\n \n Test result not sended.";
                return;
            }

                //zakończenie testów Selenium
                Selenium.Close();

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

                    x.listView.Visible = true;
                    

                    /* " Average download time: " + avgResult[0] + " ms" +
                     "\n Minimum download time: " + avgResult[1]+ " ms" +
                     "\n Maximum download time: " + avgResult[2]+ " ms" +
                     "\n Global working percentage: " + avgResult[3] + "%" +
                     "\n Last month working percentage: " + avgResult[4] + "%" +
                     "\n Weight: " + res.tests[0].pages_tests[0].page.weight + " KB " +
                     "\n Your download time: " + res.tests[0].pages_tests[0].download_time + " ms";*/

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

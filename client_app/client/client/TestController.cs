﻿using System;
using System.Collections.Generic;
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
            var avgResult = Communication.ReceiveMessage(Address);

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
                    x.LabelText = "Your test result succesfully sended \n" +
                                  "Average download time: " + avgResult[0] +
                                  "\n Minimum download time: " + avgResult[1] +
                                  "\n Maximum download time: " + avgResult[2] +
                                  "\n Global working percentage: " + avgResult[3] +
                                  "\n Last month working percentage: " + avgResult[4];

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

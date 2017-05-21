using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Windows.Forms;
using Newtonsoft.Json;

namespace client
{
    public class WebPageDownloader
    {
        public void TestDownload(String address)
        {
            WebClient client = new WebClient();
            String htmlCode;

            var watch = System.Diagnostics.Stopwatch.StartNew();
            htmlCode = client.DownloadString(address);
            watch.Stop();

            //Stworzenie obiektów i wypełnienie danymi - to się wrzuci do osobnej metody
            int elapsedMs = Convert.ToInt32(watch.ElapsedMilliseconds);
            var res = new Result();
            var y = new tests();
            res.tests.Add(y);
            var z = new pages_tests();
            res.tests[0].pages_tests.Add(z);
            res.tests[0].pages_tests[0].download_time = elapsedMs;
            res.ipv4 = "test1";
            var xyz = new page_connections();
            xyz.page_2.address = "ala_ma_kota";
            res.tests[0].pages_tests[0].page.page_connections.Add(xyz);
            var x = new batch();
            res.tests[0].batch.Add(x);
            DateTime theDate = DateTime.Now;
            theDate.ToString("yyyy-MM-dd H:mm:ss");
            res.tests[0].date = theDate.ToString();
            res.tests[0].batch[0].levels = 1;
            res.tests[0].pages_tests[0].redirection.address = "ala";
            res.tests[0].batch[0].page_address.address = "tomekk";
            //END

            //Serializacja do JSONA
            var data = JsonConvert.SerializeObject(res);

            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://metlando.pythonanywhere.com/api/users/");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "POST";
          
            //Wysyłanie JSONA do zdalnego serwera
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                streamWriter.Write(data);
                streamWriter.Flush();
                streamWriter.Close();
            }

            //Oczekiwanie na odpowiedź serwera
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                var result = streamReader.ReadToEnd();
            }
            //Form2 f2 = new Form2();

            //test purposes
            // f2.Show(); 
            //  f2.LabelText = htmlCode;
        }
    }
}

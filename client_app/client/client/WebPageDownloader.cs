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

            int elapsedMs = Convert.ToInt32(watch.ElapsedMilliseconds);
            var res = new Result();
            res.tests.pages_tests.download_time = elapsedMs;
            res.ipv4 = "bleeee";
            res.tests.batch.levels = 1;
            res.tests.batch.page_address.address = "tomekk";
            var data = JsonConvert.SerializeObject(res);

            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://127.0.0.1:8000/testing/api/users");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "POST";
          
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                streamWriter.Write(data);
                streamWriter.Flush();
                streamWriter.Close();
            }

            //var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            //using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            //{
            //    var result = streamReader.ReadToEnd();
            //}
            //Form2 f2 = new Form2();

            //test purposes
            // f2.Show(); 
            //  f2.LabelText = htmlCode;
        }
    }
}

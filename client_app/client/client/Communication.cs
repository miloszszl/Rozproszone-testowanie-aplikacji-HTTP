using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace client
{
    public static class Communication
    {
        public static bool SendMessage(Result obj)
        {
            //utworzenie sekretnego klucza
            var sha256 = SHA256.Create();
            string haslo = obj.mac_address + "trochegruzu*74" + obj.ipv4 + "posolecietroche@11";
            var bytes = Encoding.UTF8.GetBytes(haslo);
            var hash = sha256.ComputeHash(bytes);

            obj.secret.key = GetStringFromHash(hash).ToLower();
            
            //Serializacja do JSONA
                var data = JsonConvert.SerializeObject(obj);

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

            string result;
            //Oczekiwanie na odpowiedź serwera
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                result = streamReader.ReadToEnd();
            }
            
            var ans = (JToken)JsonConvert.DeserializeObject(result);
            var answ = ans.SelectToken("answer").ToString();

            if(answ.Contains("ok"))
                return true;
            return false;
        }

        public static string[] ReceiveMessage(string address)
        {
            address = address.Replace("/", "|");
            address = address.Replace(".", "^");
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://metlando.pythonanywhere.com/api/page_for_client/"+  address); //Musi zwracać wszystkie wyniki dla usera
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "GET";

            string result;
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                result = streamReader.ReadToEnd();
            }
            //rzutowanie JSONa na tablicę stringów
            var x = (JToken)(JArray)JsonConvert.DeserializeObject(result);
            var z = x.First;
            string[] tab = new string[5];
            tab[0] = z.SelectToken("avg_download_time").ToString();
            tab[1] = z.SelectToken("min_download_time").ToString();
            tab[2] = z.SelectToken("max_download_time").ToString();
            tab[3] = z.SelectToken("global_working_percentage").ToString();
            tab[4] = z.SelectToken("last_month_working_percentage").ToString();
            
            return tab;
        }

        private static string GetStringFromHash(byte[] hash)
        {
            var result = new StringBuilder();
            for (var i = 0; i < hash.Length; i++)
                result.Append(hash[i].ToString("X2"));
            return result.ToString();
        }

    }
}

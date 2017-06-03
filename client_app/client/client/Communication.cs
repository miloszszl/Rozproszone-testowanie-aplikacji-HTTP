using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
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

        public static Dictionary<string,string> ReceiveMessage()
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://metlando.pythonanywhere.com/api/page_for_client/"); //Musi zwracać wszystkie wyniki dla usera
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "POST";

            string result;
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                result = streamReader.ReadToEnd();
            }
            //rzutowanie JSONa na tablicę stringów
            return (Dictionary<string, string>)JsonConvert.DeserializeObject(result);
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

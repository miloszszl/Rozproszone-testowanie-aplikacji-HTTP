using System.Collections.Generic;
using System.IO;
using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace client
{
    public static class Communication
    {
        public static bool SendMessage(Result obj)
        {
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
            var rec = (Dictionary<string, string>)JsonConvert.DeserializeObject(result);
            return rec; 
        }
    }
}

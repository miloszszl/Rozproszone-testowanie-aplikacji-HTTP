using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace client
{
    public  abstract class CheckAdress
    {
        public static bool CheckAdressMethod(string adr)
        {
            if (adr.StartsWith("http://www.") || adr.StartsWith("https://www."))
                return true;
            if (isIP(adr))
                return true;
            return false;
        }

        public static string CorrectAdress(string adr)
        {
            if (adr.StartsWith("www"))
                return "http://" + adr;
            if (adr.StartsWith("http://") || adr.StartsWith("https://"))
                return adr.Insert(7, "www.");
            return "http://www." + adr;
        }

        private static bool isIP(string adr)
        {
            if (String.IsNullOrWhiteSpace(adr))
            {
                return false;
            }

            string[] splitValues = adr.Split('.');
            if (splitValues.Length != 4)
            {
                return false;
            }

            byte tempForParsing;
            return splitValues.All(r => byte.TryParse(r, out tempForParsing));
        }
    }
}

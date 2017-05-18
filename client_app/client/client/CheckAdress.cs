using System;

namespace client
{
    public  abstract class CheckAdress
    {
        public static bool CheckAdressMethod(string adr)
        {
            if (adr.StartsWith("http://www."))
                return true;
            if (adr.StartsWith("https://www."))
                return true;
            return false;
        }

        public static int CorrectLevel(double level)
        {
            if (level <= 0)
            {
                //TODO: OBSŁUGA BŁĘDU
            }
            return Convert.ToInt32(level);
        }

        public static string CorrectAdress(string adr)
        {
            if (adr.StartsWith("www"))
                return "http://" + adr;
            return "http://www." + adr;
        }
    }
}

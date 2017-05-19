using System.Collections.Generic;

namespace client
{
    public class Result
    {
        public string ipv4 { get; set; }
        public int transfer_speed { get; set; }
        public string mac_address { get; set; }

        public List<tests> tests;

        public Result()
        {
            this.tests = new List<tests>();
        }
    }
}

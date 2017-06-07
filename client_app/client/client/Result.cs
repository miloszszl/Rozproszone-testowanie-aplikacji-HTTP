using System;
using System.Collections.Generic;

namespace client
{
    public class Result
    {
        public string ipv4 { get; set; }
        public int transfer_speed { get; set; }
        public string mac_address { get; set; }
        public secret secret;
        public List<tests> tests;

        private Result()
        {
            this.tests = new List<tests>();
            this.secret = new secret();
        }


        /// <summary>
        /// Przygotowanie obiektu Result (dodanie aktualnej daty)
        /// </summary>
        /// <returns></returns>
        public static Result Initialize()
        {
            var res = new Result();
            var y = new tests();
            var z = new pages_tests();
            var x = new batch();
            var xyz = new page_connections();
            var yxz = new secret();

            res.tests.Add(y);
            res.tests[0].pages_tests.Add(z);
            res.tests[0].pages_tests[0].page.page_connections.Add(xyz);
            res.tests[0].batch.Add(x);

            DateTime theDate = DateTime.Now;
            //theDate.ToString("yyyy-MM-dd HH:mm");
            //res.tests[0].date = theDate.ToString();
            res.tests[0].date = theDate.ToString("yyyy-MM-dd HH:mm");

            return res;
        }
    }

    public class secret
    {
        public string key { get; set; }
    }
}

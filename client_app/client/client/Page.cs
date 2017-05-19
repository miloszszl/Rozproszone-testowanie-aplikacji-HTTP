using System.Collections.Generic;

namespace client
{
    public class page
    {
        public string address { get; set; }
        public int weight  {get; set; }
        public string encoding { get; set; }
        public bool cookies_present { get; set; }
        public int avg_download_time { get; set; }
        public double global_working_percentage { get; set; }
        public double last_month_working_percentage { get; set; }
        public bool force_test { get; set; }
        public int weight_w_pictures { get; set; }
        public host host;
        public List<page_connections> page_connections;
        public List<buttons> buttons;

        public page()
        {
            this.host = new host();
            this.page_connections = new List<page_connections>();
        }
    }

    public class host
    {
        public string domain_name { get; set; }
        public string ipv4 { get; set; }
    }

    public class page_connections
    {
        public page_2 page_2;

        public page_connections()
        {
            this.page_2 = new page_2();
        }
    }

    public class page_2
    {
        public string address { get; set; }
    }

    public class buttons
    {
        public string locator { get; set; }
        public double global_working_percentage { get; set; }
        public double last_month_working_percentage { get; set; }
        public t_p_b t_p_b;

        public buttons()
        {
            this.t_p_b = new t_p_b();
        }
    }

    public class t_p_b
    {
        public bool is_working { get; set; }
    }

}

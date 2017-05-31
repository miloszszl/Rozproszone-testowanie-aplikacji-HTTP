namespace client
{
    public class pages_tests
    {
        public bool is_working { get; set; }
        public int response_code { get; set; }
        public int download_time { get; set; }
        public page page;
        public redirection redirection { get; set; }

        public pages_tests()
        {
            this.page = new page();
            this.redirection = new redirection();
        }
    }

    public class redirection
    {
        public string address { get; set; }
    }
}

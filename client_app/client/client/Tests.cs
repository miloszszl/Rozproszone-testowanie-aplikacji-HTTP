namespace client
{
    public class tests
    {
        public string date { get; set; }
        public batch batch;
        public pages_tests pages_tests;

        public tests()
        {
            this.pages_tests = new pages_tests();
            this.batch = new batch();
        }
    }
}

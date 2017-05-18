namespace client
{
    public class Result
    {
        public string IPv4 { get; set; }
        public tests tests;

        public Result()
        {
            this.tests = new tests();
        }
    }
}

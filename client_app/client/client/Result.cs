namespace client
{
    public class Result
    {
        public string ipv4 { get; set; }
        public string transfer_speed { get; set; }
        public string mac_address { get; set; }

        public tests tests;

        public Result()
        {
            this.tests = new tests();
        }
    }
}

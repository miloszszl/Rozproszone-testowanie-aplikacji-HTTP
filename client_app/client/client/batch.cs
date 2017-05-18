namespace client
{
    public class batch
    {
        public int levels { get; set; }
        public page_address page_address;

        public batch()
        {
            this.page_address = new page_address();
        }
    }

    public class page_address
    {
        public string address { get; set; }
    }
}

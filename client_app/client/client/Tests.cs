﻿using System;
using System.Collections.Generic;

namespace client
{
    public class tests
    {
        public string date { get; set; }
        public int total_time { get; set; }
        public int total_weight { get; set; }
        public int total_weight_w_pictures { get; set; }
        public int tested_pages_amount { get; set; }
        public int tested_buttons_amount { get; set; }
        public int total_pictures_amount { get; set; }

        public List<batch> batch;
        public List<pages_tests> pages_tests;

        public tests()
        {
            this.pages_tests = new List<pages_tests>();
            this.batch = new List<batch>();
        }
    }
}

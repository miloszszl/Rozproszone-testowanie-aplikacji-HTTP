﻿using System;
using System.Collections.Generic;

namespace client
{
    public class tests
    {
        public string date { get; set; }
        public List<batch> batch;
        public List<pages_tests> pages_tests;

        public tests()
        {
            this.pages_tests = new List<pages_tests>();
            this.batch = new List<batch>();
        }
    }
}

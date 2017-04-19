using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace client
{
    public partial class Form1 : Form
    {
        int top = 30;
        int left = 25;
        int distance_y = 5;
        int distance_x = 20;
        int limit = 10;
        int counter = 0;

        bool test_clicked = false;

        Dictionary<TextBox, TextBox> t_dict = new Dictionary<TextBox, TextBox>();

        private List<String> GetAddresses()
        {
            List<String> a = new List<String>();
            foreach (var x in t_dict)
            {
                a.Add(x.Key.Text);
            }
            return a;
        }

        private Dictionary<TextBox, TextBox> GetAddressesAndLevels()
        {
            Dictionary<TextBox, TextBox> a = new Dictionary<TextBox, TextBox>();
            foreach (var x in t_dict)
            {
                a[x.Key] = x.Value;
            }
            return a;
        }

        public Form1()
        {
            InitializeComponent();
            TextBox textbox = new TextBox();
            textbox.Left = left;
            textbox.Top = top;
            textbox.Width = 290;
            
            this.groupBox1.Controls.Add(textbox);

            TextBox textbox1 = new TextBox();
            textbox1.Left = left+290+distance_x;
            textbox1.Top = top;
            textbox1.Width = 40;
            this.groupBox1.Controls.Add(textbox1);
            t_dict[textbox] = textbox1;
            top += textbox.Height + distance_y;

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (test_clicked == false)
            {
                notifyIcon1.BalloonTipTitle = "Minimize to Tray App";
                notifyIcon1.BalloonTipText = "You have successfully minimized your form.";

                notifyIcon1.Visible = true;
                notifyIcon1.ShowBalloonTip(500);
                this.Hide();
                label1.Text = "Test in progress";
                button1.Text = "STOP";
                test_clicked = true;

                foreach (var x in t_dict)
                {
                    x.Key.Enabled = false;
                    x.Value.Enabled = false;
                }
                button2.Enabled = false;

                List<String> a= GetAddresses();

                TestController tc = new TestController(a);
                tc.Test();

                

            }
            else
            {
                label1.Text = "Choose addresses to test";
                button1.Text = "TEST";
                test_clicked = false;

                foreach (var x in t_dict)
                {
                    x.Key.Enabled = true;
                    x.Value.Enabled = true;
                }
                button2.Enabled = true;
            }
            
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
                if(counter< limit)
                {
                    counter++;
                    TextBox textbox = new TextBox();
                    textbox.Left = left;
                    textbox.Top = top;
                    textbox.Width = 290;
                    this.groupBox1.Controls.Add(textbox);

                    TextBox textbox1 = new TextBox();
                    textbox1.Left = left + 290 + distance_x;
                    textbox1.Top = top;
                    textbox1.Width = 40;
                    this.groupBox1.Controls.Add(textbox1);
                    t_dict[textbox] = textbox1;
                    top += textbox.Height + distance_y;
                }


        }
        

        private void Form1_Resize(object sender, EventArgs e)
        {
            notifyIcon1.BalloonTipTitle = "Minimize to Tray App";
            notifyIcon1.BalloonTipText = "You have successfully minimized your form.";

            if (FormWindowState.Minimized == this.WindowState)
            {
                notifyIcon1.Visible = true;
                notifyIcon1.ShowBalloonTip(500);
                this.Hide();
            }
        }

        private void notifyIcon1_MouseClick(object sender, MouseEventArgs e)
        {
            this.Show();
            this.WindowState = FormWindowState.Normal;
            notifyIcon1.Visible = false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}

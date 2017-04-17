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
        int top = 25;
        int left = 25;
        int limit = 10;
        int counter = 0;
        bool test_clicked = false;
        List<TextBox> t_list = new List<TextBox>();

        private List<String> GetAddresses()
        {
            List<String> a = new List<String>();
            foreach (var x in t_list)
            {
                a.Add(x.Text);
            }
            return a;
        }

        public Form1()
        {
            InitializeComponent();
            TextBox textbox = new TextBox();
            textbox.Left = left;
            textbox.Top = top;
            textbox.Width = 225;
            t_list.Add(textbox);
            this.groupBox1.Controls.Add(textbox);
            top += textbox.Height + 4;
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

                foreach (var x in t_list)
                {
                    x.Enabled = false;
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

                foreach (var x in t_list)
                {
                    x.Enabled = true;
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
                    textbox.Width = 225;
                    t_list.Add(textbox);
                    this.groupBox1.Controls.Add(textbox);
                    top += textbox.Height + 4;
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
    }
}

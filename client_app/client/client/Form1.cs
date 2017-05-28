using System;
using System.Windows.Forms;

namespace client
{
    public partial class Form1 : Form
    {
        int top = 30;
        int left = 25;
        int distance_y = 5;
        int distance_x = 20;

        bool test_clicked = false;
        private static TextBox textbox1;
        private static TextBox textbox;


        public static  string GetAddress()
        {
            return textbox1.Text;

        }

        private string[] GetAddressesAndLevels()
        {
            string[] tab = new string[2];
            tab[0] = textbox.Text;
            tab[1] = textbox1.Text;
            return tab;
        }

        public Form1()
        {
            InitializeComponent();
            textbox = new TextBox();
            textbox.Left = left;
            textbox.Top = top;
            textbox.Width = 290;
            
            this.groupBox1.Controls.Add(textbox);

            textbox1 = new TextBox();
            textbox1.Left = left+290+distance_x;
            textbox1.Top = top;
            textbox1.Width = 40;
            this.groupBox1.Controls.Add(textbox1);
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


                
                int level = 0;
                var tab = GetAddressesAndLevels();
                //sprawdzanie poprawnosci Lvla
                int n;
                if(int.TryParse(tab[1], out n))
                    level = Convert.ToInt32(tab[1]);
                else
                {
                    Form f2 = new Form2();
                    f2.Text = "Levels invalid!";
                    return;
                }

                //sprawdzenie poprawności adresu
                if (!CheckAdress.CheckAdressMethod(tab[0]))
                {
                    tab[0]= CheckAdress.CorrectAdress(tab[0]);
                }
                TestController tc = new TestController(tab[0],level);
                //tc.Test();

                this.Show();
                label1.Text = "Choose addresses to test";
                button1.Text = "TEST";
                test_clicked = false;
                notifyIcon1.Visible = false;
            }
            else
            {
                label1.Text = "Choose addresses to test";
                button1.Text = "TEST";
                test_clicked = false;
            }

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

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

using QuanLyNhaHang.DAO;
using QuanLyNhaHang.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyNhaHang
{
    public partial class frmLogin : Form
    {
       
        public frmLogin()
        {
            InitializeComponent();
            txtUserName.Focus();
        }
       
        private void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txtUserName.Text;
            string passWord = txtPassWord.Text;          
            if (Login(userName,passWord))
            {              
                frmTableManager f = new frmTableManager(userName);             
                this.Hide();
                DialogResult mainResult =  f.ShowDialog();
                if (mainResult == DialogResult.Abort)
                {
                    this.Close();
                }
               // this.Show();
            }   
            else
            {
                MessageBox.Show(Properties.Settings.Default.checkAccount);
            }          
        }
        bool Login(string userName,string passWord)
        {
            return AccountDAO.Instance.Login(userName,passWord);
        }
        private void btnThoat_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void frmLogig_FormClosing(object sender, FormClosingEventArgs e)
        {
            
        }
        private void lblExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void lblClearFields_Click(object sender, EventArgs e)
        {
            txtUserName.Clear();
            txtPassWord.Clear();
            txtUserName.Focus();            
        }

        
       
    }
}

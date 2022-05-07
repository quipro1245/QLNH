using QuanLyNhaHang.DAO;
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
    public partial class frmAccountProfile : Form
    {
        private string message;
        public frmAccountProfile()
        {
            InitializeComponent();
           // loaddata();
        }
        public frmAccountProfile(string Message) : this()
        {
            message = Message;
      
            string query = "SELECT * FROM ACCOUNT WHERE USERNAME = N'"+message+"'";
            DataTable da = DataProvider.Instance.ExecuteQuery(query);
            if (da.Rows.Count > 0)
            {
                txtUserName.Text = da.Rows[0]["USERNAME"].ToString().Trim();
                txtDisPlayName.Text = da.Rows[0]["DISPLAYNAME"].ToString().Trim();
                txtPassWord.Text = da.Rows[0]["PASSWORD"].ToString().Trim();
            }
            else
            {
                MessageBox.Show(Properties.Settings.Default.NotFound, Properties.Settings.Default.Notification);
            }
        }
        void loaddata()
        {
            string query = "SELECT * FROM ACCOUNT";
           DataTable da =  DataProvider.Instance.ExecuteQuery(query);
            if (da.Rows.Count > 0)
            {
                      txtUserName.Text = da.Rows[0]["USERNAME"].ToString().Trim();
                      txtDisPlayName.Text = da.Rows[0]["DISPLAYNAME"].ToString().Trim();
                      txtPassWord.Text = da.Rows[0]["PASSWORD"].ToString().Trim();
            }
            else
            {
               MessageBox.Show(Properties.Settings.Default.NotFound, Properties.Settings.Default.Notification);
            }
        }
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtNewPassWord.Text == "" && txtReEnterPassWord.Text == "")
            {
                MessageBox.Show(Properties.Settings.Default.RePasswordAndConfirm);
            }
            else
            if (txtNewPassWord.Text == txtReEnterPassWord.Text)
            {
                string query = "UPDATE ACCOUNT SET PASSWORD = N'" + txtNewPassWord.Text + @"' WHERE USERNAME = N'" + txtUserName.Text + "'";
                DataProvider.Instance.ExecuteQuery(query);
            }
            else
            {
                MessageBox.Show(Properties.Settings.Default.ConfirmPassword);
                txtNewPassWord.Clear();
                txtReEnterPassWord.Clear();
                txtNewPassWord.Focus();
            }    
           loaddata();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyNhaHang.DTO
{
    public class Account
    {
        public Account(string userName,string disPlayName, int type , string passWord=null)
        {
            this.UserName = userName;
            this.DisPlayName = disPlayName;
            this.PassWord = passWord;
            this.Type = type;
        }
        public Account (DataRow row)
        {
            this.UserName = row["userName"].ToString();
            this.DisPlayName = row["disPlayName"].ToString();
            this.PassWord = row["passWord"].ToString(); 
            this.Type = (int)row["type"];
        }
        private int type;
        private string disPlayName;
        private string passWord;
        private string userName;

        public string UserName { get => userName; set => userName = value; }
        public string PassWord { get => passWord; set => passWord = value; }
        public string DisPlayName { get => disPlayName; set => disPlayName = value; }
        public int Type { get => type; set => type = value; }
    }
}

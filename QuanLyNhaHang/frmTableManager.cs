using QuanLyNhaHang.DTO;
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
using System.Globalization;
using System.Threading;

namespace QuanLyNhaHang
{
    public partial class frmTableManager : Form
    {
        private string _message;
        public frmTableManager()
        {
            InitializeComponent();
            LoadTable();
            LoadCategory();
            LoadComboboxTable(cbSwitchTable);
            LoadComboboxTable(cbDatBan);
          
        }
        #region Method      
       
       public frmTableManager(string Message):this()
        {
            _message = Message;

            lblAcount.Text = _message;
            string query = "SELECT TYPE FROM ACCOUNT WHERE USERNAME = N'"+lblAcount.Text+"'";
            DataTable da = DataProvider.Instance.ExecuteQuery(query);
            if (da.Rows[0]["TYPE"].ToString().Trim()=="1")
            {
                adminToolStripMenuItem.Enabled = true;
                lblPhanQuyen.Enabled = true;
                lblPhanQuyen.Text = "Admin";
            }    
            else
            {
                adminToolStripMenuItem.Enabled = false;
                lblPhanQuyen.Enabled = true;
                lblPhanQuyen.Text = "Staff";
            }    
        }
        void LoadCategory()
        {
            List<Category> listCategory = CategoryDAO.Instance.GetListCategory();
            cbCategory.DataSource = listCategory;
            cbCategory.DisplayMember = "Name";
        }
        void LoadFoodListByCategoryID(int id)
        {
            List<Food> listFood = FoodDAO.Instance.GetFoodCategoryID(id);
            cbFood.DataSource = listFood;
            cbFood.DisplayMember = "Name";

        }

        /*void LoadTableListByCategoryID(int id)
        {
            List<Table> lisTable = TableDAO.Instance.GetTableCategoryID(id);
            cbFood.DataSource = lisTable;
            cbFood.DisplayMember = "Name";

        }*/
        void LoadTable()
        {
            flpTable.Controls.Clear();
            List<Table> tableList = TableDAO.Instance.LoadTableList();
            foreach (Table item in tableList)
            {
                Button btn = new Button() { Width=TableDAO.TableWidth,Height=TableDAO.TableHeight};
                btn.Text = item.Name + Environment.NewLine +item.Status;
                btn.Click += btn_Click;
                btn.TextAlign = ContentAlignment.BottomCenter;
                btn.Tag = item;
                switch (item.Status)
                {
                    case "Trống":
                        btn.Image = Properties.Resources.tableEmpty; 
                        btn.BackgroundImageLayout = ImageLayout.Stretch;
                       
                        btn.ForeColor = Color.Blue;
                        break;
                    case "Đã đặt":
                        btn.Image = Properties.Resources.ordered;
                        btn.BackgroundImageLayout = ImageLayout.Stretch;
                       
                        btn.ForeColor = Color.Blue;
                        break;
                    default:
                        btn.Image = Properties.Resources.table;
                        btn.BackgroundImageLayout = ImageLayout.Stretch;
                        btn.ForeColor = Color.Blue;
                        
                        break;
                }
                flpTable.Controls.Add(btn);
            }
        }

        void ShowBill(int id)
        {
            lvBill.Items.Clear();
            List<DTO.Menu> listBillInfo = MenuDAO.Instance.GetListMenuByTable(id);
            float totalPrice = 0;

            foreach (DTO.Menu item in listBillInfo)
            {
                ListViewItem listViewItem = new ListViewItem(item.FoodName.ToString());
                listViewItem.SubItems.Add(item.Count.ToString());
                listViewItem.SubItems.Add(item.Price.ToString());
                listViewItem.SubItems.Add(item.TotalPrice.ToString());
                totalPrice += item.TotalPrice;
                lvBill.Items.Add(listViewItem);
            }
            //CultureInfo culture = new CultureInfo("vi-VN");
            //Thread.CurrentThread.CurrentCulture = culture;
            txtTotalPrice.Text = totalPrice.ToString()+"đ";
         
        }

        void LoadComboboxTable(ComboBox cb)
        {
            cb.DataSource = TableDAO.Instance.LoadTableList();
            cb.DisplayMember = "Name";
        }
        #endregion

        #region Events
         void btn_Click(object sender, EventArgs e)
        {
            int TableID = ((sender as Button).Tag as Table).ID;
            lvBill.Tag = (sender as Button).Tag;
            ShowBill(TableID);
        }
        private void đăngXuấtToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmAccountProfile f = new frmAccountProfile(lblAcount.Text);
            f.ShowDialog();
        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmAdmin f = new frmAdmin();
            f.UpdateFood += f_UpdateFood;
           //f.DeleteFood += f_DeleteFood;
            LoadTable();
            f.ShowDialog();

        }
        private void f_UpdateFood(object sender, EventArgs e)
        {
            LoadFoodListByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lvBill.Tag != null)
                ShowBill((lvBill.Tag as Table).ID);
        }

        /*private void f_DeleteFood(object sender, EventArgs e)
        {
            LoadFoodListByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lvBill.Tag != null)
                ShowBill((lvBill.Tag as Table).ID);
        }*/

        /*private void f_UpdateTable(object sender, EventArgs e)
        {
            LoadTable();
        }*/
        private void cbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = 0;
            ComboBox cb = sender as ComboBox;
            if (cb.SelectedItem == null)
                return; ;
            Category selected = cb.SelectedItem as Category;
            id = selected.ID;
            LoadFoodListByCategoryID(id);
        }
        private void btnAdd_Click(object sender, EventArgs e)
        {
            Table table = lvBill.Tag as Table;
            int idBill = BillDAO.Instance.GetUncheckBillIDByTableID(table.ID);
            int foodID = (cbFood.SelectedItem as Food).ID;
            int count = (int)nudFoodCount.Value;

            if(idBill==-1)
            {
                BillDAO.Instance.InsertBill(table.ID);
                BillInfoDAO.Instance.InsertBillInfo(BillDAO.Instance.GetMaxIDBill(),foodID,count);
            }
            else
            {
                BillInfoDAO.Instance.InsertBillInfo(idBill, foodID, count);
            }
            ShowBill(table.ID);
            LoadTable();
        }
        private void btnCheckOut_Click(object sender, EventArgs e)
        {
            Table table = lvBill.Tag as Table;
            int idBill = BillDAO.Instance.GetUncheckBillIDByTableID(table.ID);
            int discount = (int)nudDiscount.Value;

            double totalPrice = Convert.ToDouble(txtTotalPrice.Text.Split('đ')[0]);
            double finalTotalPrice = totalPrice - (totalPrice / 100) * discount;
            if(idBill!=-1)
            {
   //Note--------------------------------------------------------------------------------------------
                if(MessageBox.Show(string.Format(Properties.Settings.Default.Pay, table.Name,totalPrice,discount,finalTotalPrice),Properties.Settings.Default.Notification,MessageBoxButtons.OKCancel)==System.Windows.Forms.DialogResult.OK)
                {
                    BillDAO.Instance.CheckOut(idBill, discount, (float)finalTotalPrice);
                    ShowBill(table.ID);
                    LoadTable();
                }    
            }    
        }
        private void btnSwitchTable_Click(object sender, EventArgs e)
        {
            int id1 = (lvBill.Tag as Table).ID;
            int id2 = (cbSwitchTable.SelectedItem as Table).ID;
            string status1 = (lvBill.Tag as Table).Status;
            Table itemValue;
            foreach (Control item in flpTable.Controls)
            {
                itemValue = (Table)item.Tag; 
                if (itemValue.ID == id2 && (itemValue.Status == "Có người" || itemValue.Status =="Đã đặt"))
                {
                    MessageBox.Show(Properties.Settings.Default.SomeBody);
                    return;
                }
                if(status1== "Trống")
                {
                    MessageBox.Show(Properties.Settings.Default.EmptyTable);
                    return;
                }    

            }
    //Note------------------------------------------------------------------------------------------------


            if (MessageBox.Show(string.Format(Properties.Settings.Default.SwitchTable, (lvBill.Tag as Table).Name, (cbSwitchTable.SelectedItem as Table).Name),Properties.Settings.Default.Notification,MessageBoxButtons.OKCancel)==System.Windows.Forms.DialogResult.OK)
            {
                TableDAO.Instance.SwitchTable(id1, id2);
                LoadTable();
            }    
                    
        }
        private void btnOrder_Click(object sender, EventArgs e)
        {            
                int id2 = (cbDatBan.SelectedItem as Table).ID;
                string status1 = (cbDatBan.SelectedItem as Table).Status;
                Table itemValue;
                foreach (Control item in flpTable.Controls)
                {
                    itemValue = (Table)item.Tag;
                    if (itemValue.ID == id2 && (itemValue.Status == "Có người"|| itemValue.Status == "Đã đặt"))
                    {
                        MessageBox.Show(Properties.Settings.Default.SomeBody);
                        return;
                    }
                    if (status1 == "Trống")
                    {
                    
                    string query = @"UPDATE TABLEFOOD SET status =N'Đã đặt' WHERE ID = "+id2;
                    //MessageBox.Show(query);
                      DataProvider.Instance.ExecuteQuery(query);
                    LoadTable();
                    return;
                    }

                }
           
        }

        #endregion
     
        private void lblPhanQuyen_Click(object sender, EventArgs e)
        {
            if (lblPhanQuyen.Text == "Admin")
            {
                frmAdmin f = new frmAdmin();
                f.UpdateFood += f_UpdateFood;
                //f.DeleteFood += f_DeleteFood;
                LoadTable();
                f.ShowDialog();
            }
            if (lblPhanQuyen.Text == "Staff")
            {
                frmStaff f = new frmStaff();
                f.UpdateFood += f_UpdateFood;
                //f.DeleteFood += f_DeleteFood;
                LoadTable();
                f.ShowDialog();
            }
        }

        private void flpTable_Paint(object sender, PaintEventArgs e)
        {

        }

        private void frmTableManager_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult confirmResult = MessageBox.Show(Properties.Settings.Default.CONFIRM_CLOSE,Properties.Settings.Default.Notification, MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (confirmResult== DialogResult.No)
            {
                e.Cancel = true;
            }
            else
            {
                this.DialogResult = DialogResult.Abort;
            }
        }

        private void notifyIcon1_Click(object sender, EventArgs e)
        {
            /*var eventArgs = e as MouseEventArgs;
            switch (eventArgs.Button)
            {
                // Left click to reactivate
                case MouseButtons.Left:
                    // Do your stuff
                    break;
            }*/
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            MessageBox.Show(Properties.Settings.Default.Tutorial,Properties.Settings.Default.TitleTutorial);
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            MessageBox.Show(Properties.Settings.Default.applicationsopen);
        }

        private void toolStripMenuItem3_Click(object sender, EventArgs e)
        {
            MessageBox.Show(Properties.Settings.Default.Introduce,Properties.Settings.Default.Hello);
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            LoadTable();
            LoadCategory();
            LoadComboboxTable(cbSwitchTable);
            LoadComboboxTable(cbDatBan);
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close(); ;
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using QuanLyNhaHang.DAO;
using QuanLyNhaHang.DTO;

namespace QuanLyNhaHang
{
    public partial class frmAdmin : Form
    {
        BindingSource foodList = new BindingSource();
        public frmAdmin()
        {
            InitializeComponent();
            dgvFood.DataSource = foodList;
            LoadFoodList();
            LoadTextBox();
            LoadCategory();
            loadCategoryBiding();
            TableBiding();
            LoadAcount();

        }
        void LoadFoodList()
        {

            string query = @"SELECT f.ID, f.NAME as [TÊN MÓN ĂN], f.PRICE, fc.NAME FROM FOOD as f, FOODCATEGORY as fc WHERE f.IDCATEGORY = fc.ID";
            dgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);

            dgvFood.Columns["ID"].Width = 50;
            dgvFood.Columns["TÊN MÓN ĂN"].Width = 200;

            dgvFood.Columns["PRICE"].Width = 100;
            dgvFood.Columns["NAME"].Width = 200;
        }
        /* void LoadAccountList()
         {
             string query = "EXEC dbo.USP_GetAcountByUserName @userName";

             dgvAccount.DataSource = DataProvider.Instance.ExecuteQuery(query,new object[] { "quipro"});
         }*/
        void LoadTextBox()
        {
            txtFoodID.DataBindings.Clear();
            txtFoodName.DataBindings.Clear();
            cbFoodCategory.DataBindings.Clear();
            nudFoodPrice.DataBindings.Clear();
            txtFoodID.DataBindings.Add("Text", dgvFood.DataSource, "ID");
            txtFoodName.DataBindings.Add("Text", dgvFood.DataSource, "TÊN MÓN ĂN");

            
            cbFoodCategory.ValueMember = "Name";
           // cbFoodCategory.DataSource = DataProvider.Instance.ExecuteQuery("SELECT IDCATEGORY FROM FOOD GROUP BY IDCATEGORY");
           // cbFoodCategory.DisplayMember = "IDCATEGORY";
             cbFoodCategory.DataBindings.Add("Text", dgvFood.DataSource, "NAME");
            nudFoodPrice.DataBindings.Add("Text", dgvFood.DataSource, "Price");
            cbFoodCategory.DataSource = DataProvider.Instance.ExecuteQuery("Select name from foodcategory");
        }

        private void btnViewBill_Click(object sender, EventArgs e)
        {
            string query = @"SELECT t.NAME , b.totalPrice, DATECHECKIN,DATECHECKOUT,discount FROM bill as b, TABLEFOOD as t
                            WHERE DATECHECKIN >= '" + dtpFromDate.Value + @"' AND DATECHECKOUT <= '" + dtpToDay.Value + @"' AND b.STATUS = 1
                            AND t.ID = b.IDTABLE";
            dgvBill.DataSource = DataProvider.Instance.ExecuteQuery(query);

        }

        private void btnShowFood_Click(object sender, EventArgs e)
        {
            LoadFoodList();
            LoadTextBox();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {

            string query = @"INSERT dbo.FOOD(NAME,IDCATEGORY,PRICE)
 VALUES(N'" + txtFoodName.Text + @"',(SELECT id FROM FOODCATEGORY where name =N'" + cbFoodCategory.Text + @"')," + nudFoodPrice.Value + @")";
            //MessageBox.Show(query);
            DataProvider.Instance.ExecuteQuery(query);
            LoadFoodList();
            LoadTextBox();
        }

        private void btnDeleteFood_Click(object sender, EventArgs e)
        {
            /*string query1 = @"DELETE FROM BILLINFO WHERE IDFOOD =" + txtFoodID.Text;
            string query = @"DELETE FROM FOOD WHERE NAME =N'" + txtFoodName.Text + @"' and PRICE =" + nudFoodPrice.Value + @" and IDCATEGORY =" + txtFoodID.Text + @"
";
             //MessageBox.Show(query1);
            MessageBox.Show(query);
             DataProvider.Instance.ExecuteQuery(query1);
             DataProvider.Instance.ExecuteQuery(query);
            LoadFoodList();
            LoadTextBox();*/
           
            
                int id = Convert.ToInt32(txtFoodID.Text);

                if (FoodDAO.Instance.DeleteFood(id))
                {
                    MessageBox.Show(Properties.Settings.Default.SuccessfullDeletion);
                    LoadFoodList();
                    if (deleteFood != null)
                    deleteFood(this, new EventArgs());

                }
                else
                {
                    MessageBox.Show(Properties.Settings.Default.ErrorDeleteFood);
                }
            LoadTextBox();
        }

        private event EventHandler deleteFood;
        public event EventHandler DeleteFood
        {
            add { deleteFood += value; }
            remove { deleteFood -= value; }
        }
        private void btnEditFood_Click(object sender, EventArgs e)
        {
            string query = @"UPDATE FOOD SET NAME = N'" + txtFoodName.Text + @"', PRICE = " + nudFoodPrice.Value + @" WHERE  ID =  " + txtFoodID.Text;

            //MessageBox.Show(query);
            DataProvider.Instance.ExecuteQuery(query);
            LoadFoodList();
            LoadTextBox();
        }
        void LoadCategory()
        {
            dgvCategory.DataSource = DataProvider.Instance.ExecuteQuery("SELECT * FROM FOODCATEGORY");
            dgvCategory.Columns["ID"].Width = 100;
            dgvCategory.Columns["NAME"].Width = 200;
        }
        private void btnShowCategory_Click(object sender, EventArgs e)
        {
            LoadCategory();
        }
        void loadCategoryBiding()
        {
            txtCategoryID.DataBindings.Clear();
            cbbCategoryName.DataBindings.Clear();
            txtCategoryID.DataBindings.Add("Text", dgvCategory.DataSource, "ID");
            cbbCategoryName.DataBindings.Add("Text", dgvCategory.DataSource, "NAME");
        }
        private void btnAddCategory_Click(object sender, EventArgs e)
        {
            string query = @"INSERT FOODCATEGORY(NAME)VALUES(N'" + cbbCategoryName.Text + @"')";
            DataProvider.Instance.ExecuteQuery(query);
            LoadCategory();
            loadCategoryBiding();
        }

        private void btnDeleteCategory_Click(object sender, EventArgs e)
        {
            
            LoadTextBox();
            string query = @"DELETE FROM FOOD  WHERE IDCATEGORY ="+txtCategoryID.Text+" DELETE FROM FOODCATEGORY WHERE ID =" + txtCategoryID.Text;
             DataProvider.Instance.ExecuteQuery(query);
             LoadCategory();
             loadCategoryBiding();
            LoadFoodList();
        }
        


        private void btnEditCategory_Click(object sender, EventArgs e)
        {
            string query = @"UPDATE FOODCATEGORY SET NAME =N'" + cbbCategoryName.Text + @"' WHERE ID =" + txtCategoryID.Text;
            DataProvider.Instance.ExecuteQuery(query);
            LoadCategory();
            loadCategoryBiding();
        }
        void TableBiding()
        {
            dgvTable.DataSource = DataProvider.Instance.ExecuteQuery("SELECT * FROM TABLEFOOD");
            txtTableID.DataBindings.Clear();
            txtTableName.DataBindings.Clear();
            cbTableStatus.DataBindings.Clear();
            txtTableID.DataBindings.Add("Text", dgvTable.DataSource, "ID");
            txtTableName.DataBindings.Add("Text", dgvTable.DataSource, "NAME");
            cbTableStatus.DataBindings.Add("Text", dgvTable.DataSource, "status");
            cbTableStatus.DataSource = DataProvider.Instance.ExecuteQuery("SELECT status FROM TABLEFOOD GROUP BY status");
            cbTableStatus.DisplayMember = "status";        

        }

        private void btnShowTable_Click(object sender, EventArgs e)
        {
            dgvTable.DataSource = DataProvider.Instance.ExecuteQuery("SELECT * FROM TABLEFOOD");
            TableBiding();
        }

        private void btnAddTable_Click(object sender, EventArgs e)
        {
            string query = @"INSERT INTO dbo.TABLEFOOD(NAME)VALUES(N'" + txtTableName.Text + @"')";
            DataProvider.Instance.ExecuteQuery(query);
            TableBiding();
        }

        private void btnDeleteTable_Click(object sender, EventArgs e)
        {
            string query = @"DELETE FROM TABLEFOOD WHERE ID = " + txtTableID.Text;
            DataProvider.Instance.ExecuteQuery(query);
            TableBiding();

        }

        private void btnEditTable_Click(object sender, EventArgs e)
        {
            string query = @"UPDATE TABLEFOOD SET NAME =N'" + txtTableName.Text + @"' WHERE ID =" + txtTableID.Text;
            DataProvider.Instance.ExecuteQuery(query);
            TableBiding();


        }
        void LoadAcount()
        {
            dgvAccount.DataSource = DataProvider.Instance.ExecuteQuery("SELECT USERNAME,DISPLAYNAME,TYPE FROM ACCOUNT");
            txtUserName.DataBindings.Clear();
            txtDisplayName.DataBindings.Clear();
            cbAccountType.DataBindings.Clear();
            txtUserName.DataBindings.Add("Text", dgvAccount.DataSource, "USERNAME");
            txtDisplayName.DataBindings.Add("Text", dgvAccount.DataSource, "Displayname");
            cbAccountType.DataBindings.Add("Text", dgvAccount.DataSource, "Type");
           // cbAccountType.DataSource = DataProvider.Instance.ExecuteQuery("SELECT TYPE FROM ACCOUNT GROUP BY TYPE");
            //cbAccountType.DisplayMember = "TYPE";
            cbAccountType.Items.Add("1");
            cbAccountType.Items.Add("0");
        }
        private void btnShowAccount_Click(object sender, EventArgs e)
        {
            LoadAcount();
        }

        private void btnAddAccount_Click(object sender, EventArgs e)
        {
            if (txtPassWord.Text != txtReTypePassWord.Text)
            {
                MessageBox.Show(Properties.Settings.Default.ConfirmPassword, Properties.Settings.Default.Notification);
            }
            else
            {
                string query = @"INSERT INTO dbo.ACCOUNT(USERNAME, DISPLAYNAME, PASSWORD, TYPE) VALUES(N'" + txtUserName.Text + @"', N'" + txtDisplayName.Text + @"', N'" + txtPassWord.Text + @"'," + cbAccountType.Text + @")";
                //MessageBox.Show(query);
                DataProvider.Instance.ExecuteQuery(query);
            }
            LoadAcount();
        }

        private void btnDeleteAccount_Click(object sender, EventArgs e)
        {

            string query = @"DELETE FROM ACCOUNT WHERE DISPLAYNAME = N'" + txtDisplayName.Text + "' AND USERNAME = N'" + txtUserName.Text + "'";
            //MessageBox.Show(query);
            DataProvider.Instance.ExecuteQuery(query);
            LoadAcount();
        }

        private void cbFoodCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (cbFoodCategory.Text)
            {
                case "Súp": pictureBox1.Image = Properties.Resources.sup; break;
                case "Rau": pictureBox1.Image = Properties.Resources.raui; break;
                case "Nộm và Salad": pictureBox1.Image = Properties.Resources.nomvasalad; break;
                case "Gỏi sứa": pictureBox1.Image = Properties.Resources.goisua; break;
                case "Mực": pictureBox1.Image = Properties.Resources.muc; break;
                case "Cá hồi": pictureBox1.Image = Properties.Resources.cahoi; break;
                case "Cá quả": pictureBox1.Image = Properties.Resources.caqua; break;
                case "Dê": pictureBox1.Image = Properties.Resources.de; break;
                case "Lẩu các loại": pictureBox1.Image = Properties.Resources.lau; break;
                case "Ếch": pictureBox1.Image = Properties.Resources.ech; break;
                case "Tôm": pictureBox1.Image = Properties.Resources.tom; break;
                case "Ghẹ": pictureBox1.Image = Properties.Resources.ghe; break;
                case "Sườn Lợn": pictureBox1.Image = Properties.Resources.suonlon; break;
                case "Nem": pictureBox1.Image = Properties.Resources.nem; break;
                case "Canh các món": pictureBox1.Image = Properties.Resources.canhca; break;
                case "Bò": pictureBox1.Image = Properties.Resources.cow; break;
                case "Vịt": pictureBox1.Image = Properties.Resources.vit; break;
                case "Thức uống": pictureBox1.Image = Properties.Resources.wine; break;
                default:
                    pictureBox1.Image = Properties.Resources.tomhum; break;
            }

            pictureBox1.SizeMode = PictureBoxSizeMode.StretchImage;
            /* string query = "SELECT * FROM FOOD WHERE IDCATEGORY = (SELECT ID FROM FOODCATEGORY WHERE NAME=N'"+ cbFoodCategory.Text + "')";
             dgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);*/
        }

        private void cbbCategoryName_TextChanged(object sender, EventArgs e)
        {
            switch (cbbCategoryName.Text)
            {
                case "Súp": pictureBox2.Image = Properties.Resources.sup; break;
                case "Rau": pictureBox2.Image = Properties.Resources.raui; break;
                case "Nộm và Salad": pictureBox2.Image = Properties.Resources.nomvasalad; break;
                case "Gỏi sứa": pictureBox2.Image = Properties.Resources.goisua; break;
                case "Mực": pictureBox2.Image = Properties.Resources.muc; break;
                case "Cá hồi": pictureBox2.Image = Properties.Resources.cahoi; break;
                case "Cá quả": pictureBox2.Image = Properties.Resources.caqua; break;
                case "Dê": pictureBox2.Image = Properties.Resources.de; break;
                case "Lẩu các loại": pictureBox2.Image = Properties.Resources.lau; break;
                case "Ếch": pictureBox2.Image = Properties.Resources.ech; break;
                case "Tôm": pictureBox2.Image = Properties.Resources.tom; break;
                case "Ghẹ": pictureBox2.Image = Properties.Resources.ghe; break;
                case "Sườn Lợn": pictureBox2.Image = Properties.Resources.suonlon; break;
                case "Nem": pictureBox2.Image = Properties.Resources.nem; break;
                case "Canh các món": pictureBox2.Image = Properties.Resources.canhca; break;
                case "Vịt": pictureBox2.Image = Properties.Resources.vit; break;
                case "Bò": pictureBox2.Image = Properties.Resources.cow; break;
                case "Thức uống": pictureBox2.Image = Properties.Resources.wine; break;
                default:
                    pictureBox2.Image = Properties.Resources.tomhum; break;
            }
            pictureBox2.SizeMode = PictureBoxSizeMode.StretchImage;
        }

        private void cbTableStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch(cbTableStatus.Text)
            {
                case "Trống": pictureBox3.Image = Properties.Resources.png_clipart_coffee_table_icon_wooden_table_angle_furniture; break;
                case "Có người": pictureBox3.Image = Properties.Resources.table; break;
                case "Đã đặt": pictureBox3.Image = Properties.Resources.ordered;break;
            }
            pictureBox3.SizeMode = PictureBoxSizeMode.StretchImage;
        }

        private void btnResetPassWord_Click(object sender, EventArgs e)
        {
            string query = "UPDATE ACCOUNT SET PASSWORD = USERNAME WHERE USERNAME = N'"+txtUserName.Text+"'";
            //MessageBox.Show(query);
            DataProvider.Instance.ExecuteQuery(query);
            LoadAcount();
        }

        List<Food>SearchFoodByName(string name)
        {
            List<Food> listFood = FoodDAO.Instance.SearchFoodByName(name);
            return listFood;
        }
        private void btnSeachFood_Click(object sender, EventArgs e)
        {
            dgvFood.DataSource = SearchFoodByName(txtSeachFoodName.Text);
            

        }
        private event EventHandler updateFood;
        public event EventHandler UpdateFood
        {
            add { updateFood += value; }
            remove { updateFood -= value; }
        }

        /* private event EventHandler deleteFood;
         public event EventHandler DeleteFood
         {
             add { deleteFood += value; }
             remove { deleteFood -= value; }
         }*/

       

        private void dgvBill_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvCategory_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dgvFood_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
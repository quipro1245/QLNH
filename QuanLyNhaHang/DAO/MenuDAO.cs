using QuanLyNhaHang.DTO;
using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyNhaHang.DAO
{
    public class MenuDAO
    {
        private static MenuDAO instance;

        public static MenuDAO Instance 
        {
            get { if (instance == null) instance = new MenuDAO(); return instance; }
           private set => instance = value; 
        }
        private MenuDAO() { }
        public List<Menu> GetListMenuByTable(int id)
        {
            List<Menu> listMenu = new List<Menu>();
            string query = "SELECT f.name,bi.COUNT,f.PRICE,f.PRICE*bi.COUNT as totalPrice FROM dbo.BILLINFO AS bi, dbo.BILL AS b,dbo.FOOD AS f WHERE bi.IDBILL = b.ID AND bi.IDFOOD = f.ID AND b.status=0 AND b.IDTABLE =" + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Menu menu = new Menu(item);
                listMenu.Add(menu);
            }
            return listMenu;
        }
    }
}

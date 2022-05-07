using QuanLyNhaHang.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyNhaHang.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;

       
        public static int TableWidth = 120;
        public static int TableHeight = 120;

        public static TableDAO Instance 
        {
            get { if (instance == null) instance = new TableDAO(); return instance; } 
            set => instance = value; 
        }
        
        private TableDAO() { }
        public void SwitchTable(int id1, int id2)
        {      
            DataProvider.Instance.ExecuteQuery(@"UPDATE bill SET idtable = @idTable2 WHERE idtable = @idTable1", new object[] { id2,id1 });
            DataProvider.Instance.ExecuteQuery(@"UPDATE TABLEFOOD SET status = N'Có người' WHERE ID = @idTable2", new object[] { id2 });
            DataProvider.Instance.ExecuteQuery(@"UPDATE TABLEFOOD SET status = N'Trống' WHERE ID = @idTable1", new object[] { id1 });    
        }

       /* public List<Table> GetTableCategoryID(int id)
        {
            List<Table> list = new List<Table>();
            string query = "select * from table where name = " + id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                list.Add(table);
            }

            return list;
        }*/

        public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();
            DataTable data = DataProvider.Instance.ExecuteQuery("EXEC dbo.USP_GetTableList");
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tableList.Add(table);
            }
            return tableList;
        }
    }
}

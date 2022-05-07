using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyNhaHang.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance 
        {
            get { if (instance == null) instance = new BillDAO();  return instance; }
            set => instance = value; 
        }
        private BillDAO() { }
        /// <summary>
        /// Thành công : bill ID
        /// thất bại: -1
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int GetUncheckBillIDByTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.BILL WHERE IDTABLE= "+id+" AND status =0");
            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;//id = -1
        }
        public void CheckOut(int id,int discount,float totalPrice)
        {
            string query = "UPDATE dbo.Bill SET datecheckout = getdate(), status = 1, "+"discount= "+discount+", totalPrice = "+totalPrice+" WHERE id="+id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }
        public void InsertBill(int id)
        {
            DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable",new object[] {id});
        }
        public int GetMaxIDBill()
        {
            try
            {
                return (int)DataProvider.Instance.ExecuteScala("SELECT MAX(id) From dbo.BILL");
            }
            catch
            {
                return 1;
            }

        }
    }
}

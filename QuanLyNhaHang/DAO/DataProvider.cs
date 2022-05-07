using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace QuanLyNhaHang.DAO
{
    public class DataProvider
    {
        private static DataProvider instance;
        
        public static DataProvider Instance
        {
            get { if (instance == null) instance = new DataProvider();return DataProvider.instance; }
            private set { DataProvider.instance = value; }
        }

        private DataProvider(){}
        private string connectionStr = Properties.Settings.Default.ConnectionString;

        public DataTable ExecuteQuery (string query,Object[] parameter = null)
        {
            DataTable data = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionStr))//kết nối
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection); 
                if (parameter != null)
                {
                    string[] listPare = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPare)
                    {
                        if(item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }    
                    }
                }


                SqlDataAdapter adapter = new SqlDataAdapter(command);//trung gian để thực hiện truy vấn lấy dữ liệu
                adapter.Fill(data);
                connection.Close();
            }
                
            return data;
        }
        public int ExecuteNonQuery(string query, Object[] parameter = null)
        {
            int data = 0;
            using (SqlConnection connection = new SqlConnection(connectionStr))//kết nối
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);//câu truy vấn sẽ thực thi 
                if (parameter != null)
                {
                    string[] listPare = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPare)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }
                data = command.ExecuteNonQuery();
                connection.Close();
            }
            return data;
        }
        public object ExecuteScala(string query, Object[] parameter = null)
        {
            object data = 0;
            using (SqlConnection connection = new SqlConnection(connectionStr))//kết nối
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);//câu truy vấn sẽ thực thi 
                if (parameter != null)
                {
                    string[] listPare = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPare)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }
                data = command.ExecuteScalar();
                connection.Close();
            }
            return data;
        }
    }
}

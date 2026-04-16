using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using ProductApp.Models;
using System.Data;

namespace ProductApp.Data
{
    public class ProductDAL
    {
        private readonly string connectionString;

        public ProductDAL(IConfiguration config)
        {
            connectionString = config.GetConnectionString("DefaultConnection")!;
        }

        public void InsertProduct(Product product)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_InsertProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
                cmd.Parameters.AddWithValue("@Category", product.Category);
                cmd.Parameters.AddWithValue("@Price", product.Price);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void GetAllProducts()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetAllProducts", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Console.WriteLine($"{reader["ProductId"]} | {reader["ProductName"]} | {reader["Category"]} | {reader["Price"]}");
                }
            }
        }

        public void UpdateProduct(Product product)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_UpdateProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductId", product.ProductId);
                cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
                cmd.Parameters.AddWithValue("@Category", product.Category);
                cmd.Parameters.AddWithValue("@Price", product.Price);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void DeleteProduct(int id)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_DeleteProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductId", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}

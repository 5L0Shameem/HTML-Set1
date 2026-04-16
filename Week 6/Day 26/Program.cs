using Microsoft.Extensions.Configuration;
using ProductApp.Data;
using ProductApp.Models;
using System.IO;
class Program
{
    static void Main()
    {
        var config = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json")
            .Build();

        ProductDAL dal = new ProductDAL(config);

        while (true)
        {
            Console.WriteLine("\n1. Insert\n2. View\n3. Update\n4. Delete\n5. Exit");
            int choice = Convert.ToInt32(Console.ReadLine());

            switch (choice)
            {
                case 1:
                    Product p = new Product();
                    Console.Write("Name: ");
                    p.ProductName = Console.ReadLine();
                    Console.Write("Category: ");
                    p.Category = Console.ReadLine();
                    Console.Write("Price: ");
                    p.Price = Convert.ToDecimal(Console.ReadLine());
                    dal.InsertProduct(p);
                    break;

                case 2:
                    dal.GetAllProducts();
                    break;

                case 3:
                    Product up = new Product();
                    Console.Write("ID: ");
                    up.ProductId = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Name: ");
                    up.ProductName = Console.ReadLine();
                    Console.Write("Category: ");
                    up.Category = Console.ReadLine();
                    Console.Write("Price: ");
                    up.Price = Convert.ToDecimal(Console.ReadLine());
                    dal.UpdateProduct(up);
                    break;

                case 4:
                    Console.Write("Enter ID: ");
                    int id = Convert.ToInt32(Console.ReadLine());
                    dal.DeleteProduct(id);
                    break;

                case 5:
                    return;
            }
        }
    }
}

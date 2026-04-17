using Microsoft.AspNetCore.Mvc;
using WebApplication3.Models;
using System.Collections.Generic;
using System.Linq;

namespace WebApplication3.Controllers
{
    public class ProductController : Controller
    {
        
        static List<Product> products = new List<Product>()
        {
            new Product{ Id = 1, Name = "Laptop", Price = 50000 },
            new Product{ Id = 2, Name = "Mobile", Price = 20000 },
            new Product{ Id = 3, Name = "Headphones", Price = 2000 }
        };

        
        public IActionResult Index()
        {
            return View(products);
        }

        
        public IActionResult Details(int id)
        {
            var product = products.FirstOrDefault(p => p.Id == id);
            return View(product);
        }
    }
}

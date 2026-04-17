using Microsoft.AspNetCore.Mvc;
using WebApplication3.Models;
using System.Collections.Generic;
using System.Linq;

namespace WebApplication3.Controllers
{
    public class ProductCrudController : Controller
    {
        // Static list (temporary data)
        static List<Product> products = new List<Product>()
        {
            new Product{ Id = 1, Name = "Laptop", Price = 50000 },
            new Product{ Id = 2, Name = "Mobile", Price = 20000 }
        };

        // READ → Index
        public IActionResult Index()
        {
            return View(products);
        }

        // CREATE → GET
        public IActionResult Create()
        {
            return View();
        }

        // CREATE → POST
        [HttpPost]
        public IActionResult Create(Product p)
        {
            if (ModelState.IsValid)
            {
                products.Add(p);
                return RedirectToAction("Index");
            }
            return View(p);
        }

        // EDIT → GET
        public IActionResult Edit(int id)
        {
            var product = products.FirstOrDefault(x => x.Id == id);

            if (product == null)
            {
                return RedirectToAction("Index");
            }

            return View(product);
        }

        // EDIT → POST
        [HttpPost]
        public IActionResult Edit(Product p)
        {
            var product = products.FirstOrDefault(x => x.Id == p.Id);

            if (product != null)
            {
                product.Name = p.Name;
                product.Price = p.Price;
            }

            return RedirectToAction("Index");
        }

        // DELETE
        public IActionResult Delete(int id)
        {
            var product = products.FirstOrDefault(x => x.Id == id);

            if (product != null)
            {
                products.Remove(product);
            }

            return RedirectToAction("Index");
        }

        // DETAILS (optional but good practice)
        public IActionResult Details(int id)
        {
            var product = products.FirstOrDefault(x => x.Id == id);

            if (product == null)
            {
                return RedirectToAction("Index");
            }

            return View(product);
        }
    }
}
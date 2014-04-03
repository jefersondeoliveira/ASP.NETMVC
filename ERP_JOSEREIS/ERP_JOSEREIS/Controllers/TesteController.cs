using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP_JOSEREIS.Controllers
{
    public class TesteController : Controller
    {
        //
        // GET: /Teste/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Tabuada(int id)
        {
            ViewBag.num = id;
            return View();
        }

        public ActionResult Tabuada3()
        {
            //retorna a View Tabuada3
            return View();
        }

        [HttpPost]
        public ActionResult Tabuada3(int numero)
        {
            return RedirectToAction("Tabuada", new { id = numero });
        }

    }
}

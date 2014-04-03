using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ERP_JOSEREIS.Models;
using ERP_JOSEREIS.ViewModels;



namespace ERP_JOSEREIS.Controllers
{
    public class ClienteController : Controller
    {
        private ERPContext db = new ERPContext();

        //
        // GET: /Cliente/

        public ActionResult Index()
        {
            return View(db.Clientes.Include(c => c.pessoa).ToList());
        }

        //
        // GET: /Cliente/Details/5

        public ActionResult Details(int id = 0)
        {
            Cliente cliente = db.Clientes.Find(id);
            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        //
        // GET: /Cliente/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Cliente/Create

        [HttpPost]
        public ActionResult Create(Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                db.Clientes.Add(cliente);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(cliente);
        }

        //
        // GET: /Cliente/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Cliente cliente = db.Clientes.Find(id);
            PessoaFisica pf = db.PessoasFisicas.Find(id);
            ViewBag.IdCidade = new SelectList(db.Cidades, "IdCidade", "Nome");
            ClienteViewModel clienteVM;
            if (cliente == null)
            {
                return HttpNotFound();
            }
            if (pf == null)
            {
                PessoaJuridica pj = db.PessoasJuridicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pj);
            }
            else
            {
                clienteVM = new ClienteViewModel(cliente, pf);
            }
            return View(clienteVM);
        }

        //
        // POST: /Cliente/Edit/5

        [HttpPost]
        public ActionResult EditPF(Cliente cliente, PessoaFisica pessoaFisica)
        {
            if (ModelState.IsValid)
            {
                db.Entry(cliente).State = EntityState.Modified;
                db.Entry(pessoaFisica).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            var clienteVm = new ClienteViewModel(cliente, pessoaFisica);
            return View("Edit", clienteVm);
        }

        //
        // GET: /Cliente/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Cliente cliente = db.Clientes.Find(id);
            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        //
        // POST: /Cliente/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Cliente cliente = db.Clientes.Find(id);
            db.Clientes.Remove(cliente);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
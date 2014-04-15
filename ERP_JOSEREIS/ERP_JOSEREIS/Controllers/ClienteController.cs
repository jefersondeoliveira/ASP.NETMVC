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
            return View(db.Clientes.Include(c => c.Pessoa).ToList());
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
            ClienteViewModel clienteVM;
            try
            {
                PessoaFisica pf = db.PessoasFisicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pf);
                ViewBag.IdCidade = new SelectList
                    (db.Cidades, "IdCidade", "Nome", pf.IdCidade);
            }
            catch (Exception e)
            {
                ViewBag.Erro = e.Message;
                PessoaJuridica pj = db.PessoasJuridicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pj);
                ViewBag.IdCidade = new SelectList
                    (db.Cidades, "IdCidade", "Nome", pj.IdCidade);
            }
            return View(clienteVM);
        }

        //
        // GET: /Cliente/Create

        public ActionResult CreatePF()
        {
            PessoaFisica pf = new PessoaFisica();
            Cliente cliente = new Cliente();
            ClienteViewModel clienteVM = new ClienteViewModel(cliente, pf);
            ViewBag.IdCidade = new SelectList(db.Cidades, "IdCidade", "Nome");
            return View("Edit", clienteVM);
        }

        //
        // GET: /Cliente/Create

        public ActionResult CreatePJ()
        {
            PessoaJuridica pj = new PessoaJuridica();
            Cliente cliente = new Cliente();
            ClienteViewModel clienteVM = new ClienteViewModel(cliente, pj);
            ViewBag.IdCidade = new SelectList(db.Cidades, "IdCidade", "Nome");
            return View("Edit", clienteVM);
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
            if (cliente == null)
            {
                return HttpNotFound();
            }
            ClienteViewModel clienteVM;
            try
            {
                PessoaFisica pf = db.PessoasFisicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pf);
                ViewBag.IdCidade = new SelectList
                    (db.Cidades, "IdCidade", "Nome", pf.IdCidade);
            }
            catch (Exception e)
            {
                ViewBag.Erro = e.Message;
                PessoaJuridica pj = db.PessoasJuridicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pj);
                ViewBag.IdCidade = new SelectList
                    (db.Cidades, "IdCidade", "Nome", pj.IdCidade);
            }
            return View(clienteVM);
        }

        //
        // POST: /Cliente/Edit/5

        [HttpPost]
        public ActionResult EditPF(Cliente cliente, PessoaFisica pessoaFisica, int idCidade)
        {
            pessoaFisica.IdCidade = idCidade;
            if (ModelState.IsValid)
            {
                if (pessoaFisica.IdPessoa != 0)
                {
                    db.Entry(cliente).State = EntityState.Modified;
                    db.Entry(pessoaFisica).State = EntityState.Modified;
                }
                else
                {
                    db.Clientes.Add(cliente);
                    db.PessoasFisicas.Add(pessoaFisica);
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdCidade = new SelectList
                (db.Cidades, "IdCidade", "Nome", pessoaFisica.IdCidade);
            var clienteVM = new ClienteViewModel(cliente, pessoaFisica);
            return View("Edit", clienteVM);
        }

        //
        // POST: /Cliente/Edit/5

        [HttpPost]
        public ActionResult EditPJ(Cliente cliente, PessoaJuridica pessoaJuridica, int idCidade)
        {
            pessoaJuridica.IdCidade = idCidade;
            if (ModelState.IsValid)
            {
                if (pessoaJuridica.IdPessoa != 0)
                {
                    db.Entry(cliente).State = EntityState.Modified;
                    db.Entry(pessoaJuridica).State = EntityState.Modified;
                }
                else
                {
                    db.Clientes.Add(cliente);
                    db.PessoasJuridicas.Add(pessoaJuridica);
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdCidade = new SelectList
                (db.Cidades, "IdCidade", "Nome", pessoaJuridica.IdCidade);
            var clienteVM = new ClienteViewModel(cliente, pessoaJuridica);
            return View("Edit", clienteVM);
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
            ClienteViewModel clienteVM;
            try
            {
                PessoaFisica pf = db.PessoasFisicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pf);
  
            }
            catch (Exception e)
            {
                ViewBag.Erro = e.Message;
                PessoaJuridica pj = db.PessoasJuridicas.Find(id);
                clienteVM = new ClienteViewModel(cliente, pj);
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
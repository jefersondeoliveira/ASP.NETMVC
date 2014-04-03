using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ERP_JOSEREIS.Models;

namespace ERP_JOSEREIS.ViewModels
{
    public class ClienteViewModel
    {
        public Cliente Cliente { get; set; }
        public PessoaFisica PessoaFisica { get; set; }
        public PessoaJuridica PessoaJuridica { get; set; }

        public IList<Pessoa> Pessoas { get; set; }

        public ClienteViewModel(Cliente cliente, PessoaFisica pf)
        {
            PessoaFisica = pf;
            Cliente = cliente;
        }
        public ClienteViewModel(Cliente cliente, PessoaJuridica pj)
        {
            PessoaJuridica = pj;
            Cliente = cliente;
        }
        public ClienteViewModel(IList<Pessoa> pessoas)
        {
            Pessoas = pessoas;
        }
    }
}
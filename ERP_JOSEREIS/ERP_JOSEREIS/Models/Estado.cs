﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ERP_JOSEREIS.Models
{
    public class Estado
    {
        [Key]
        public int IdEstado { get; set; }
        [Required(ErrorMessage="Nome Obrigatório")]
        [StringLength(60)]
        public string Nome { get; set; }
        [StringLength(2)]
        public string Sigla { get; set; }
        public ICollection<Cidade> Cidades { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ERP_JOSEREIS.Models
{
    public class Cidade
    {
        [Key]
        public int IdCidade { get; set; }
        public string Nome { get; set; }
        [Required]
        public int IdEstado { get; set; }
        [ForeignKey("IdEstado")]
        public Estado Estado { get; set; }
    }
}
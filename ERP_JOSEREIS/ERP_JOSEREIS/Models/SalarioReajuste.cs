using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ERP_JOSEREIS.Models
{
    public class SalarioReajuste
    {
        [Key]
        public Int32 IdSalarioReajuste { get; set; }
        public DateTime Data { get; set; }
        public float Valor { get; set; }
        public Funcionario Funcionario { get; set; }


    }
}
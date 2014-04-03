using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ERP_JOSEREIS.Models
{
    public class TipoItem
    {
        [Key]
        public Int32 IdTipoItem { get; set; }
        public String Descricao { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ERP_JOSEREIS.Models
{
    public class Pessoa
    {
        [Key]
        public int IdPessoa { get; set; }
        [Required(ErrorMessage="Nome obrigatório")]
        [MaxLength(60)]
        public string Nome { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime DataCadastro { get; set; }
        public string Rua { get; set; }
        public string Numero { get; set; }
        public string Bairro { get; set; }
        [MinLength(8, ErrorMessage = "O tamanho mínimo do CEP são 8 caracteres.")]
        [MaxLength(8, ErrorMessage = "O tamanho máximo do CEP são 8 caracteres.")]
        public string CEP { get; set; }
        [Required]
        [Display(Name = "Telefone Comercial")]
        public string TelefoneComercial { get; set; }
        public string TelefoneResidencial { get; set; }
        public int IdCidade { get; set; }
        [ForeignKey("IdCidade")]
        public Cidade Cidade { get; set; }
    }
}
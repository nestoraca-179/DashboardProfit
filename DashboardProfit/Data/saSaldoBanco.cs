//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DashboardProfit.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class saSaldoBanco
    {
        public string cod_cta { get; set; }
        public string tipo { get; set; }
        public decimal saldo { get; set; }
        public string revisado { get; set; }
        public string trasnfe { get; set; }
        public byte[] validador { get; set; }
    
        public virtual saCuentaBancaria saCuentaBancaria { get; set; }
    }
}

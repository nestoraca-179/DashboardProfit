//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DashboardProfit.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class saComisionResultado
    {
        public System.Guid co_comiresult { get; set; }
        public string co_generacion { get; set; }
        public string TablaOri { get; set; }
        public System.Guid IdOri { get; set; }
        public Nullable<decimal> Monto_01 { get; set; }
        public Nullable<decimal> Monto_02 { get; set; }
        public Nullable<decimal> Monto_03 { get; set; }
        public Nullable<decimal> Monto_04 { get; set; }
        public Nullable<decimal> Monto_05 { get; set; }
        public Nullable<decimal> Monto_06 { get; set; }
        public Nullable<decimal> Monto_07 { get; set; }
        public Nullable<decimal> Monto_08 { get; set; }
        public Nullable<decimal> Monto_09 { get; set; }
        public Nullable<decimal> Monto_10 { get; set; }
        public string Aux_01 { get; set; }
        public string Aux_02 { get; set; }
        public string Aux_03 { get; set; }
        public string Aux_04 { get; set; }
        public string Aux_05 { get; set; }
        public Nullable<System.DateTime> fecha_01 { get; set; }
        public Nullable<System.DateTime> fecha_02 { get; set; }
        public Nullable<System.DateTime> fecha_03 { get; set; }
        public Nullable<System.DateTime> fecha_04 { get; set; }
        public Nullable<System.DateTime> fecha_05 { get; set; }
        public System.DateTime fe_us_in { get; set; }
    
        public virtual saComisionGeneracion saComisionGeneracion { get; set; }
    }
}
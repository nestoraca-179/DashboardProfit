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
    
    public partial class saFacturaCompraImportacion
    {
        public string doc_num { get; set; }
        public string co_tipo_doc { get; set; }
        public string num_plan_impor { get; set; }
        public string num_exp_impor { get; set; }
        public string co_incoterm { get; set; }
        public string lugarEmbarque { get; set; }
        public string lugarDesembarque { get; set; }
        public string empresaTransporte { get; set; }
        public string documentacion { get; set; }
        public string condicionesSeguro { get; set; }
        public string empaque { get; set; }
        public string marcas { get; set; }
        public string campo1 { get; set; }
        public string campo2 { get; set; }
        public string campo3 { get; set; }
        public string campo4 { get; set; }
        public string campo5 { get; set; }
        public string campo6 { get; set; }
        public string campo7 { get; set; }
        public string campo8 { get; set; }
        public string co_us_in { get; set; }
        public string co_sucu_in { get; set; }
        public System.DateTime fe_us_in { get; set; }
        public string co_us_mo { get; set; }
        public string co_sucu_mo { get; set; }
        public System.DateTime fe_us_mo { get; set; }
        public string revisado { get; set; }
        public string trasnfe { get; set; }
        public byte[] validador { get; set; }
        public System.Guid rowguid { get; set; }
    
        public virtual saIncoterm saIncoterm { get; set; }
    }
}

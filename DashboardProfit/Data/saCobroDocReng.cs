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
    
    public partial class saCobroDocReng
    {
        public int reng_num { get; set; }
        public string cob_num { get; set; }
        public string co_tipo_doc { get; set; }
        public string nro_doc { get; set; }
        public decimal mont_cob { get; set; }
        public decimal dpcobro_porc_desc { get; set; }
        public decimal dpcobro_monto { get; set; }
        public decimal monto_retencion_iva { get; set; }
        public decimal monto_retencion { get; set; }
        public Nullable<System.Guid> reten_tercero_rowguid_ori { get; set; }
        public string tipo_doc { get; set; }
        public string num_doc { get; set; }
        public Nullable<System.Guid> rowguid_reng_ori { get; set; }
        public Nullable<int> tipo_origen { get; set; }
        public string gen_origen { get; set; }
        public string co_sucu_in { get; set; }
        public string co_us_in { get; set; }
        public System.DateTime fe_us_in { get; set; }
        public string co_sucu_mo { get; set; }
        public string co_us_mo { get; set; }
        public System.DateTime fe_us_mo { get; set; }
        public string trasnfe { get; set; }
        public string revisado { get; set; }
        public System.Guid rowguid { get; set; }
    
        public virtual saCobro saCobro { get; set; }
        public virtual saDocumentoVenta saDocumentoVenta { get; set; }
    }
}
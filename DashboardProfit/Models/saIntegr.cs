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
    
    public partial class saIntegr
    {
        public string inte_num { get; set; }
        public Nullable<System.DateTime> fec_emis { get; set; }
        public System.DateTime desde { get; set; }
        public System.DateTime hasta { get; set; }
        public Nullable<System.DateTime> feccom { get; set; }
        public Nullable<int> numcom { get; set; }
        public string des_inte { get; set; }
        public bool docnoint { get; set; }
        public bool marcar { get; set; }
        public bool val_cuad { get; set; }
        public bool compxfec { get; set; }
        public bool compxtip { get; set; }
        public int criterio { get; set; }
        public int agrupam { get; set; }
        public bool compras { get; set; }
        public bool pagos { get; set; }
        public bool dev_pro { get; set; }
        public bool ncr_pro { get; set; }
        public bool ndb_pro { get; set; }
        public bool gir_pro { get; set; }
        public bool chdev_pro { get; set; }
        public bool ventas { get; set; }
        public bool cobros { get; set; }
        public bool dev_cli { get; set; }
        public bool ncr_cli { get; set; }
        public bool ndb_cli { get; set; }
        public bool gir_cli { get; set; }
        public bool chdev_cli { get; set; }
        public bool ord_pago { get; set; }
        public bool mov_caja { get; set; }
        public bool mov_banco { get; set; }
        public bool ajustes { get; set; }
        public bool not_ent { get; set; }
        public bool com_gen { get; set; }
        public bool nomina { get; set; }
        public bool not_rec { get; set; }
        public bool todos { get; set; }
        public bool act_ultf { get; set; }
        public bool placom { get; set; }
        public bool plavent { get; set; }
        public bool ajupr { get; set; }
        public bool ajucl { get; set; }
        public bool tras_alm { get; set; }
        public bool pedidos { get; set; }
        public bool ordenes { get; set; }
        public string co_sucu_desde { get; set; }
        public string co_sucu_hasta { get; set; }
        public string co_cont_desde { get; set; }
        public string co_cont_hasta { get; set; }
        public bool ajustexdif { get; set; }
        public int orden { get; set; }
        public bool auxiliar_nom { get; set; }
        public string co_sucu_in { get; set; }
        public string co_us_in { get; set; }
        public System.DateTime fe_us_in { get; set; }
        public string co_sucu_mo { get; set; }
        public string co_us_mo { get; set; }
        public System.DateTime fe_us_mo { get; set; }
        public string campo1 { get; set; }
        public string campo2 { get; set; }
        public string campo3 { get; set; }
        public string campo4 { get; set; }
        public string campo5 { get; set; }
        public string campo6 { get; set; }
        public string campo7 { get; set; }
        public string campo8 { get; set; }
        public string trasnfe { get; set; }
        public string revisado { get; set; }
        public byte[] validador { get; set; }
        public System.Guid rowguid { get; set; }
    
        public virtual saSucursal saSucursal { get; set; }
        public virtual saSucursal saSucursal1 { get; set; }
    }
}
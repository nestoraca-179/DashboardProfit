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
    
    public partial class saCostoHistoricoEntrada
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public saCostoHistoricoEntrada()
        {
            this.saCostoHistoricoSalida1 = new HashSet<saCostoHistoricoSalida>();
        }
    
        public System.Guid cod_costo_historico_entrada { get; set; }
        public System.Guid cod_articulo_rowguid { get; set; }
        public string cod_almacen { get; set; }
        public string tipo_doc { get; set; }
        public System.Guid doc_orig { get; set; }
        public Nullable<System.Guid> cod_costo_historico_salida_orig { get; set; }
        public decimal cantidad { get; set; }
        public decimal cantidad_usada { get; set; }
        public decimal costo { get; set; }
        public decimal costo_pro { get; set; }
        public System.DateTime fecha_emision { get; set; }
        public System.DateTime fecha_registro { get; set; }
        public Nullable<System.DateTime> fecha_recepcion { get; set; }
        public int rengNum { get; set; }
        public byte[] validador { get; set; }
    
        public virtual saAlmacen saAlmacen { get; set; }
        public virtual saCostoHistoricoSalida saCostoHistoricoSalida { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saCostoHistoricoSalida> saCostoHistoricoSalida1 { get; set; }
    }
}

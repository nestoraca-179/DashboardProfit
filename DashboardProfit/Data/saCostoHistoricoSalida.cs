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
    
    public partial class saCostoHistoricoSalida
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public saCostoHistoricoSalida()
        {
            this.saCostoHistoricoEntrada = new HashSet<saCostoHistoricoEntrada>();
        }
    
        public System.Guid cod_costo_historico_salida { get; set; }
        public Nullable<System.Guid> cod_costo_historico_entrada { get; set; }
        public System.Guid cod_articulo_rowguid { get; set; }
        public System.Guid doc_orig { get; set; }
        public decimal costo_pro { get; set; }
        public decimal cantidad { get; set; }
        public string tipo_doc { get; set; }
        public byte[] validador { get; set; }
        public System.DateTime fecha_emision { get; set; }
        public string cod_almacen { get; set; }
    
        public virtual saAlmacen saAlmacen { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saCostoHistoricoEntrada> saCostoHistoricoEntrada { get; set; }
        public virtual saCostoHistoricoEntrada saCostoHistoricoEntrada1 { get; set; }
    }
}

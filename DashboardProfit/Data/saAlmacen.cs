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
    
    public partial class saAlmacen
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public saAlmacen()
        {
            this.saAjPrecioCostoAuto = new HashSet<saAjPrecioCostoAuto>();
            this.saAjusteReng = new HashSet<saAjusteReng>();
            this.saArtCompuestoGen = new HashSet<saArtCompuestoGen>();
            this.saArtCompuestoGenReng = new HashSet<saArtCompuestoGenReng>();
            this.saArtCrearAut = new HashSet<saArtCrearAut>();
            this.saArtPrecio = new HashSet<saArtPrecio>();
            this.saArtUbicacion = new HashSet<saArtUbicacion>();
            this.saCostoHistoricoEntrada = new HashSet<saCostoHistoricoEntrada>();
            this.saCostoHistoricoSalida = new HashSet<saCostoHistoricoSalida>();
            this.saCotizacionClienteReng = new HashSet<saCotizacionClienteReng>();
            this.saCotizacionProveedorReng = new HashSet<saCotizacionProveedorReng>();
            this.saDevolucionClienteReng = new HashSet<saDevolucionClienteReng>();
            this.saDevolucionProveedorReng = new HashSet<saDevolucionProveedorReng>();
            this.saFacturaCompraReng = new HashSet<saFacturaCompraReng>();
            this.saFacturaVentaReng = new HashSet<saFacturaVentaReng>();
            this.saInventarioFisico = new HashSet<saInventarioFisico>();
            this.saLoteEntrada = new HashSet<saLoteEntrada>();
            this.saLoteSalida = new HashSet<saLoteSalida>();
            this.saNotaDespachoVentaReng = new HashSet<saNotaDespachoVentaReng>();
            this.saNotaEntregaVentaReng = new HashSet<saNotaEntregaVentaReng>();
            this.saNotaRecepcionCompraReng = new HashSet<saNotaRecepcionCompraReng>();
            this.saOrdenCompraReng = new HashSet<saOrdenCompraReng>();
            this.saPedidoVentaReng = new HashSet<saPedidoVentaReng>();
            this.saPlantillaCompraReng = new HashSet<saPlantillaCompraReng>();
            this.saPlantillaVentaReng = new HashSet<saPlantillaVentaReng>();
            this.saResInventario = new HashSet<saResInventario>();
            this.saSeriales = new HashSet<saSeriales>();
            this.saStockAlmacen = new HashSet<saStockAlmacen>();
            this.saTraslado = new HashSet<saTraslado>();
            this.saTraslado1 = new HashSet<saTraslado>();
            this.saTraslado2 = new HashSet<saTraslado>();
        }
    
        public string co_alma { get; set; }
        public string des_alma { get; set; }
        public string co_sucur { get; set; }
        public bool noventa { get; set; }
        public bool nocompra { get; set; }
        public bool materiales { get; set; }
        public bool produccion { get; set; }
        public bool alm_temp { get; set; }
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
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saAjPrecioCostoAuto> saAjPrecioCostoAuto { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saAjusteReng> saAjusteReng { get; set; }
        public virtual saSucursal saSucursal { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saArtCompuestoGen> saArtCompuestoGen { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saArtCompuestoGenReng> saArtCompuestoGenReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saArtCrearAut> saArtCrearAut { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saArtPrecio> saArtPrecio { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saArtUbicacion> saArtUbicacion { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saCostoHistoricoEntrada> saCostoHistoricoEntrada { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saCostoHistoricoSalida> saCostoHistoricoSalida { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saCotizacionClienteReng> saCotizacionClienteReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saCotizacionProveedorReng> saCotizacionProveedorReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saDevolucionClienteReng> saDevolucionClienteReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saDevolucionProveedorReng> saDevolucionProveedorReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saFacturaCompraReng> saFacturaCompraReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saFacturaVentaReng> saFacturaVentaReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saInventarioFisico> saInventarioFisico { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saLoteEntrada> saLoteEntrada { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saLoteSalida> saLoteSalida { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saNotaDespachoVentaReng> saNotaDespachoVentaReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saNotaEntregaVentaReng> saNotaEntregaVentaReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saNotaRecepcionCompraReng> saNotaRecepcionCompraReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saOrdenCompraReng> saOrdenCompraReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saPedidoVentaReng> saPedidoVentaReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saPlantillaCompraReng> saPlantillaCompraReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saPlantillaVentaReng> saPlantillaVentaReng { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saResInventario> saResInventario { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saSeriales> saSeriales { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saStockAlmacen> saStockAlmacen { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saTraslado> saTraslado { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saTraslado> saTraslado1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<saTraslado> saTraslado2 { get; set; }
    }
}
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
    
    public partial class saArtCrearAut
    {
        public string co_artCrearAut { get; set; }
        public System.DateTime fecha_reg { get; set; }
        public string ArtCrearAut_des { get; set; }
        public string art_des { get; set; }
        public string tipo { get; set; }
        public string co_lin_desde { get; set; }
        public string co_lin_hasta { get; set; }
        public string co_subl_desde { get; set; }
        public string co_subl_hasta { get; set; }
        public string co_cat_desde { get; set; }
        public string co_cat_hasta { get; set; }
        public string co_color_desde { get; set; }
        public string co_color_hasta { get; set; }
        public string co_ubicacion_desde { get; set; }
        public string co_ubicacion_hasta { get; set; }
        public string co_proc_desde { get; set; }
        public string co_proc_hasta { get; set; }
        public string item_desde { get; set; }
        public string item_hasta { get; set; }
        public string co_uni { get; set; }
        public bool usar_Cod_artLin { get; set; }
        public Nullable<int> Long_Cod_artLin { get; set; }
        public Nullable<int> Orden_Cod_artLin { get; set; }
        public bool usar_Cod_artSubl { get; set; }
        public Nullable<int> Long_Cod_artSubl { get; set; }
        public Nullable<int> Orden_Cod_artSubl { get; set; }
        public bool usar_Cod_artCat { get; set; }
        public Nullable<int> Long_Cod_artCat { get; set; }
        public Nullable<int> Orden_Cod_artCat { get; set; }
        public bool usar_Cod_artColor { get; set; }
        public Nullable<int> Long_Cod_artColor { get; set; }
        public Nullable<int> Orden_Cod_artColor { get; set; }
        public bool usar_Cod_artUbicacion { get; set; }
        public Nullable<int> Long_Cod_artUbicacion { get; set; }
        public Nullable<int> Orden_Cod_artUbicacion { get; set; }
        public bool usar_Cod_artProc { get; set; }
        public Nullable<int> Long_Cod_artProc { get; set; }
        public Nullable<int> Orden_Cod_artProc { get; set; }
        public bool usar_Cod_artItem { get; set; }
        public Nullable<int> Long_Cod_artItem { get; set; }
        public Nullable<int> Orden_Cod_artItem { get; set; }
        public Nullable<bool> maneja_serial { get; set; }
        public Nullable<bool> maneja_lote { get; set; }
        public Nullable<bool> maneja_lote_venc { get; set; }
        public string tipo_imp { get; set; }
        public string tipo_imp2 { get; set; }
        public string tipo_imp3 { get; set; }
        public string co_reten { get; set; }
        public string garantia { get; set; }
        public Nullable<decimal> volumen { get; set; }
        public Nullable<decimal> peso { get; set; }
        public Nullable<decimal> stock_min { get; set; }
        public Nullable<decimal> stock_max { get; set; }
        public Nullable<decimal> stock_pedido { get; set; }
        public Nullable<int> desc_art_libre { get; set; }
        public Nullable<bool> procesado { get; set; }
        public Nullable<bool> prec_om { get; set; }
        public string comentario { get; set; }
        public string tipo_cos { get; set; }
        public string co_alma { get; set; }
        public string reten_iva_tercero { get; set; }
        public string campo1 { get; set; }
        public string campo2 { get; set; }
        public string campo3 { get; set; }
        public string campo4 { get; set; }
        public string campo5 { get; set; }
        public string campo6 { get; set; }
        public string campo7 { get; set; }
        public string campo8 { get; set; }
        public string Artcampo1 { get; set; }
        public string Artcampo2 { get; set; }
        public string Artcampo3 { get; set; }
        public string Artcampo4 { get; set; }
        public string Artcampo5 { get; set; }
        public string Artcampo6 { get; set; }
        public string Artcampo7 { get; set; }
        public string Artcampo8 { get; set; }
        public string co_us_in { get; set; }
        public string co_sucu_in { get; set; }
        public Nullable<System.DateTime> fe_us_in { get; set; }
        public string co_us_mo { get; set; }
        public string co_sucu_mo { get; set; }
        public Nullable<System.DateTime> fe_us_mo { get; set; }
        public string revisado { get; set; }
        public string trasnfe { get; set; }
        public byte[] validador { get; set; }
        public Nullable<System.Guid> rowguid { get; set; }
    
        public virtual saAlmacen saAlmacen { get; set; }
        public virtual saCatArticulo saCatArticulo { get; set; }
        public virtual saCatArticulo saCatArticulo1 { get; set; }
        public virtual saColor saColor { get; set; }
        public virtual saColor saColor1 { get; set; }
        public virtual saConISLR saConISLR { get; set; }
        public virtual saProcedencia saProcedencia { get; set; }
        public virtual saProcedencia saProcedencia1 { get; set; }
        public virtual saProveedor saProveedor { get; set; }
        public virtual saSubLinea saSubLinea { get; set; }
        public virtual saSubLinea saSubLinea1 { get; set; }
        public virtual saUbicacion saUbicacion { get; set; }
        public virtual saUbicacion saUbicacion1 { get; set; }
        public virtual saUnidad saUnidad { get; set; }
    }
}

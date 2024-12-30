<%@ Page Title="Home" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DashboardProfit.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid" ng-app="Dashboard" ng-controller="controller">
    <div class="d-flex flex-wrap justify-content-between row-gap-3 px-0 py-3 px-md-3">
        <h4 class="main-title m-0">DASHBOARD GERENCIAL</h4>
        <div class="cont-data d-flex">
            <div class="cont-rates d-flex align-items-center px-0 px-md-2">
                <small><i class="fas fa-dollar-sign text-success fw-bold mx-2"></i>Tasa BCV:</small>
                <small ng-if="!rate_usd_bcv" class="spinner-border ms-auto" role="status" aria-hidden="true" style="width: 20px; height: 20px; margin-left: 10px !important;"></small>
                <small ng-if="rate_usd_bcv" class="mx-2">{{ rate_usd_bcv }}</small>
            </div>
            <div class="d-flex gap-2 param-dates">
                <input type="date" id="dateFrom" class="form-control" />
                <input type="date" id="dateTo" class="form-control" />
                <button type="button" class="btn btn-primary d-flex gap-2" ng-click="searchStats()">
                    <i class="fa-solid fa-magnifying-glass d-flex align-items-center"></i> Buscar
                </button>
            </div>
        </div>
    </div>
    <hr class="mx-0 my-0 mx-md-3" />
    <!-- ESTADISTICAS VENTAS -->
    <h4 class="mx-0 my-3 mx-md-3 text-center">Ventas y CxC</h4>
    <div class="row m-0 row-stats">
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm p-3 card-stat" ng-click="showData('FACV')">
                <div ng-if="stats_v.totalInvoices == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_v.totalInvoices != null" id="totalInvoicesV" style="display: none;">
                    <h6>Facturas de Venta</h6>
                    <p class="m-0">{{ formatNumber(stats_v.totalInvoices).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_v.totalAmountI) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_v.totalAmountIUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-sale"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat" ng-click="showData('PEDV')">
                <div ng-if="stats_v.totalOrders == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_v.totalOrders != null" id="totalOrdersV" style="display: none;">
                    <h6>Pedidos de Venta</h6>
                    <p class="m-0">{{ formatNumber(stats_v.totalOrders).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_v.totalAmountO) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_v.totalAmountOUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-sale"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_v.totalCollects == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_v.totalCollects != null" id="totalCollectsV" style="display: none;">
                    <h6>Cobros</h6>
                    <p class="m-0">{{ formatNumber(stats_v.totalCollects).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_v.totalAmountC) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_v.totalAmountCUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-sale"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_v.totalRefunds == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_v.totalRefunds != null" id="totalRefundsV" style="display: none;">
                    <h6>Devoluciones de Venta</h6>
                    <p class="m-0">{{ formatNumber(stats_v.totalRefunds).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_v.totalAmountR) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_v.totalAmountRUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-sale"></i>
                </div>
            </div>
        </div>
    </div>
    <!-- GRAFICAS VENTAS -->
    <div class="row m-0 mt-2 row-stats">
        <div class="col-xl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!invoicesSaleByDate" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="invoicesSaleByDate && invoicesSaleByDate.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-invs-v"></div>
            </div>
        </div>
        <div class="col-xl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!ordersSaleByDate" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="ordersSaleByDate && ordersSaleByDate.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-ords-v"></div>
            </div>
        </div>
    </div>
    <div class="row m-0 mt-2 row-stats">
        <div class="col-xxl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!mostSelledArts" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="mostSelledArts && mostSelledArts.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-arts-v"></div>
            </div>
        </div>
        <div class="col-xxl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!mostActiveClients" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="mostActiveClients && mostActiveClients.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-clis"></div>
            </div>
        </div>
    </div>
    <hr class="mx-0 mt-3 mb-0 mx-md-3" />
    <!-- ESTADISTICAS COMPRAS -->
    <h4 class="mx-0 my-3 mx-md-3 text-center">Compras y CxP</h4>
    <div class="row m-0 row-stats">
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat" ng-click="showData('FACC')">
                <div ng-if="stats_c.totalInvoices == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_c.totalInvoices != null" id="totalInvoicesC" style="display: none;">
                    <h6>Facturas de Compra</h6>
                    <p class="m-0">{{ formatNumber(stats_c.totalInvoices).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_c.totalAmountI) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_c.totalAmountIUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-buy"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat" ng-click="showData('ORDC')">
                <div ng-if="stats_c.totalOrders == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_c.totalOrders != null" id="totalOrdersC" style="display: none;">
                    <h6>Ordenes de Compra</h6>
                    <p class="m-0">{{ formatNumber(stats_c.totalOrders).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_c.totalAmountO) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_c.totalAmountOUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-buy"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_c.totalPayments == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_c.totalPayments != null" id="totalPaymentsC" style="display: none;">
                    <h6>Pagos</h6>
                    <p class="m-0">{{ formatNumber(stats_c.totalPayments).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_c.totalAmountC) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_c.totalAmountCUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-buy"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_c.totalRefunds == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_c.totalRefunds != null" id="totalRefundsC" style="display: none;">
                    <h6>Devoluciones de Compra</h6>
                    <p class="m-0">{{ formatNumber(stats_c.totalRefunds).replaceAll('.00', '') }}</p>
                    <p class="sub-amount m-0">{{ formatNumber(stats_c.totalAmountR) }} Bs. D</p>
                    <p class="sub-amount fw-normal">{{ formatNumber(stats_c.totalAmountRUSD) }} $USD</p>
                    <i class="fa-solid fa-file-invoice-dollar stat-buy"></i>
                </div>
            </div>
        </div>
    </div>
    <!-- GRAFICAS COMPRAS -->
    <div class="row m-0 mt-2 row-stats">
        <div class="col-xl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!invoicesBuyByDate" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="invoicesBuyByDate && invoicesBuyByDate.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-invs-c"></div>
            </div>
        </div>
        <div class="col-xl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!ordersBuyByDate" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="ordersBuyByDate && ordersBuyByDate.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-ords-c"></div>
            </div>
        </div>
    </div>
    <div class="row m-0 mt-2 row-stats">
        <div class="col-xxl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!mostPurchasedArts" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="mostPurchasedArts && mostPurchasedArts.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-arts-c"></div>
            </div>
        </div>
        <div class="col-xxl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3">
                <div ng-if="!mostActiveSuppliers" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <h6 ng-if="mostActiveSuppliers && mostActiveSuppliers.length == 0" class="m-0 text-center fw-light">Sin Datos</h6>
                <div id="container-sups"></div>
            </div>
        </div>
    </div>
    <hr class="mx-0 mt-3 mb-0 mx-md-3" />
    <!-- ESTADISTICAS CAJA -->
    <h4 class="mx-0 my-3 mx-md-3 text-center">Tesoreria</h4>
    <div class="row m-0 mt-2 row-stats">
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_b.totalBoxesBSD == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_b.totalBoxesBSD != null" id="totalBoxesBSD" style="display: none;">
                    <h6>Total Cajas (BSD)</h6>
                    <p class="m-0">{{ formatNumber(stats_b.totalBoxesBSD) }}</p>
                    <i style="font-size: 20px;">BSD</i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_b.totalAccountsBSD == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_b.totalAccountsBSD != null" id="totalAccountsBSD" style="display: none;">
                    <h6>Total Cuentas (BSD)</h6>
                    <p class="m-0">{{ formatNumber(stats_b.totalAccountsBSD) }}</p>
                    <i style="font-size: 20px;">BSD</i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_b.totalBoxesUSD == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_b.totalBoxesUSD != null" id="totalBoxesUSD" style="display: none;">
                    <h6>Total Cajas (USD)</h6>
                    <p class="m-0">{{ formatNumber(stats_b.totalBoxesUSD) }}</p>
                    <i style="font-size: 20px;">$USD</i>
                </div>
            </div>
        </div>
        <div class="col-xl-3">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_b.totalAccountsUSD == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_b.totalAccountsUSD != null" id="totalAccountsUSD" style="display: none;">
                    <h6>Total Cuentas (USD)</h6>
                    <p class="m-0">{{ formatNumber(stats_b.totalAccountsUSD) }}</p>
                    <i style="font-size: 20px;">$USD</i>
                </div>
            </div>
        </div>
    </div>
    <div class="row m-0 mt-2 row-stats">
        <div class="col-xl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_b.totalCxC == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_b.totalCxC != null" id="totalCxC" style="display: none;">
                    <h6>Total Cuentas por Cobrar (BSD)</h6>
                    <p class="m-0">{{ formatNumber(stats_b.totalCxC) }}</p>
                    <i style="font-size: 20px;">BSD</i>
                </div>
            </div>
        </div>
        <div class="col-xl-6">
            <div class="bg-white rounded shadow-sm px-4 py-3 card-stat">
                <div ng-if="stats_b.totalCxP == null" class="d-flex align-items-center">
                    <strong>Cargando...</strong>
                    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                </div>
                <div ng-if="stats_b.totalCxP != null" id="totalCxP" style="display: none;">
                    <h6>Total Cuentas por Pagar (BSD)</h6>
                    <p class="m-0">{{ formatNumber(stats_b.totalCxP) }}</p>
                    <i style="font-size: 20px;">BSD</i>
                </div>
            </div>
        </div>
    </div>
    <hr class="mx-0 my-3 mb-0 mx-md-3" />
    <!-- MODAL TABLA -->
    <div class="modal fade modal-doc" id="modalTable" tabindex="-1">
        <div class="modal-dialog" style="max-width: 900px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{ titleTable }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div ng-if="table == null" class="d-flex justify-content-center align-items-center my-2">
                        <strong>Cargando...</strong>
                        <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                    </div>
                    <div ng-if="table != null" class="overflow-auto" style="max-height: 600px;">
                        <table class="table table-borderless table-hover table-stats">
                            <thead class="border-bottom">
                                <tr>
                                    <th>#</th>
                                    <th>Nro. Documento</th>
                                    <th>Fecha</th>
                                    <th ng-if="table[0].co_cli">Cliente</th>
                                    <th ng-if="table[0].co_prov">Proveedor</th>
                                    <th>Monto</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="t in table" ng-click="openDoc(typeDoc, t)">
                                    <td>{{ $index + 1 }}</td>
                                    <td>{{ t.doc_num }}</td>
                                    <td>{{ formatDate(t.fec_emis) }}</td>
                                    <td ng-if="t.co_cli">{{ t.cli_des }}</td>
                                    <td ng-if="t.co_prov">{{ t.prov_des }}</td>
                                    <td>{{ t.total_neto.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL DOCUMENTO -->
    <div class="modal fade modal-doc" id="modalDoc" tabindex="-1" style="background: rgba(0, 0, 0, 0.75);">
        <div class="modal-dialog" style="max-width: 900px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{ tit_doc }} {{ num_doc }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div ng-if="doc == null" class="d-flex justify-content-center align-items-center my-2">
                        <strong>Cargando...</strong>
                        <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                    </div>
                    <div ng-if="doc != null" class="info-doc">
                        <div class="row">
                            <div ng-if="doc.co_cli" class="col-6">
                                <b>Cliente:</b>
                                <p>{{ doc.co_cli }} - {{ doc.saCliente.cli_des }}</p>
                            </div>
                            <div ng-if="doc.co_prov" class="col-6">
                                <b>Proveedor:</b>
                                <p>{{ doc.co_prov }} - {{ doc.saProveedor.prov_des }}</p>
                            </div>
                            <div class="col-6">
                                <b>Moneda:</b>
                                <p>{{ doc.co_mone }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Cond. Pago:</b>
                                <p>{{ doc.co_cond }} - {{ doc.saCondicionPago.cond_des }}</p>
                            </div>
                            <div class="col-6">
                                <b>Tasa:</b>
                                <p>{{ formatNumber(doc.tasa) }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Vendedor:</b>
                                <p ng-if="doc.co_ven">{{ doc.co_ven }} - {{ doc.saVendedor.ven_des }}</p>
                                <p ng-if="!doc.co_ven">N/A</p>
                            </div>
                            <div class="col-6 d-flex align-items-center">
                                <hr class="m-0 w-100" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Nro. Control:</b>
                                <p ng-if="doc.n_control">{{ doc.n_control }}</p>
                                <p ng-if="!doc.n_control">N/A</p>
                            </div>
                            <div class="col-6">
                                <b>Total Bruto:</b>
                                <p>{{ formatNumber(doc.total_bruto) }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Fecha Emision:</b>
                                <p>{{ formatDate(doc.fec_emis) }}</p>
                            </div>
                            <div class="col-6">
                                <b>Monto IVA:</b>
                                <p>{{ formatNumber(doc.monto_imp) }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Fecha Vencimiento:</b>
                                <p>{{ formatDate(doc.fec_venc) }}</p>
                            </div>
                            <div class="col-6">
                                <b>Total Neto:</b>
                                <p>{{ formatNumber(doc.total_neto) }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Fecha Registro:</b>
                                <p>{{ formatDate(doc.fec_reg) }}</p>
                            </div>
                            <div class="col-6">
                                <b>Saldo:</b>
                                <p>{{ formatNumber(doc.saldo) }}</p>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-12">
                                <table class="table table-striped border" style="font-size: 13px;">
                                    <thead>
                                        <tr>
                                            <th>N°</th>
                                            <th>Articulo</th>
                                            <th>Cantidad</th>
                                            <th ng-if="reng.prec_vta">Precio Venta</th>
                                            <th ng-if="reng.cost_unit">Costo Unitario</th>
                                            <th>IVA</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="reng in doc.rengs">
                                            <td>{{ $index + 1 }}</td>
                                            <td>{{ reng.co_art }} - {{ reng.des_art }}</td>
                                            <td>{{ reng.total_art}}</td>
                                            <td ng-if="reng.prec_vta">{{ formatNumber(reng.prec_vta) }}</td>
                                            <td ng-if="reng.cost_unit">{{ formatNumber(reng.cost_unit) }}</td>
                                            <td>{{ formatNumber(reng.monto_imp) }}</td>
                                            <td>{{ formatNumber(reng.reng_neto) }}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>--%>
            </div>
        </div>
    </div>
</div>
<script>
    var app = angular.module("Dashboard", []);
    var options = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' };
	var today = new Date();
    today.setDate(today.getDate() - 30);
    var dateFrom = "2024-10-01"; // formatDate(today);
    var dateTo = "2024-10-31"; // formatDate(new Date());

    $("#dateFrom").val(dateFrom);
    $("#dateTo").val(dateTo);

    app.controller("controller", function ($scope, $http) {

        // CONSULTA TASA BCV
        $http.get("https://pydolarve.org/api/v1/dollar?page=bcv").then(function (response) {
            console.log(response.data);
            $scope.rate_usd_bcv = response.data.monitors.usd.price;
        });

        $scope.init = function () {
            $scope.stats_v = {};
            $scope.stats_c = {};
            $scope.stats_b = {};
            $scope.invoicesSaleByDate = null;
            $scope.ordersSaleByDate = null;
            $scope.mostSelledArts = null;
            $scope.mostActiveClients = null;
			$scope.invoicesBuyByDate = null;
			$scope.ordersBuyByDate = null;
            $scope.mostPurchasedArts = null;
            $scope.mostActiveSuppliers = null;
            $("#container-invs-v").html("");
            $("#container-ords-v").html("");
            $("#container-arts-v").html("");
			$("#container-clis").html("");
			$("#container-invs-c").html("");
			$("#container-ords-c").html("");
            $("#container-arts-c").html("");
            $("#container-sups").html("");
        }

        $scope.init();

        $scope.loadStats = function (from, to) {

            // CALCULANDO LOS 7 DIAS PREVIOS
			let diffDays = calcDiffDays(from, to) > 7 ? 7 : calcDiffDays(from, to);
            let tempDateTo = new Date(to + "T00:00:00");
            tempDateTo.setDate(tempDateTo.getDate() - diffDays);
            let date7Days = formatDate(tempDateTo);
            let datesToShow = [];

			let auxDate = formatDate(tempDateTo) + "T00:00:00";
			for (let i = 0; i <= diffDays; i++) {
                let d = convertToCustomFormat(auxDate);
                datesToShow.push(d);
                auxDate = new Date(auxDate);
                auxDate.setDate(auxDate.getDate() + 1);
                auxDate = formatDate(auxDate) + "T00:00:00";
            }

            // VENTAS

            $http.get(`/api/GetStatsSales/${from}/${to}`).then(function (response) {

                $scope.stats_v.totalInvoices = response.data.total_i;
                $scope.stats_v.totalAmountI = response.data.amount_i;
                $scope.stats_v.totalAmountIUSD = response.data.amount_i_usd;

                $scope.stats_v.totalOrders = response.data.total_o;
				$scope.stats_v.totalAmountO = response.data.amount_o;
				$scope.stats_v.totalAmountOUSD = response.data.amount_o_usd;

                $scope.stats_v.totalCollects = response.data.total_c;
                $scope.stats_v.totalAmountC = response.data.amount_c;
				$scope.stats_v.totalAmountCUSD = response.data.amount_c_usd;

                $scope.stats_v.totalRefunds = response.data.total_r;
                $scope.stats_v.totalAmountR = response.data.amount_r;
				$scope.stats_v.totalAmountRUSD = response.data.amount_r_usd;

                setTimeout(function () {
                    $("#totalInvoicesV").removeAttr("style");
                    $("#totalOrdersV").removeAttr("style");
                    $("#totalCollectsV").removeAttr("style");
                    $("#totalRefundsV").removeAttr("style");
                }, 1);
            });

            $http.get(`/api/GetSaleInvoices/${date7Days}/${to}/0`).then(function (response) {
                $scope.invoicesSaleByDate = response.data;
                if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res) {
						r.fecha_simple = convertToCustomFormat(r.fec_emis);
					}

                    var series = countByDate(res, datesToShow);
					initChartLine("container-invs-v", `Facturas de Venta por Dia (Ultimos ${diffDays} dias)`, series, date7Days);
				}
            });

            $http.get(`/api/GetSaleOrders/${date7Days}/${to}/0`).then(function (response) {
				$scope.ordersSaleByDate = response.data;
				if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res) {
						r.fecha_simple = convertToCustomFormat(r.fec_emis);
					}

					var series = countByDate(res, datesToShow);
					initChartArea("container-ords-v", `Pedidos de Venta por Dia (Ultimos ${diffDays} dias)`, series, date7Days);
				}
			});

            $http.get(`/api/GetMostSelledArts/${from}/${to}/5`).then(function (response) {
                $scope.mostSelledArts = response.data;
                if (response.data.length > 0)
                    initMostSelledArts(response.data);
            });

            $http.get(`/api/GetMostActiveClients/${from}/${to}/5`).then(function (response) {
                $scope.mostActiveClients = response.data;
                if (response.data.length > 0)
                    initMostActiveClients(response.data);
            });

            // COMPRAS

            $http.get(`/api/GetStatsPurchases/${from}/${to}`).then(function (response) {

                $scope.stats_c.totalInvoices = response.data.total_i;
				$scope.stats_c.totalAmountI = response.data.amount_i;
				$scope.stats_c.totalAmountIUSD = response.data.amount_i_usd;

                $scope.stats_c.totalOrders = response.data.total_o;
				$scope.stats_c.totalAmountO = response.data.amount_o;
				$scope.stats_c.totalAmountOUSD = response.data.amount_o_usd;

                $scope.stats_c.totalPayments = response.data.total_c;
				$scope.stats_c.totalAmountC = response.data.amount_c;
				$scope.stats_c.totalAmountCUSD = response.data.amount_c_usd;

                $scope.stats_c.totalRefunds = response.data.total_r;
				$scope.stats_c.totalAmountR = response.data.amount_r;
				$scope.stats_c.totalAmountRUSD = response.data.amount_r_usd;
                
                setTimeout(function () {
                    $("#totalInvoicesC").removeAttr("style");
                    $("#totalOrdersC").removeAttr("style");
                    $("#totalPaymentsC").removeAttr("style");
                    $("#totalRefundsC").removeAttr("style");
                }, 1);
            });

            $http.get(`/api/GetPurchaseInvoices/${date7Days}/${to}/0`).then(function (response) {
				$scope.invoicesBuyByDate = response.data;
				if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res) {
						r.fecha_simple = convertToCustomFormat(r.fec_emis);
					}

					var series = countByDate(res, datesToShow);
					initChartArea("container-invs-c", `Facturas de Compra por Dia (Ultimos ${diffDays} dias)`, series, date7Days);
				}
            });

            $http.get(`/api/GetPurchaseOrders/${date7Days}/${to}/0`).then(function (response) {
				$scope.ordersBuyByDate = response.data;
				if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res) {
						r.fecha_simple = convertToCustomFormat(r.fec_emis);
					}

					var series = countByDate(res, datesToShow);
					initChartLine("container-ords-c", `Ordenes de Compra por Dia (Ultimos ${diffDays} dias)`, series, date7Days);
				}
            });

            $http.get(`/api/GetMostPurchasedArts/${from}/${to}/5`).then(function (response) {
                $scope.mostPurchasedArts = response.data;
                if (response.data.length > 0)
                    initMostPurchasedArts(response.data);
            });

            $http.get(`/api/GetMostActiveSuppliers/${from}/${to}/5`).then(function (response) {
                $scope.mostActiveSuppliers = response.data;
                if (response.data.length > 0)
                    initMostActiveSuppliers(response.data);
            });

            // CAJA Y BANCO

            $http.get(`/api/GetStatsBalances/${from}/${to}`).then(function (response) {
                $scope.stats_b.totalBoxesBSD = response.data.total_b_bsd;
                $scope.stats_b.totalBoxesUSD = response.data.total_b_usd;
                $scope.stats_b.totalAccountsBSD = response.data.total_a_bsd;
                $scope.stats_b.totalAccountsUSD = response.data.total_a_usd;
                $scope.stats_b.totalCxC = response.data.total_cxc;
                $scope.stats_b.totalCxP = response.data.total_cxp;
                
                setTimeout(function () {
                    $("#totalBoxesBSD").removeAttr("style");
                    $("#totalBoxesUSD").removeAttr("style");
                    $("#totalAccountsBSD").removeAttr("style");
                    $("#totalAccountsUSD").removeAttr("style");
                    $("#totalCxC").removeAttr("style");
                    $("#totalCxP").removeAttr("style");
                }, 1);
            });
        }

        $scope.loadStats(dateFrom, dateTo);

        $scope.searchStats = function () {
            let from = $("#dateFrom").val(), to = $("#dateTo").val();
            $scope.init();
            $scope.loadStats(from, to);
        }

        $scope.formatDate = (date) => date != null ? new Date(date).toLocaleString("es-ES", options).replace(",", "").split(" ")[0] : "";

        $scope.formatNumber = (number) => number.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

        $scope.showData = function (type) {

            var url = "", sales = null;
            var from = $("#dateFrom").val();
            var to = $("#dateTo").val();

            $scope.typeDoc = type;
            switch (type) {
                case "FACV":
                    $scope.titleTable = "Facturas de Venta";
                    url = "GetSaleInvoices";
                    sales = true;
                    break;
				case "PEDV":
                    $scope.titleTable = "Pedidos de Venta";
                    url = "GetSaleOrders";
                    sales = true;
                    break;
                case "FACC":
					$scope.titleTable = "Facturas de Compra";
					url = "GetPurchaseInvoices";
					sales = false;
                    break;
                case "ORDC":
					$scope.titleTable = "Ordenes de Compra";
					url = "GetPurchaseOrders";
					sales = false;
                    break;
            }

            $scope.table = null;

            if ((sales && $scope.stats_v) || (!sales && $scope.stats_c)) {

				$http.get(`/api/${url}/${from}/${to}/30`).then(function (response) {
                    console.log(response);
                    $scope.table = response.data;
                });

				var modal = new bootstrap.Modal(document.getElementById('modalTable'), options);
				modal.show();
			}
		}

        $scope.openDoc = function (type, doc) {

            $scope.doc = null;

            switch (type) {
                case "FACV":
                    $scope.tit_doc = "Factura de Venta";
                    $scope.num_doc = doc.doc_num.trim();
                    break;
                case "PEDV":
                    $scope.tit_doc = "Pedido de Venta";
                    $scope.num_doc = doc.doc_num.trim();
                    break;
                case "FACC":
                    $scope.tit_doc = "Factura de Compra";
                    $scope.num_doc = doc.doc_num.trim();
                    break;
                case "ORDC":
                    $scope.tit_doc = "Orden de Compra";
                    $scope.num_doc = doc.doc_num.trim();
                    break;
            }

            $http.get(`/api/GetInfoDoc/${type}/${$scope.num_doc}`).then(function (response) {
                
                $scope.doc = response.data;
                switch (type) {
                    case "FACV":
                        $scope.doc.rengs = response.data.saFacturaVentaReng;
                        break;
                    case "PEDV":
                        $scope.doc.rengs = response.data.saPedidoVentaReng;
                        break;
                    case "FACC":
                        $scope.doc.rengs = response.data.saFacturaCompraReng;
                        break;
                    case "ORDC":
                        $scope.doc.rengs = response.data.saOrdenCompraReng;
                        break;
                }
            });

            var modal = new bootstrap.Modal(document.getElementById('modalDoc'), options);
            modal.show();
        }
    });

	function formatDate(date) {

        const y = date.getFullYear();
		const m = String(date.getMonth() + 1).padStart(2, '0');
		const d = String(date.getDate()).padStart(2, '0');

		return `${y}-${m}-${d}`;
    }

	function sortByDate(data) {
		return data.sort((a, b) => {
			const dateA = new Date(a.fec_emis);
			const dateB = new Date(b.fec_emis);
			return dateA - dateB;
		});
	}

    function convertToCustomFormat(dateString) {

		const date = new Date(dateString);
		const day = String(date.getDate()).padStart(2, '0');
		const month = String(date.getMonth() + 1).padStart(2, '0');

		return `${day}/${month}`;
    }

	function countByDate(data, dates) {
		
        const countMap = {};
        for (let d of dates) {
            var count = data.filter(i => i.fecha_simple == d).length;
            countMap[d] = count;
		}

		const result = Object.values(countMap);
		return result;
    }

	function calcDiffDays(dateStart, dateEnd) {

		const start = new Date(dateStart);
		const end = new Date(dateEnd);

		const diffMs = end - start;
		const diffDays = Math.round(diffMs / (1000 * 60 * 60 * 24));

		return diffDays;
	}

</script>
<script>

    function initChartLine(name, title, data, from7Days) {

        let [y, m, d] = from7Days.split("-");

		Highcharts.chart(name, {
			title: {
				text: title,
				margin: 40,
				align: 'left'
            },
			colors: ['#0277bd'],
			exporting: {
				enabled: false,
			},
			yAxis: {
                title: {
					text: '<b style="font-family: \'Raleway\', sans-serif;">Cantidad</b>'
				}
			},
			xAxis: {
				type: 'datetime', // Cambia el tipo a datetime
				labels: {
					formatter: function () {
						return Highcharts.dateFormat('%d/%m', this.value); // Formato de fecha
					}
				}
			},
            legend: {
                enabled: false,
			},
			plotOptions: {
				series: {
					label: {
						connectorAllowed: false
					},
					// pointStart: 2010
					pointStart: Date.UTC(y, parseInt(m) - 1, d),
                    pointInterval: 24 * 3600 * 1000,
					dataLabels: {
						enabled: true,
                        format: '{point.y}',
						padding: 15,
						style: {
                            fontWeight: 'bold'
						}
					}
				}
			},
            series: [
                {
				    name: 'Facturas',
				    data: data
                },
            ]
		});
	}

    function initChartArea(name, title, data, from7Days) {

		let [y, m, d] = from7Days.split("-");
		
		Highcharts.chart(name, {
			chart: {
				type: 'area'
			},
			title: {
				text: title,
				margin: 40,
				align: 'left'
			},
			colors: ['#028CDB'],
			exporting: {
				enabled: false,
			},
			yAxis: {
				title: {
					text: '<b style="font-family: \'Raleway\', sans-serif;">Cantidad</b>'
				}
			},
			xAxis: {
				type: 'datetime', // Cambia el tipo a datetime
				labels: {
					formatter: function () {
						return Highcharts.dateFormat('%d/%m', this.value); // Formato de fecha
					}
				}
            },
            legend: {
                enabled: false,
            },
			plotOptions: {
				area: {
					// pointStart: 1940,
					pointStart: Date.UTC(y, parseInt(m) - 1, d),
					pointInterval: 24 * 3600 * 1000,
					dataLabels: {
						enabled: true,
						format: '{point.y}',
						padding: 15,
						style: {
							fontWeight: 'bold'
						}
					},
					marker: {
						enabled: false,
						symbol: 'circle',
						radius: 2,
						states: {
							hover: {
								enabled: true
							}
						}
					}
				}
			},
			series: [{
				name: 'Pedidos',
				data: data
			}]
		});
	}

    function initMostSelledArts(prods) {

        Highcharts.chart('container-arts-v', {
            chart: {
                type: 'column'
            },
            colors: ['#0277bd', '#01579b'],
            title: {
                text: 'Articulos mas vendidos',
                margin: 40,
                align: 'left'
            },
            exporting: {
                enabled: false,
            },
            xAxis: {
                categories: prods.map(p => p.art_des),
                crosshair: true,
                accessibility: {
                    description: 'Articulos'
                },
                labels: {
                    style: {
                        fontSize: "10px"
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: '<b style="font-family: \'Raleway\', sans-serif;">Cantidad</b>'
                }
            },
            tooltip: {
                pointFormat: '<span style="color:{point.color}">Cantidad</span>: <b>{point.y}</b> Unds<br/>'
            },
            legend: {
                enabled: false
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                series: {
                    pointWidth: 50,
                },
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            series: [{
                name: 'Unidades',
                colorByPoint: true,
                data: prods.map(p => p.monto_unidad)
            }]
        });

    }

    function initMostActiveClients(clients) {

        Highcharts.setOptions({
            lang: {
                decimalPoint: ",",
                thousandsSep: "."
            }
        });

        Highcharts.chart('container-clis', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            colors: ['#0277BD', '#014B75', '#029CF5', '#012236', '#028CDB'],
            title: {
                text: 'Clientes con mas ventas',
                align: 'left'
            },
            tooltip: {
                pointFormat: '<span style="color:{point.color}">{series.name}</span>: <b>{point.y:,.2f}</b>'
            },
            accessibility: {
                point: {
                    valueSuffix: '%'
                }
            },
            exporting: {
                enabled: false,
            },
            legend: {
                itemStyle: {
                    fontSize: "10px"
                },
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        //format: '<span style="font-size: 12px"><b>{point.name}</b>' +
                        //    '</span><br>' +
                        //    '<span style="opacity: 0.6">{point.percentage:.2f} ' +
                        //    '%</span>',
                        format: '<span>{point.percentage:.2f} %</span>',
                        connectorColor: 'rgba(128,128,128,0.5)',
                        distance: -30
                    },
                    showInLegend: true
                }
            },
            series: [{
                name: 'Monto Total',
                data: clients.map(function (c) {
                    return {
                        name: c.cli_des,
                        y: c.Venta
                    };
                })
            }]
        });

    }

    function initMostPurchasedArts(prods) {

        Highcharts.chart('container-arts-c', {
            chart: {
                type: 'bar'
            },
            colors: ['#0277bd', '#01579b'],
            title: {
                text: 'Articulos mas comprados',
                margin: 40,
                align: 'left'
            },
            exporting: {
                enabled: false,
            },
            xAxis: {
                categories: prods.map(p => p.art_des),
                title: {
                    text: null
                },
                gridLineWidth: 1,
                lineWidth: 0,
                labels: {
                    style: {
                        fontSize: "10px"
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: '<b style="font-family: \'Raleway\', sans-serif;">Cantidad</b>'
                }
            },
            tooltip: {
                valueSuffix: ' Unds'
            },
            plotOptions: {
                series: {
                    pointWidth: 40,
                },
                bar: {
                    borderRadius: '5px',
                    dataLabels: {
                        enabled: true
                    },
                    groupPadding: 0.1
                }
            },
            legend: {
                enabled: false
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Unidades',
                colorByPoint: true,
                data: prods.map(p => p.monto_unidad)
            }]
        });

    }

    function initMostActiveSuppliers(suppliers) {

        Highcharts.setOptions({
            lang: {
                decimalPoint: ",",
                thousandsSep: "."
            }
        });

        Highcharts.chart('container-sups', {
            chart: {
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 45
                }
            },
            colors: ['#0277BD', '#014B75', '#029CF5', '#012236', '#028CDB'],
            title: {
                text: 'Proveedores más activos',
                align: 'left'
            },
            exporting: {
                enabled: false,
            },
            legend: {
                itemStyle: {
                    fontSize: "10px"
                },
            },
            plotOptions: {
                pie: {
                    innerSize: 100,
                    depth: 45,
                    dataLabels: {
                        enabled: true,
                        format: '<span>{point.percentage:.2f} %</span>'
                    },
                    showInLegend: true
                }
            },
            series: [{
                name: 'Monto Total',
                colorByPoint: true,
                innerSize: '50%',
                data: suppliers.map(function (s) {
                    return {
                        name: s.prov_des,
                        y: s.Compra
                    };
                })
            }]
        });

    }

</script>
</asp:Content>
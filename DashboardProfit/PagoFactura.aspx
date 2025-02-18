<%@ Page Title="Pago Facturas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PagoFactura.aspx.cs" Inherits="DashboardProfit.PagoFactura" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid" ng-app="PagoFactura" ng-controller="controller">
	<div class="d-flex flex-wrap justify-content-between row-gap-3 px-0 py-3 px-md-3">
		<h4 class="main-title m-0">Facturas de Compra</h4>
		<div class="cont-data d-flex">
			<div class="d-flex gap-2 param-dates">
				<input type="date" id="dateFrom" class="form-control" />
				<input type="date" id="dateTo" class="form-control" />
				<button type="button" class="btn btn-primary d-flex align-items-center gap-2" ng-click="searchStats()">
					<i class="fa-solid fa-magnifying-glass d-flex align-items-center"></i>Buscar
				</button>
			</div>
		</div>
	</div>
	<hr class="mx-0 my-0 mx-md-3" />
	<div class="d-flex justify-content-between align-items-center mx-0 my-0 mt-3 mx-md-3">
        <h6 class="m-0">- Facturas por Articulo</h6>
		<div class="d-flex align-items-center">
			<p class="mx-2 my-0">Mostrar Top</p>
            <select class="form-select" style="width: 75px; padding: 5px 10px; font-size: 12px;" ng-model="topView" ng-options="value for value in options" ng-disabled="!sorted || sorted.length == 0"></select>
		</div>
	</div>
	<div ng-if="sorted.length > 0" class="accordion px-0 py-3 px-md-3" id="accordionInvoices">
		<div ng-repeat="s in sorted | limitTo: topView" class="accordion-item">
			<h4 class="accordion-header" id="heading{{ $index + 1 }}">
				<button class="accordion-button collapsed" type="button" style="font-size: 12px; padding: 10px 15px;" data-bs-toggle="collapse" data-bs-target="#collapse{{ $index + 1 }}" aria-expanded="false" aria-controls="collapse{{ $index + 1 }}">
					{{ s.name }} - <b>Total: {{ s.count }}</b>
				</button>
			</h4>
			<div id="collapse{{ $index + 1 }}" class="accordion-collapse collapse" aria-labelledby="heading{{ $index + 1 }}" data-bs-parent="#accordionInvoices">
				<div class="accordion-body">
					<table class="table table-borderless table-hover table-stats">
						<thead class="border-bottom">
							<tr>
								<th>#</th>
								<th>Nro. Documento</th>
								<th>Proveedor</th>
								<th>Fecha Factura</th>
								<th>Almacen</th>
								<th>Unidad</th>
								<th>Costo Unitario</th>
								<th>Cantidad</th>
								<th>Monto Base</th>
								<th>IVA</th>
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="i in filtered(s.name)" ng-click="openDoc(i)">
								<td>{{ $index + 1 }}</td>
								<td>{{ i.doc_num.trim() }}</td>
								<td>{{ i.co_prov.trim() }} {{ i.prov_des.trim() }}</td>
								<td>{{ formatDate(i.fec_emis) }}</td>
								<td>{{ i.co_alma.trim() }}</td>
								<td>{{ i.co_uni.trim() }}</td>
								<td>{{ formatNumber(i.cost_unit) }}</td>
								<td>{{ i.total_art }}</td>
								<td>{{ formatNumber(i.monto_base) }}</td>
								<td>{{ formatNumber(i.iva) }}</td>
								<td>{{ formatNumber(i.neto) }}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
    <p ng-if="!sorted || sorted.length == 0" class="mx-0 my-0 mt-3 mx-md-3">No hay resultados...</p>
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
                            <div class="col-6">
                                <b>Proveedor:</b>
                                <p class="ms-2" style="word-break: break-word;">{{ doc.co_prov }} - {{ doc.saProveedor.prov_des }}</p>
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
            </div>
        </div>
    </div>
    <!-- MODAL LOADING -->
    <div class="modal fade modal-info" id="modalLoading" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width: 800px; margin: 0 auto;">
            <div class="modal-content">
                <div class="modal-body" style="max-height: 450px; overflow-y: auto; padding: 45px;">
                    <div style="display: flex; justify-content: center;">
                        <i class="fas fa-spinner fa-spin" style="color: #01579b; font-size: 7em;"></i>
                    </div>
                    <h1 class="text-center mt-5">Cargando datos...</h1>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL ERROR -->
    <div class="modal fade modal-info" id="modalError" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width: 800px; margin: 0 auto;">
            <div class="modal-content">
                <div class="modal-body" style="max-height: 450px; overflow-y: auto; padding: 45px;">
                    <div style="display: flex; justify-content: center;">
                        <i class="fas fa-exclamation-triangle py-5" style="color: var(--bs-red); font-size: 7em;"></i>
                    </div>
                    <h2 class="text-center">Ha ocurrido un error</h2>
                    <p class="text-center">{{ errorMessage }}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="$('#modalError').modal('hide');">Aceptar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="hiddenFieldJsonInv" runat="server" />
<asp:HiddenField ID="hiddenFieldJsonSorted" runat="server" />
<script>
	var app = angular.module("PagoFactura", []);
	var options = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' };
	var json_invoices = $('#<%= hiddenFieldJsonInv.ClientID %>').val();
	var json_sorted = $('#<%= hiddenFieldJsonSorted.ClientID %>').val();
	var invoices = JSON.parse(json_invoices);
	var sorted = JSON.parse(json_sorted);
	var today = new Date();
	today.setDate(today.getDate() - 30);
    var dateFrom = formatDate(today); // "2024-10-01"; // formatDate(today);
    var dateTo = formatDate(new Date()); // "2024-10-31"; // formatDate(new Date());

	$("#dateFrom").val(dateFrom);
	$("#dateTo").val(dateTo);

	app.controller("controller", function ($scope, $http) {

		$scope.invoices = invoices;
        $scope.sorted = sorted;
		$scope.options = [5, 10, 25, 50, 75, 100];
        $scope.topView = 5;

        $scope.filtered = (name) => $scope.invoices.filter(i => i.art_des.trim() == name);

		$scope.searchStats = function () {
            let from = $("#dateFrom").val();
            let to = $("#dateTo").val();

            if (!from || !to) {
                $scope.errorMessage = "Debes agregar una fecha de " + (from ? "Fin" : "Inicio");
                $("#modalError").modal("show");
                return;
			}

			$("#modalLoading").modal("show");
            $http.get(`/api/GetInvoicesByArt/${from}/${to}/0`).then(function (response) {

                let res = response.data;
                let countingArts = {};
				let newArray = [];
				setTimeout(function () { $("#modalLoading").modal("hide"); }, 500);

				res.forEach(item => {
					let nameArt = item.art_des.trim();
					countingArts[nameArt] = (countingArts[nameArt] || 0) + 1;
				});

                newArray = Object.keys(countingArts).map(n => ({
					name: n,
                    count: countingArts[n]
                })).sort((a, b) => b.count - a.count);

                $scope.sorted = newArray;
                $scope.invoices = res;
            });
        }

        $scope.openDoc = function (doc) {

            $scope.doc = null;
			$scope.tit_doc = "Factura de Compra";
            $scope.num_doc = doc.doc_num.trim();

			$http.get(`/api/GetInfoDoc/FACC/${$scope.num_doc}`).then(function (response) {
				$scope.doc = response.data;
				$scope.doc.rengs = response.data.saFacturaCompraReng;
            });

			var modal = new bootstrap.Modal(document.getElementById('modalDoc'), options);
			modal.show();
		}

		$scope.formatDate = (date) => date != null ? new Date(date).toLocaleString("es-ES", options).replace(",", "").split(" ")[0] : "";

		$scope.formatNumber = (number) => number.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
	});

	function formatDate(date) {

		const y = date.getFullYear();
		const m = String(date.getMonth() + 1).padStart(2, '0');
		const d = String(date.getDate()).padStart(2, '0');

		return `${y}-${m}-${d}`;
	}

</script>
</asp:Content>
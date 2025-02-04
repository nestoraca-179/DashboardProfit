<%@ Page Title="Pago Ordenes" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="PagoOrden.aspx.cs" Inherits="DashboardProfit.PagoOrden" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid" ng-app="PagoOrden" ng-controller="controller">
	<div class="d-flex flex-wrap justify-content-between row-gap-3 px-0 py-3 px-md-3">
		<h4 class="main-title m-0">Ordenes de Pago</h4>
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
        <h6 class="m-0">- Ordenes por Numero</h6>
		<div class="d-flex align-items-center">
			<p class="mx-2 my-0">Mostrar Top</p>
            <select class="form-select" style="width: 75px; padding: 5px 10px; font-size: 12px;" ng-model="topView" ng-options="value for value in options" ng-disabled="!orders || orders.length == 0"></select>
		</div>
	</div>
	<div ng-if="orders.length > 0" class="px-0 py-3 px-md-3">
		<table class="table table-borderless table-hover table-stats shadow-sm bg-white">
			<thead class="border-bottom">
				<tr>
					<th>#</th>
					<th>Nro. Orden</th>
					<th>Beneficiario</th>
					<th>Fecha</th>
					<th>Monto</th>
					<th>Moneda</th>
					<th>Caja / Cuenta</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="o in getUniqueDocs() | limitTo: topView" ng-click="openDoc(o)">
					<td>{{ $index + 1 }}</td>
					<td>{{ o.ord_num.trim() }}</td>
					<td>{{ o.cod_ben.trim() }} {{ o.ben_des.trim() }}</td>
					<td>{{ formatDate(o.fecha) }}</td>
					<td>{{ formatNumber(o.total_neto) }}</td>
					<td>{{ o.co_mone.trim() }}</td>
					<td ng-if="o.cod_caja">Caja: {{ o.cod_caja }}</td>
					<td ng-if="!o.cod_caja">Cuenta: {{ o.cod_cta }}</td>
					<td>{{ setStatus(o.status.trim()) }}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<p ng-if="!orders || orders.length == 0" class="mx-0 my-0 mt-3 mx-md-3">No hay resultados...</p>
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
                                <b>Beneficiario:</b>
                                <p class="ms-2" style="word-break: break-word;">{{ doc.cod_ben }} - {{ doc.saBeneficiario.ben_des }}</p>
                            </div>
							<div class="col-6">
								<b>Caja:</b>
								<p ng-if="doc.cod_caja">{{ doc.cod_caja }}</p>
								<p ng-if="!doc.cod_caja">N/A</p>
							</div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Status:</b>
                                <p>{{ setStatus(doc.status) }}</p>
                            </div>
							<div class="col-6">
								<b>Cuenta:</b>
								<p ng-if="doc.cod_cta">{{ doc.cod_cta }}</p>
								<p ng-if="!doc.cod_cta">N/A</p>
							</div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Fecha:</b>
                                <p>{{ formatDate(doc.fecha) }}</p>
                            </div>
                            <div class="col-6">
                                <b>Moneda:</b>
                                <p>{{ doc.co_mone }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Fecha Pago:</b>
                                <p>{{ formatDate(doc.fec_pag) }}</p>
                            </div>
                            <div class="col-6">
                                <b>Tasa:</b>
                                <p>{{ formatNumber(doc.tasa) }}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <b>Forma Pago:</b>
                                <p>{{ setType(doc.forma_pag) }}</p>
                            </div>
                            <div class="col-6 d-flex align-items-center">
                                <hr class="m-0 w-100" />
                            </div>
                        </div>
						<div class="row">
							<div class="col-6">
								<b>Concepto:</b>
								<p class="ms-2" style="word-break: break-word;">{{ doc.descrip }}</p>
							</div>
							<div class="col-6">
								<b>Total:</b>
								<p>{{ formatNumber(doc.total_neto) }}</p>
							</div>
						</div>
                        <hr />
                        <div class="row">
                            <div class="col-12">
                                <table class="table table-striped border" style="font-size: 13px;">
                                    <thead>
                                        <tr>
                                            <th>N°</th>
                                            <th>Cuenta I/E</th>
                                            <th>Descripcion</th>
                                            <th>Debe</th>
                                            <th>Haber</th>
                                            <th>IVA</th>
                                            <th>Monto IVA</th>
                                            <th>Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr ng-repeat="reng in doc.rengs">
                                            <td>{{ $index + 1 }}</td>
                                            <td>{{ reng.co_cta_ingr_egr }}</td>
                                            <td>{{ reng.saCuentaIngEgr.descrip }}</td>
                                            <td>{{ formatNumber(reng.monto_d) }}</td>
                                            <td>{{ formatNumber(reng.monto_h) }}</td>
                                            <td ng-if="reng.tipo_imp == '1'">IVA 16%</td>
                                            <td ng-if="reng.tipo_imp == '7'">Exentos</td>
                                            <td>{{ formatNumber(reng.monto_iva) }}</td>
                                            <td>{{ formatNumber(reng.monto_obj) }}</td>
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
<asp:HiddenField ID="hiddenFieldJsonOrd" runat="server" />
<script>
	var app = angular.module("PagoOrden", []);
	var options = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' };
	var json_orders = $('#<%= hiddenFieldJsonOrd.ClientID %>').val();
	var orders = JSON.parse(json_orders);
	var today = new Date();
	today.setDate(today.getDate() - 30);
	var dateFrom = formatDate(today); // "2024-10-01"; // formatDate(today);
	var dateTo = formatDate(new Date()); // "2024-10-31"; // formatDate(new Date());

	$("#dateFrom").val(dateFrom);
	$("#dateTo").val(dateTo);

	app.controller("controller", function ($scope, $http) {

		$scope.orders = orders;
		$scope.options = [5, 10, 25, 50, 75, 100];
		$scope.topView = 5;

		$scope.getUniqueDocs = function () {
			var uniqueDocs = [];
			var uniqueKeys = {};

			angular.forEach($scope.orders, function (item) {
				if (!uniqueKeys[item.ord_num]) {
					uniqueKeys[item.ord_num] = true;
					item.total_neto = $scope.setTotal($scope.orders.filter(o => o.ord_num == item.ord_num));
					uniqueDocs.push(item);
				}
			});

			return uniqueDocs;
		};

		$scope.searchStats = function () {
			let from = $("#dateFrom").val();
			let to = $("#dateTo").val();

			if (!from || !to) {
				$scope.errorMessage = "Debes agregar una fecha de " + (from ? "Fin" : "Inicio");
				$("#modalError").modal("show");
				return;
			}

			$("#modalLoading").modal("show");
			$http.get(`/api/GetOrdersByNum/${from}/${to}/0`).then(function (response) {
				$scope.orders = response.data;
				setTimeout(function () { $("#modalLoading").modal("hide"); }, 500);
			});
        }

		$scope.openDoc = function (doc) {

			$scope.doc = null;
			$scope.tit_doc = "Orden de Pago";
			$scope.num_doc = doc.ord_num.trim();

			$http.get(`/api/GetInfoDoc/ORDP/${$scope.num_doc}`).then(function (response) {
				$scope.doc = response.data;
				$scope.doc.rengs = response.data.saOrdenPagoReng;
				$scope.doc.total_neto = $scope.setTotal($scope.doc.rengs);
			});

			var modal = new bootstrap.Modal(document.getElementById('modalDoc'), options);
			modal.show();
		}

		$scope.setStatus = function (status) {
			let s;

			switch (status) {
				case "S":
					s = "PENDIENTE";
					break;
				case "C":
					s = "CANCELADO";
					break;
				case "R":
					s = "REVERSADO";
					break;
				default:
					s = status;
					break;
			}

			return s;
        }

		$scope.setType = function (type) {
			let t;

			switch (type) {
				case "EF":
					t = "Efectivo";
					break;
				case "TR":
					t = "Transferencia";
					break;
				case "CH":
					t = "Cheque";
					break;
				default:
					t = type;
					break;
			}

			return t;
		}

		$scope.setTotal = (rengs) => rengs.reduce((acc, curr) => { return acc + (curr.monto_d - curr.monto_h); }, 0);

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
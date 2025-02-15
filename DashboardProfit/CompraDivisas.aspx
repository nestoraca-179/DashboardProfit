<%@ Page Title="Compra Divisas" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="CompraDivisas.aspx.cs" Inherits="DashboardProfit.CompraDivisas" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .container-form {
        padding-bottom: 10px;
    }
    .container-form label, .container-form .btn.btn-primary,
    .container-form input, .modal td {
        font-size: 14px;
    }
    .container-form button.btn-primary {
        width: 300px !important;
    }
    .container-stats .row {
        row-gap: 10px;
    }
    .card-stat p {
        font-size: 20px;
    }
    @media screen and (max-width: 564px) {
        .container-form .form-group {
            flex-direction: column;
        }
        .container-form .form-group label {
            width: 100%;
            margin: 5px 0;
            text-align: left;
        }
        .container-form .form-group .input-search, .container-form .form-group .ms-2 {
            width: 100%;
            margin-left: 0 !important;
        }
        .container-form button.btn-primary {
            width: 100% !important;
        }
    }
    @media screen and (max-width: 1199px) {
        .container-stats {
            margin-top: 20px !important;
        }
    }
    @media screen and (min-width: 1200px) {
        .bg-white.rounded {
            margin-left: 10px;
        }
    }
</style>
<div class="container-fluid" id="form-op" ng-app="CompraDivisas" ng-controller="controller">
	<div class="d-flex flex-wrap justify-content-between row-gap-3 px-0 py-3 px-md-3">
		<h4 class="main-title m-0">Compra Divisas</h4>
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
	<div class="container-form mx-0 my-0 mt-3 mx-md-3">
		<div class="row m-0">
			<div class="col-xl-6 p-0">
                <div class="form-group d-flex align-items-center">
			        <label style="flex: 1;">Beneficiario (*): </label>
			        <div class="input-search d-flex ms-2" style="flex: 2;">
                        <input type="text" class="form-control" id="ben" ng-model="order.cod_ben" ng-required="true" ng-readonly="true" style="flex: 1;" />
                        <input type="text" class="form-control mx-1" id="des_ben" ng-model="order.saCondicionPago.des_bend" ng-required="true" ng-readonly="true" style="flex: 3;" />
                        <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBenefs')" data-name="ben" style="width: 40px;"></i>
                    </div>
		        </div>
		        <div class="form-group d-flex align-items-center mt-1">
			        <label style="flex: 1;">Cuenta Ingr/Egr (*): </label>
			        <div class="input-search d-flex ms-2" style="flex: 2;">
                        <input type="text" class="form-control" id="acc" ng-model="order.co_cta_ingr_egr" ng-required="true" ng-readonly="false" style="flex: 1;" />
                        <input type="text" class="form-control mx-1" id="des_acc" ng-model="order.saCuentaIngEgr.descrip" ng-required="true" ng-readonly="true" style="flex: 3;" />
                        <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalAccounts')" data-name="acc" style="width: 40px;"></i>
                    </div>
		        </div>
                <hr />
		        <h6>Origen (BSD)</h6>
		        <div class="form-group d-flex align-items-center mt-1">
			        <label class="form-check-label" style="flex: 1;">
                        <input type="checkbox" class="form-check-input me-2" ng-model="useBoxO" ng-click="reset($event, true, true);" />Caja:
			        </label>
			        <div class="input-search d-flex ms-2" style="flex: 2;">
                        <input type="text" class="form-control" id="box_o" ng-model="order.cod_caja" ng-required="true" ng-readonly="true" style="flex: 1;" ng-disabled="!useBoxO" />
                        <input type="text" class="form-control mx-1" id="des_box_o" ng-model="order.saCaja.descrip" ng-required="true" ng-readonly="true" style="flex: 3;" ng-disabled="!useBoxO" />
                        <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBoxes')" data-name="box_o" style="width: 40px;"></i>
                    </div>
		        </div>
		        <div class="form-group d-flex align-items-center mt-1">
                    <label class="form-check-label" style="flex: 1;">
                        <input type="checkbox" class="form-check-input me-2" ng-model="useBankO" ng-click="reset($event, false, true);" />Cuenta Bancaria:
                    </label>
			        <div class="input-search d-flex ms-2" style="flex: 2;">
                        <input type="text" class="form-control" id="bacc_o" ng-model="order.cod_cta" ng-required="true" ng-readonly="true" style="flex: 1;" ng-disabled="!useBankO" />
                        <input type="text" class="form-control mx-1" id="des_bacc_o" ng-model="order.saCuentaBancaria.num_cta" ng-required="true" ng-readonly="true" style="flex: 3;" ng-disabled="!useBankO" />
                        <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBankAccounts')" data-name="bacc_o" style="width: 40px;"></i>
                    </div>
		        </div>
                <div class="form-group d-flex align-items-center mt-1">
                    <label style="flex: 1;">Ref. Transferencia: </label>
			        <div class="ms-2" style="flex: 2;">
				        <input type="text" class="form-control" id="doc_num" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" ng-model="order.doc_num" ng-required="true" ng-disabled="!useBankO" />
			        </div>
		        </div>
		        <hr />
		        <h6>Destino (USD)</h6>
                <div class="form-group d-flex align-items-center mt-1">
			        <label class="form-check-label" style="flex: 1;">
                        <input type="checkbox" class="form-check-input me-2" ng-model="useBoxD" ng-click="reset($event, true, false);" />Caja:
			        </label>
			        <div class="input-search d-flex ms-2" style="flex: 2;">
                        <input type="text" class="form-control" id="box_d" ng-model="order.box_d" ng-required="true" ng-readonly="true" style="flex: 1;" ng-disabled="!useBoxD" />
                        <input type="text" class="form-control mx-1" id="des_box_d" ng-model="order.des_box_d" ng-required="true" ng-readonly="true" style="flex: 3;" ng-disabled="!useBoxD" />
                        <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBoxes')" data-name="box_d" style="width: 40px;"></i>
                    </div>
		        </div>
		        <div class="form-group d-flex align-items-center mt-1">
                    <label class="form-check-label" style="flex: 1;">
                        <input type="checkbox" class="form-check-input me-2" ng-model="useBankD" ng-click="reset($event, false, false);" />Cuenta Bancaria:
                    </label>
			        <div class="input-search d-flex ms-2" style="flex: 2;">
                        <input type="text" class="form-control" id="bacc_d" ng-model="order.bacc_d" ng-required="true" ng-readonly="true" style="flex: 1;" ng-disabled="!useBankD" />
                        <input type="text" class="form-control mx-1" id="des_bacc_d" ng-model="order.des_bacc_d" ng-required="true" ng-readonly="true" style="flex: 3;" ng-disabled="!useBankD" />
                        <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBankAccounts')" data-name="bacc_d" style="width: 40px;"></i>
                    </div>
		        </div>
		        <hr />
                <div class="form-group d-flex align-items-center mt-1">
                    <label style="flex: 1;">Monto a comprar $USD (*)</label>
			        <div class="ms-2" style="flex: 2;">
				        <input type="text" class="form-control" onkeypress="return (event.charCode >= 46 && event.charCode <= 57)" ng-model="order.saOrdenPagoReng[0].monto_d" ng-required="true" />
			        </div>
		        </div>
		        <div class="form-group d-flex align-items-center mt-1">
                    <label style="flex: 1;">Tasa (*)</label>
			        <div class="ms-2" style="flex: 2;">
				        <input type="text" class="form-control" onkeypress="return (event.charCode >= 46 && event.charCode <= 57)" ng-model="order.tasa" ng-required="true" />
			        </div>
                </div>
                <div class="form-group d-flex mt-1">
                    <label style="flex: 1;">Comentario</label>
			        <div class="ms-2" style="flex: 2;">
				        <textarea class="form-control" style="height: 75px; font-size: 14px; resize: none;" ng-model="order.descrip" ng-required="true"></textarea>
			        </div>
                </div>
		        <div class="d-flex flex-wrap justify-content-between align-items-center mt-3">
		            <small class="mt-2">(*) Campo Obligatorio</small>
                    <button type="button" class="btn btn-primary w-100 mt-3" ng-click="sendOrder()">Generar Orden Pago</button>
		        </div>
			</div>
			<div class="container-stats col-xl-6 p-0">
				<div class="row m-0">
                    <div class="col-xl-6 px-0">
                        <div class="bg-white rounded shadow-sm p-3 card-stat">
                            <div ng-if="stats_op.totalAmountI == null" class="d-flex align-items-center">
                                <strong>Cargando...</strong>
                                <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                            </div>
                            <div ng-if="stats_op.totalAmountI != null" id="totalInvoices" style="display: none;">
                                <h6>Ventas Generadas</h6>
                                <p class="m-0">{{ formatNumber(stats_op.totalAmountIUSD) }} $USD</p>
                                <p class="sub-amount m-0">{{ formatNumber(stats_op.totalAmountI) }} Bs. D</p>
                                <i class="fa-solid fa-file-invoice-dollar stat-sale"></i>
                            </div>
                        </div>
				    </div>
                    <div class="col-xl-6 px-0">
                        <div class="bg-white rounded shadow-sm p-3 card-stat">
                            <div ng-if="stats_op.totalAmountO == null" class="d-flex align-items-center">
                                <strong>Cargando...</strong>
                                <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                            </div>
                            <div ng-if="stats_op.totalAmountO != null" id="totalOrders" style="display: none;">
                                <h6>Compras de Divisas</h6>
                                <p class="m-0">{{ formatNumber(stats_op.totalAmountOUSD) }} $USD</p>
                                <p class="sub-amount m-0">{{ formatNumber(stats_op.totalAmountO) }} Bs. D</p>
                                <i class="fa-solid fa-file-invoice-dollar stat-sale"></i>
                            </div>
                        </div>
				    </div>
				</div>
				<div class="row mx-0 mt-2">
					<div class="col-xl-12 px-0">
                        <div class="bg-white rounded shadow-sm p-3 card-stat">
                            <div ng-if="stats_op.totalAmountI == null" class="d-flex align-items-center">
                                <strong>Cargando...</strong>
                                <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                            </div>
                            <div ng-if="stats_op.totalAmountI != null " id="totalDiff" style="display: none;">
                                <h6>Vendido vs Comprado</h6>
                                <p class="m-0 {{ getDiff(true) >= 0 ? 'text-success' : 'text-danger' }}">{{ formatNumber(getDiff(false)) }} $USD</p>
                                <p class="sub-amount m-0 {{ getDiff(true) >= 0 ? 'text-success' : 'text-danger' }}">{{ formatNumber(getDiff(true)) }} Bs. D</p>
                                <p class="sub-amount fw-normal {{ getDiff(true) >= 0 ? 'text-success' : 'text-danger' }}">{{ formatNumber(getPorcDiff()) }}%</p>
                                <i class="fa-solid {{ getDiff(true) >= 0 ? 'fa-arrow-trend-up text-success' : 'fa-arrow-trend-down text-danger' }}"></i>
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
    <!-- MODAL SUCCESS -->
    <div class="modal fade modal-info" id="modalSuccess" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width: 800px; margin: 0 auto;">
            <div class="modal-content">
                <div class="modal-body" style="max-height: 450px; overflow-y: auto; padding: 45px;">
                    <div style="display: flex; justify-content: center;">
                        <i class="fas fa-check-circle py-5" style="color: var(--bs-green); font-size: 7em;"></i>
                    </div>
                    <h2 class="text-center">{{ successMessage }}</h2>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="$('#modalSuccess').modal('hide');">Aceptar</button>
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
	<!-- Modal 1 -->
    <div class="modal fade" id="modalBenefs" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Buscar Beneficiario</h5>
                    <button type="button" class="btn close" data-dismiss="modal" aria-label="Cerrar" onclick="$('#modalBenefs').modal('hide');">
						<span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 450px; overflow-y: auto">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Buscar beneficiario..." onkeyup="search('modalBenefs')" />
                    </div>
                    <table class="table table-bordered table-hover table-striped mt-3" id="results">
                        <tr ng-repeat="benef in benefs" style="cursor: pointer" onclick="selectRow(this)">
                            <td>{{ benef.cod_ben }}</td>
                            <td>{{ benef.ben_des }}</td>
                        </tr>
                    </table>
                    <input type="hidden" id="name-input" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#modalBenefs').modal('hide');">Cerrar</button>
                    <button type="button" class="btn btn-primary" onclick="saveRow('modalBenefs')">Seleccionar</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Modal 2 -->
    <div class="modal fade" id="modalAccounts" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Buscar Cuenta de Ingr/Egr</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar" onclick="$('#modalAccounts').modal('hide');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 450px; overflow-y: auto">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Buscar cuenta..." onkeyup="search('modalAccounts')" />
                    </div>
                    <table class="table table-bordered table-hover table-striped mt-3" id="results">
                        <tr ng-repeat="account in accounts" style="cursor: pointer" onclick="selectRow(this)">
                            <td>{{ account.co_cta_ingr_egr }}</td>
                            <td>{{ account.descrip }}</td>
                        </tr>
                    </table>
                    <input type="hidden" id="name-input" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#modalAccounts').modal('hide');">Cerrar</button>
                    <button type="button" class="btn btn-primary" onclick="saveRow('modalAccounts');">Seleccionar</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Modal 3 -->
    <div class="modal fade" id="modalBoxes" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Buscar Caja</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar" onclick="$('#modalBoxes').modal('hide');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 450px; overflow-y: auto">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Buscar caja..." onkeyup="search('modalBoxes')" />
                    </div>
                    <table class="table table-bordered table-hover table-striped mt-3" id="results">
                        <tr ng-repeat="box in boxes" style="cursor: pointer" onclick="selectRow(this)">
                            <td>{{ box.cod_caja }}</td>
                            <td>{{ box.descrip }} ({{ box.co_mone.trim() }})</td>
                        </tr>
                    </table>
                    <input type="hidden" id="name-input" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#modalBoxes').modal('hide');">Cerrar</button>
                    <button type="button" class="btn btn-primary" onclick="saveRow('modalBoxes');">Seleccionar</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Modal 4 -->
    <div class="modal fade" id="modalBankAccounts" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Buscar Cuenta</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar" onclick="$('#modalBankAccounts').modal('hide');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: 450px; overflow-y: auto">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Buscar cuenta..." onkeyup="search('modalBankAccounts')" />
                    </div>
                    <table class="table table-bordered table-hover table-striped mt-3" id="results">
                        <tr ng-repeat="bacc in bankAccounts" style="cursor: pointer" onclick="selectRow(this)">
                            <td>{{ bacc.cod_cta }}</td>
                            <td>{{ bacc.num_cta }} ({{ bacc.co_mone.trim() }})</td>
                        </tr>
                    </table>
                    <input type="hidden" id="name-input" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#modalBankAccounts').modal('hide');">Cerrar</button>
                    <button type="button" class="btn btn-primary" onclick="saveRow('modalBankAccounts');">Seleccionar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="hiddenFieldJsonBen" runat="server" />
<asp:HiddenField ID="hiddenFieldJsonBox" runat="server" />
<asp:HiddenField ID="hiddenFieldJsonAcc" runat="server" />
<asp:HiddenField ID="hiddenFieldJsonAie" runat="server" />
<script>
	var app = angular.module("CompraDivisas", []);
	var benefs = JSON.parse($('#<%= hiddenFieldJsonBen.ClientID %>').val());
	var boxes = JSON.parse($('#<%= hiddenFieldJsonBox.ClientID %>').val());
	var bankAccounts = JSON.parse($('#<%= hiddenFieldJsonAcc.ClientID %>').val());
    var accounts = JSON.parse($('#<%= hiddenFieldJsonAie.ClientID %>').val());
	var isNullOrEmpty = (str) => str == null || str == "";
	var today = new Date();
	// today.setDate(today.getDate() - 30);
	var dateFrom = formatDate(today); // "2024-10-01"; // formatDate(today);
	var dateTo = formatDate(new Date()); // "2024-10-31"; // formatDate(new Date());

	$("#dateFrom").val(dateFrom);
	$("#dateTo").val(dateTo);

	app.controller("controller", function ($scope, $http) {

		$scope.benefs = benefs;
		$scope.accounts = accounts;
		$scope.boxes = boxes.filter(b => !b.inactivo);
		$scope.bankAccounts = bankAccounts.filter(b => !b.inactivo);

        $scope.init = function () {
            $scope.stats_op = {};
			$scope.order = { saOrdenPagoReng: [] };
			$scope.useBoxO = false;
			$scope.useBankO = false;
			$scope.useBoxD = false;
			$scope.useBankD = false;
			$(".container-form input, .container-form textarea").val("");
			$scope.loadStats(dateFrom, dateTo);
        }

        $scope.loadStats = function (from, to) {
			$http.get(`/api/GetStatsPayOrders/${from}/${to}`).then(function (response) {
				$scope.stats_op.totalAmountI = response.data.amount_i;
				$scope.stats_op.totalAmountIUSD = response.data.amount_i_usd;
				$scope.stats_op.totalAmountO = response.data.amount_o;
				$scope.stats_op.totalAmountOUSD = response.data.amount_o_usd;

				setTimeout(function () {
					$("#totalInvoices").removeAttr("style");
					$("#totalOrders").removeAttr("style");
					$("#totalDiff").removeAttr("style");
				}, 1);
			});
		}

		$scope.searchStats = function () {
			let from = $("#dateFrom").val(), to = $("#dateTo").val();
			$scope.init();
			$scope.loadStats(from, to);
        }

        $scope.getDiff = (isBsd) => isBsd ? $scope.stats_op.totalAmountI - $scope.stats_op.totalAmountO : $scope.stats_op.totalAmountIUSD - $scope.stats_op.totalAmountOUSD;

        $scope.getPorcDiff = function () {
            var temp = ($scope.stats_op.totalAmountO * 100) / $scope.stats_op.totalAmountI;
            return temp *= (temp > 100 ? -1 : 1);
		}

        $scope.reset = function ($event, isBox, isOrigin) {
            if (isOrigin) {
                if (isBox) {
                    if (!$scope.useBankO) {
                        $("#box_o").val("");
                        $("#des_box_o").val("");
                    } else {
                        alert("La opcion de cuenta bancaria de origen ya esta marcada");
                        $event.preventDefault();
                        return;
                    }
                } else {
                    if (!$scope.useBoxO) {
                        $("#bacc_o").val("");
                        $("#des_bacc_o").val("");
                        $scope.order.fec_pag = null;
						$scope.order.doc_num = null;
                    } else {
						alert("La opcion de caja de origen ya esta marcada");
                        $event.preventDefault();
                        return;
                    }
                }
            } else {
				if (isBox) {
					if (!$scope.useBankD) {
						$("#box_d").val("");
						$("#des_box_d").val("");
					} else {
						alert("La opcion de cuenta bancaria de destino ya esta marcada");
						$event.preventDefault();
						return;
					}
				} else {
					if (!$scope.useBoxD) {
						$("#bacc_d").val("");
						$("#des_bacc_d").val("");
					} else {
						alert("La opcion de caja de destino ya esta marcada");
						$event.preventDefault();
						return;
					}
				}
			}
		}

        $scope.sendOrder = function () {

            // PRINCIPAL
            if (isNullOrEmpty($("#ben").val())) {
                alert("Debes agregar el beneficiario");
                return;
            }

			if (isNullOrEmpty($("#acc").val())) {
				alert("Debes agregar la cuenta de ingreso/egreso");
                return;
            }

            // ORIGEN
            if (!$scope.useBoxO && !$scope.useBankO) {
				alert("Debes seleccionar en origen una caja o cuenta bancaria");
                return;
			}

            if ($scope.useBoxO && isNullOrEmpty($("#box_o").val())) {
				alert("Debes agregar la caja de origen");
				return;
            }

            if ($scope.useBankO && isNullOrEmpty($("#bacc_o").val())) {
				alert("Debes agregar la cuenta bancaria de origen");
				return;
			}

			if ($scope.useBankO && isNullOrEmpty($("#doc_num").val())) {
				alert("Debes agregar la referencia de la transferencia");
				return;
			}

            // DESTINO
			if (!$scope.useBoxD && !$scope.useBankD) {
				alert("Debes seleccionar en destino una caja o cuenta bancaria");
				return;
			}

			if ($scope.useBoxD && isNullOrEmpty($("#box_d").val())) {
				alert("Debes agregar la caja de destino");
				return;
			}

			if ($scope.useBankD && isNullOrEmpty($("#bacc_d").val())) {
				alert("Debes agregar la cuenta bancaria de destino");
				return;
            }

            // MONTO
            if (isNullOrEmpty($scope.order.saOrdenPagoReng[0]?.monto_d)) {
				alert("Debes agregar el monto a comprar");
				return;
            }

            if (isNullOrEmpty($scope.order.tasa)) {
				alert("Debes agregar la tasa de cambio");
				return;
			}

            $("#modalLoading").modal("show");
            $scope.order.cod_ben = $("#ben").val();
            $scope.order.saOrdenPagoReng[0].co_cta_ingr_egr = $("#acc").val();
            $scope.order.cod_caja = isNullOrEmpty($("#box_o").val()) ? null : $("#box_o").val();
            $scope.order.cod_cta = isNullOrEmpty($("#bacc_o").val()) ? null : $("#bacc_o").val();
            $scope.order.campo7 = $scope.useBoxD;
			$scope.order.campo8 = isNullOrEmpty($("#box_d").val()) ? $("#bacc_d").val() : $("#box_d").val();

			var req = {
				method: 'POST',
				url: '/api/AddPayOrder/',
				data: $scope.order,
				headers: {
					'Content-Type': 'application/json'
				},
            }

            $http(req).then(function (response) {
                var res = response.data;
				setTimeout(function () { $("#modalLoading").modal("hide"); }, 200);

                if (res.Status == "OK") {
					console.log(res.Result);                    $scope
                    $scope.init();
                    $scope.successMessage = `Orden de Pago Nro. ${res.Result.ord_num.trim()} generada con exito`;
					$("#modalSuccess").modal("show");
                } else {
                    $scope.errorMessage = res.Message;
					$("#modalError").modal("show");
				}
            });
		}

		$scope.formatDate = (date) => date != null ? new Date(date).toLocaleString("es-ES", options).replace(",", "").split(" ")[0] : "";

		$scope.formatNumber = (number) => number.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

        $scope.init();
	});

	function formatDate(date) {

		const y = date.getFullYear();
		const m = String(date.getMonth() + 1).padStart(2, '0');
		const d = String(date.getDate()).padStart(2, '0');

		return `${y}-${m}-${d}`;
	}

	function searchBenef(value) {
		return benefs.find(c => c.cod_ben.trim() == value.trim()).ben_des;
	}

	function searchAccount(value) {
		return accounts.find(c => c.co_cta_ingr_egr.trim() == value.trim()).descrip;
	}

	function searchBox(value) {
		return boxes.find(b => b.cod_caja.trim() == value.trim()).descrip;
	}

	function searchBankAccount(value) {
		return bankAccounts.find(b => b.cod_cta.trim() == value.trim()).num_cta;
	}

	function openModal(elem, modal) {

		var previous = elem.previousElementSibling;

		if (!previous.disabled) {

			$("#" + modal).find("#name-input").val($(elem).data("name"));
			$("#" + modal).modal("show");

		}
	}

	function search(modal) {
		var value = $("#" + modal).find("input[type=text]").val().toLowerCase(),
			table = $("#" + modal).find("#results")[0];

		for (var i = 0; i < table.rows.length; i++) {

			var row = table.rows[i];
			var elems = row.getElementsByTagName("td");

			var val1 = elems[0].innerHTML.toLocaleLowerCase(), val2 = elems[1].innerHTML.toLocaleLowerCase();

			if (!val1.includes(value) && !val2.includes(value))
				row.style.display = "none";
			else
				row.style.display = "";
		}
	}

	function selectRow(elem) {
		var previous = document.getElementsByClassName("selected-row")[0];

		if (previous != null) {
			previous.classList.remove("selected-row");
		}

		elem.classList.add("selected-row");
	}

	function saveRow(modal) {
		var item = document.getElementsByClassName("selected-row")[0];

		if (item != null) {
			var elem = item.children[0],
				value = elem.innerHTML,
				input = $("#" + modal).find("#name-input").val(),
				rows = [...($("#" + modal).find("#results")[0].rows)];

			$("#" + input).val(value.trim());
			$(".selected-row")[0].classList.remove("selected-row");
			$("#" + modal).find("input[type=text]").val("");
			$("#" + modal).find("button[name=search-btn]").trigger("click");

            if (input == "ben") {
                $("#des_ben").val(searchBenef(value));
            } else if (input == "acc") {
                $("#des_acc").val(searchAccount(value));
            } else if (input == "box_o") {
                $("#des_box_o").val(searchBox(value));
            } else if (input == "box_d") {
                $("#des_box_d").val(searchBox(value));
            } else if (input == "bacc_o") {
                $("#des_bacc_o").val(searchBankAccount(value));
            } else if (input == "bacc_d") {
				$("#des_bacc_d").val(searchBankAccount(value));
			}

			rows.forEach(row => row.style.display = "");
			$("#" + modal).modal("hide");
		} else {
			alert("Debes seleccionar un item");
		}
	}

</script>
</asp:Content>
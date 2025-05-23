<%@ Page Title="Dia Consolidado (Linea)" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DashboardLinea.aspx.cs" Inherits="DashboardProfit.DashboardLinea" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid" ng-app="DashboardLine" ng-controller="controller">
	<div class="d-flex flex-wrap justify-content-between row-gap-3 px-0 py-3 px-md-3">
        <h4 class="main-title m-0">DASHBOARD GERENCIAL (LINEA)</h4>
        <div class="cont-data d-flex">
            <div class="cont-rates d-flex align-items-center px-0 px-md-2">
                <small><i class="fas fa-dollar-sign text-success fw-bold mx-2"></i>Tasa BCV:</small>
                <small ng-if="!rate_usd_bcv" class="spinner-border ms-auto" role="status" aria-hidden="true" style="width: 20px; height: 20px; margin-left: 10px !important;"></small>
                <small ng-if="rate_usd_bcv" class="mx-2">{{ rate_usd_bcv }}</small>
            </div>
            <div class="d-flex gap-2 param-dates">
                <input type="date" id="dateFrom" class="form-control" />
                <input type="date" id="dateTo" class="form-control" />
                <button type="button" class="btn btn-primary d-flex align-items-center gap-2" ng-click="searchStats()">
                    <i class="fa-solid fa-magnifying-glass d-flex align-items-center"></i> Buscar
                </button>
            </div>
        </div>
    </div>
    <hr class="mx-0 my-0 mx-md-3" />
	<!-- GRAFICAS VENTAS -->
	<h4 class="mx-0 my-3 mx-md-3 text-center">Ventas y CxC</h4>
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
    <hr class="mx-0 mt-3 mb-0 mx-md-3" />
	<!-- GRAFICAS COMPRAS -->
	<h4 class="mx-0 my-3 mx-md-3 text-center">Compras y CxP</h4>
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
	<hr class="mx-0 my-3 mb-0 mx-md-3" />
</div>
<script>
    var app = angular.module("DashboardLine", []);
	var options = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' };
	var today = new Date();
	today.setDate(today.getDate() - 30);
	var dateFrom = formatDate(today); // "2024-10-01"; // formatDate(today);
	var dateTo = formatDate(new Date()); // "2024-10-31"; // formatDate(new Date());

	$("#dateFrom").val(dateFrom);
    $("#dateTo").val(dateTo);

    app.controller("controller", function ($scope, $http) {

		// CONSULTA TASA BCV
		$http.get("https://pydolarve.org/api/v1/dollar?page=bcv").then(function (response) {
			console.log(response.data);
			$scope.rate_usd_bcv = response.data.monitors.usd.price;
		});

		$scope.init = function () {
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
			//$("#container-arts-v").html("");
			//$("#container-clis").html("");
			//$("#container-invs-c").html("");
			//$("#container-ords-c").html("");
			//$("#container-arts-c").html("");
			//$("#container-sups").html("");
		}

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

			$http.get(`/api/GetSaleInvoicesLine/${date7Days}/${to}/0`).then(function (response) {
				$scope.invoicesSaleByDate = response.data;
				if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res)
						r.fecha_simple = convertToCustomFormat(r.fec_emis);

					let new_data = [];
					let separated = Object.groupBy(res, item => item.campo1);
					for (let i in separated) {
						new_data.push({
							name: i,
							data: countByDate(separated[i], datesToShow)
						});
					}

					initChartLine("container-invs-v", `Facturas de Venta por Linea por Dia (Ultimos ${diffDays} dias)`, new_data, date7Days);
				}
			});
			
			$http.get(`/api/GetSaleOrdersLine/${date7Days}/${to}/0`).then(function (response) {
				$scope.ordersSaleByDate = response.data;
				if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res)
						r.fecha_simple = convertToCustomFormat(r.fec_emis);

					let new_data = [];
					let separated = Object.groupBy(res, item => item.campo1);
					for (let i in separated) {
						new_data.push({
							name: i,
							data: countByDate(separated[i], datesToShow)
						});
					}

					initChartArea("container-ords-v", `Pedidos de Venta por Linea por Dia (Ultimos ${diffDays} dias)`, new_data, date7Days);
				}
			});

			// COMPRAS

			$http.get(`/api/GetPurchaseInvoicesLine/${date7Days}/${to}/0`).then(function (response) {
				$scope.invoicesBuyByDate = response.data;
				if (response.data.length) {
					var res = sortByDate(response.data);
					for (let r of res)
						r.fecha_simple = convertToCustomFormat(r.fec_emis);

					let new_data = [];
					let separated = Object.groupBy(res, item => item.campo1);
					for (let i in separated) {
						new_data.push({
							name: i,
							data: countByDate(separated[i], datesToShow)
						});
					}

					initChartArea("container-invs-c", `Facturas de Compra por Linea por Dia (Ultimos ${diffDays} dias)`, new_data, date7Days);
				}
			});

			$http.get(`/api/GetPurchaseOrdersLine/${date7Days}/${to}/0`).then(function (response) {
				$scope.ordersBuyByDate = response.data;
				if (response.data.length > 0) {
					var res = sortByDate(response.data);
					for (let r of res)
						r.fecha_simple = convertToCustomFormat(r.fec_emis);

					let new_data = [];
					let separated = Object.groupBy(res, item => item.campo1);
					for (let i in separated) {
						new_data.push({
							name: i,
							data: countByDate(separated[i], datesToShow)
						});
					}

					initChartLine("container-ords-c", `Ordenes de Compra por Linea por Dia (Ultimos ${diffDays} dias)`, new_data, date7Days);
				}
			});
		}

		$scope.searchStats = function () {
			let from = $("#dateFrom").val(), to = $("#dateTo").val();
			$scope.init();
			$scope.loadStats(from, to);
		}

		$scope.init();
		$scope.loadStats(dateFrom, dateTo);
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
			colors: ['#0277bd', '#e74c3c', '#2ecc71', '#f1c40f', '#d35400', '#8e44ad', '#2c3e50'],
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
				enabled: true,
			},
			plotOptions: {
				series: {
					label: {
						connectorAllowed: false
					},
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
			series: data
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
			colors: ['#0277bd', '#e74c3c', '#2ecc71', '#f1c40f', '#d35400', '#8e44ad', '#2c3e50'],
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
				enabled: true,
			},
			plotOptions: {
				area: {
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
			series: data
		});
	}

</script>
</asp:Content>
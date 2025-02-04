<%@ Page Title="Compra Divisas" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="CompraDivisas.aspx.cs" Inherits="DashboardProfit.CompraDivisas" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid" ng-app="CompraDivisas" ng-controller="controller">
	<div class="d-flex flex-wrap justify-content-between row-gap-3 px-0 py-3 px-md-3">
		<h4 class="main-title m-0">Compra Divisas</h4>
		<!--<div class="cont-data d-flex">
			<div class="d-flex gap-2 param-dates">
				<input type="date" id="dateFrom" class="form-control" />
				<input type="date" id="dateTo" class="form-control" />
				<button type="button" class="btn btn-primary d-flex align-items-center gap-2" ng-click="searchStats()">
					<i class="fa-solid fa-magnifying-glass d-flex align-items-center"></i>Buscar
				</button>
			</div>
		</div>-->
	</div>
	<hr class="mx-0 my-0 mx-md-3" />
	<div class="container-form mx-0 my-0 mt-3 mx-md-3">
		<div class="form-group d-flex align-items-center w-50">
			<label style="flex: 1;">Beneficiario: </label>
			<div class="input-search d-flex ms-2" style="flex: 2;">
                <input type="text" class="form-control" id="ben" ng-model="order.cod_ben" ng-required="true" ng-readonly="true" style="flex: 1;" />
                <input type="text" class="form-control mx-1" id="des_bend" ng-model="order.saCondicionPago.des_bend" ng-required="true" ng-readonly="true" style="flex: 3;" />
                <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" data-name="ben" style="width: 40px;"></i>
            </div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
			<label style="flex: 1;">Cuenta Ingr/Egr: </label>
			<div class="input-search d-flex ms-2" style="flex: 2;">
                <input type="text" class="form-control" id="acc" ng-model="order.co_cta_ingr_egr" ng-required="true" ng-readonly="true" style="flex: 1;" />
                <input type="text" class="form-control mx-1" id="des_acc" ng-model="order.saCuentaIngEgr.descrip" ng-required="true" ng-readonly="true" style="flex: 3;" />
                <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" data-name="acc" style="width: 40px;"></i>
            </div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
            <label style="flex: 1;">Monto $USD</label>
			<div class="ms-2" style="flex: 2;">
				<input type="text" class="form-control" onkeypress="return (event.charCode >= 46 && event.charCode <= 57)" ng-model="order.saOrdenPagoReng[0].monto_d" ng-required="true" />
			</div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
            <label style="flex: 1;">Tasa</label>
			<div class="ms-2" style="flex: 2;">
				<input type="text" class="form-control" onkeypress="return (event.charCode >= 46 && event.charCode <= 57)" ng-model="order.tasa" ng-required="true" />
			</div>
        </div>
        <div class="form-group d-flex align-items-center w-50 mt-1">
            <label style="flex: 1;">Comentario</label>
			<div class="ms-2" style="flex: 2;">
				<textarea class="form-control" style="font-size: 14px; resize: none;" ng-model="order.descrip" ng-required="true"></textarea>
			</div>
        </div>
	</div>
</div>
<script>
	var app = angular.module("CompraDivisas", []);

	app.controller("controller", function ($scope, $http) {

	});
</script>
</asp:Content>
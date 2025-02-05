<%@ Page Title="Compra Divisas" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="CompraDivisas.aspx.cs" Inherits="DashboardProfit.CompraDivisas" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .container-form label, .container-form .btn.btn-primary, 
    .container-form input, .modal td {
        font-size: 14px;
    }
</style>
<div class="container-fluid" id="form-op" ng-app="CompraDivisas" ng-controller="controller">
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
			<label style="flex: 1;">Beneficiario (*): </label>
			<div class="input-search d-flex ms-2" style="flex: 2;">
                <input type="text" class="form-control" id="ben" ng-model="order.cod_ben" ng-required="true" ng-readonly="true" style="flex: 1;" />
                <input type="text" class="form-control mx-1" id="des_ben" ng-model="order.saCondicionPago.des_bend" ng-required="true" ng-readonly="true" style="flex: 3;" />
                <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBenefs')" data-name="ben" style="width: 40px;"></i>
            </div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
			<label style="flex: 1;">Cuenta Ingr/Egr (*): </label>
			<div class="input-search d-flex ms-2" style="flex: 2;">
                <input type="text" class="form-control" id="acc" ng-model="order.co_cta_ingr_egr" ng-required="true" ng-readonly="false" style="flex: 1;" />
                <input type="text" class="form-control mx-1" id="des_acc" ng-model="order.saCuentaIngEgr.descrip" ng-required="true" ng-readonly="true" style="flex: 3;" />
                <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalAccounts')" data-name="acc" style="width: 40px;"></i>
            </div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
			<label class="form-check-label" style="flex: 1;">
                <input type="checkbox" class="form-check-input me-2" ng-model="useBox" ng-click="reset($event, true);" />Caja: 
			</label>
			<div class="input-search d-flex ms-2" style="flex: 2;">
                <input type="text" class="form-control" id="box" ng-model="order.cod_caja" ng-required="true" ng-readonly="true" style="flex: 1;" ng-disabled="!useBox" />
                <input type="text" class="form-control mx-1" id="des_box" ng-model="order.saCaja.descrip" ng-required="true" ng-readonly="true" style="flex: 3;" ng-disabled="!useBox" />
                <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBoxes')" data-name="box" style="width: 40px;"></i>
            </div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
            <label class="form-check-label" style="flex: 1;">
                <input type="checkbox" class="form-check-input me-2" ng-model="useBank" ng-click="reset($event, false);" />Cuenta Bancaria: 
            </label>
			<div class="input-search d-flex ms-2" style="flex: 2;">
                <input type="text" class="form-control" id="bacc" ng-model="order.cod_cta" ng-required="true" ng-readonly="true" style="flex: 1;" ng-disabled="!useBank" />
                <input type="text" class="form-control mx-1" id="des_bacc" ng-model="order.saCuentaBancaria.num_cta" ng-required="true" ng-readonly="true" style="flex: 3;" ng-disabled="!useBank" />
                <i class="fas fa-search d-flex justify-content-center align-items-center rounded bg-primary text-light p-2" role="button" onclick="openModal(this, 'modalBankAccounts')" data-name="bacc" style="width: 40px;"></i>
            </div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
            <label style="flex: 1;">Monto a comprar $USD (*)</label>
			<div class="ms-2" style="flex: 2;">
				<input type="text" class="form-control" onkeypress="return (event.charCode >= 46 && event.charCode <= 57)" ng-model="order.saOrdenPagoReng[0].monto_d" ng-required="true" />
			</div>
		</div>
		<div class="form-group d-flex align-items-center w-50 mt-1">
            <label style="flex: 1;">Tasa (*)</label>
			<div class="ms-2" style="flex: 2;">
				<input type="text" class="form-control" onkeypress="return (event.charCode >= 46 && event.charCode <= 57)" ng-model="order.tasa" ng-required="true" />
			</div>
        </div>
        <div class="form-group d-flex w-50 mt-1">
            <label style="flex: 1;">Comentario</label>
			<div class="ms-2" style="flex: 2;">
				<textarea class="form-control" style="height: 100px; font-size: 14px; resize: none;" ng-model="order.descrip" ng-required="true"></textarea>
			</div>
        </div>
		<div class="d-flex justify-content-between align-items-center w-50 mt-3">
		    <small class="mt-2">(*) Campo Obligatorio</small>
            <button type="button" class="btn btn-primary mt-3" ng-click="sendOrder()">Generar Orden Pago</button>
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
                            <td>{{ box.descrip }}</td>
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
                            <td>{{ bacc.num_cta }}</td>
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

	app.controller("controller", function ($scope, $http) {

        $scope.order = { saOrdenPagoReng: [] };
		$scope.benefs = benefs;
		$scope.boxes = boxes;
		$scope.bankAccounts = bankAccounts;
        $scope.accounts = accounts;
        $scope.useBox = false;
        $scope.useBank = false;

        $scope.reset = function ($event, isBox) {
            if (isBox) {
                if (!$scope.useBank) {
                    $("#box").val("");
                    $("#des_box").val("");
                } else {
                    alert("La opcion de cuenta bancaria ya esta marcada");
					$event.preventDefault();
                    return;
				}
            } else {
				if (!$scope.useBox) {
					$("#bacc").val("");
					$("#des_bacc").val("");
				} else {
					alert("La opcion de caja ya esta marcada");
					$event.preventDefault();
					return;
				}
			}
		}

        $scope.sendOrder = function () {

            if (isNullOrEmpty($("#ben").val())) {
                alert("Debes agregar el beneficiario");
                return;
            }

			if (isNullOrEmpty($("#acc").val())) {
				alert("Debes agregar la cuenta de ingreso/egreso");
                return;
            }

            if (!$scope.useBox && !$scope.useBank) {
				alert("Debes seleccionar caja o cuenta bancaria");
                return;
			}

            if ($scope.useBox && isNullOrEmpty($("#box").val())) {
				alert("Debes agregar la caja");
				return;
            }

            if ($scope.useBank && isNullOrEmpty($("#bacc").val())) {
				alert("Debes agregar la cuenta bancaria");
				return;
            }

            if (isNullOrEmpty($scope.order.saOrdenPagoReng[0]?.monto_d)) {
				alert("Debes agregar el monto a comprar");
				return;
            }

            if (isNullOrEmpty($scope.order.tasa)) {
				alert("Debes agregar la tasa de cambio");
				return;
			}

            $scope.order.cod_ben = $("#ben").val();
            $scope.order.saOrdenPagoReng[0].co_cta_ingr_egr = $("#acc").val();
            $scope.order.cod_caja = isNullOrEmpty($("#box").val()) ? null : $("#box").val();
			$scope.order.cod_cta = isNullOrEmpty($("#bacc").val()) ? null : $("#bacc").val();
            
            console.log($scope.order);
            alert("En desarrollo...");
		}

	});

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
			} else if (input == "box") {
				$("#des_box").val(searchBox(value));
			} else if (input == "bacc") {
				$("#des_bacc").val(searchBankAccount(value));
			}

			rows.forEach(row => row.style.display = "");
			$("#" + modal).modal("hide");
		} else {
			alert("Debes seleccionar un item");
		}
	}

</script>
</asp:Content>
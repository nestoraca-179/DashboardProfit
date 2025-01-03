﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeleccionSucursal.aspx.cs" Inherits="DashboardProfit.SeleccionSucursal" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Seleccion Sucursal | Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="/Content/Site.css" rel="stylesheet" />
<style>
    section.container-fluid {
        width: 100%;
        height: auto;
        min-height: 100vh;
        background: rgb(4,52,128);
        background: linear-gradient(90deg, rgba(4,52,128,1) 0%, rgba(2,0,33,1) 100%);
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .container { 
        width: 847px; 
        min-height: 100vh; /* Permalink - use to edit and share this gradient: https://colorzilla.com/gradient-editor/#0f0c29+0,302b63+100 */ 
        background: #0f0c29; /* Old browsers */ 
        background: -moz-linear-gradient(left, #0f0c29 0%, #302b63 100%); /* FF3.6-15 */ 
        background: -webkit-linear-gradient(left, #0f0c29 0%,#302b63 100%); /* Chrome10-25,Safari5.1-6 */ 
        background: linear-gradient(to right, #0f0c29 0%,#302b63 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */ 
    }
    form {
        width: 100%;
        min-height: 600px !important;
        max-width: 1200px;
        background: rgba(0, 0, 0, 0.5);
        margin: 10px 0;
        padding: 20px 0 10px 0;
        display: flex;
        flex-direction: column;
        /*justify-content: center;*/
        color: #f0f0f0;
        overflow-y: auto;
    }
    .title-login {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .title-login p {
        font-size: 14px;
    }
    .container-cards {
        flex: 5;
        display: flex;
        justify-content: center;
        align-items: center;
	    flex-wrap: wrap;
    }
    .card-prod {
        width: 100%;
        max-width: 275px;
        height: 125px;
        background: #0d6efd;
        margin: 10px;
        padding: 0 15px;
        display: flex;
        justify-content: space-around;
        align-items: center;
        border-radius: 5px;
        cursor: pointer;
    }
    .card-prod i {
        color: #083a84;
        font-size: 4em;
    }
    .card-prod h5 {
        max-width: 150px;
        margin: 0;
	    font-size: 15px;
    }
    .card-prod.selected-card {
        outline: solid #FFF 5px;
    }
    .btn-primary {
	    min-width: 275px;
    }
</style>
</head>
<body>
    <section class="container-fluid">
        <form id="form1" runat="server">
            <div class="title-login pt-4 pb-2">
                <h1 class="text-center">Seleccionar Sucursal</h1>
            </div>
            <div class="container-cards my-2 px-3">
                <% foreach (DashboardProfit.Data.saSucursal suc in sucs) { %>
                    <div class="card-prod shadow-lg" id="<%= suc.co_sucur.Trim() %>">
			            <i class="fas fa-building"></i>
			            <h5 class="text-white font-weight-bold"><%= suc.sucur_des.Trim() %></h5>
                    </div>
                <% } %>
            </div>
            <asp:HiddenField ID="HDD_Connect" runat="server" ClientIDMode="Static"></asp:HiddenField>
            <div class="col-md-12 text-center pt-2 pb-4">
                <asp:Button ID="BTN_Send" runat="server" CssClass="btn btn-primary w-75 px-2 px-md-5 py-3 disabled" OnClick="BTN_Send_Click" style="text-transform: none;" 
                    ClientIDMode="Static" OnClientClick="javascript:$('#BTN_Send').addClass('disabled', 'true'); submitted = true;" Text="Seleccionar sucursal" AutoPostBack="false">
                </asp:Button>
            </div>
        </form>
    </section>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
    <script>
        var submitted = false;

        $(document).ready(function () {
            $(".card-prod").hide().fadeIn(1500);
        });

        $(".card-prod").click(function () {
            if (!submitted) {
                $(".card-prod.selected-card").removeClass("selected-card");
                $(this).addClass("selected-card");
                $("#HDD_Connect").val(this.id);

                if ($("#BTN_Send").hasClass('disabled')) {
                    $("#BTN_Send").removeClass("disabled");
                }
            }
        });

    </script>
</body>
</html>
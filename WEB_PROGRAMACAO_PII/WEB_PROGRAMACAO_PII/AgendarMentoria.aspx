<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgendarMentoria.aspx.cs" Inherits="TelaAluno.AgendarMentoria" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Agendar Mentoria</title>
    <style>
        body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f8f8f8;
        color: #465d67;
        }
        .pagina-agendar-mentoria {
         padding-top: 96px;
         padding-bottom: 40px;
        }
        .cabecalho {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background-color: #ffffff;
        border-bottom: 1px solid #dde3e6;
        padding: 12px 24px;
        box-sizing: border-box;
        }
        .conteudo-cabecalho {
         max-width: 1200px;
         margin: 0 auto;
         display: flex;
         justify-content: space-between;
         align-items: center;
        }
        .logo-sistema {
        height: 48px;
        vertical-align: middle;
        }

        .titulo-cabecalho {
        font-size: 26px;
        font-weight: bold;
        margin-left: 12px;
        vertical-align: middle;
        }

        .BtnVoltar{
         background-color: #ad0f0a;
         color: #ffffff;
         border: none;
         border-radius: 6px;
         padding: 10px 18px;
         font-size: 14px;
         font-weight: bold;
         cursor: pointer;
        }

        .card-agendamento {
         max-width: 780px;
         margin: 0 auto;
         background-color: #ffffff;
         border-radius: 8px;
         border: 1px solid #dde3e6;
         padding: 24px;
         box-sizing: border-box;
        }

        .titulo-card {
        margin-top: 0;
        margin-bottom: 20px;
        }

        .campo-grupo {
        margin-bottom: 14px;
        }

        .campo-grupo span {
        display: block;
        font-weight: 600;
        margin-bottom: 6px;
        color: #333;
        }

        .campo-select {
        width: 100%;
        height: 40px;
        padding: 6px 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        background-color: #fff;
        font-size: 14px;
        box-sizing: border-box;
        }

        .area-agendar {
        margin-top: 20px;
        padding: 14px;
        background-color: #465d67;
        border-radius: 6px;
        text-align: center;
        }

        .btn-agendar {
         background-color: #ad0f0a;
         color: #ffffff;
         border: none;
         border-radius: 6px;
         padding: 10px 18px;
         font-size: 14px;
         font-weight: bold;
         cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pagina-agendar-mentoria">
            <header class="cabecalho">
                <div class="conteudo-cabecalho">
                    <div>
                        <img class="logo-sistema" src="FATEC.png" alt="Logo do sistema" />
                        <span class="titulo-cabecalho">Agendar Mentoria</span>
                    </div>
                    <div class="btn-cabecalho">
                    <asp:Button ID="BtnVoltar" runat="server" Text="Voltar" CssClass="BtnVoltar" OnClick="BtnVoltar_Click" />
                    </div>
                </div>
           </header>

            <main class="card-agendamento">
                <h2 class="titulo-card">Dados do Agendamento</h2>

               <div class="campo-grupo">
                   <asp:Label ID="LblMentor" runat="server" Text="Selecione o Mentor"></asp:Label>
                   <asp:DropDownList ID="ddlMentor" runat="server" CssClass="campo-select" AutoPostBack="true" OnSelectedIndexChanged="ddlMentor_SelectedIndexChanged"></asp:DropDownList>
               </div>

               <div class="campo-grupo">
                   <asp:Label ID="LblMateria" runat="server" Text="Selecione a Matéria"></asp:Label>
                    <asp:DropDownList ID="ddlMateria" runat="server" CssClass="campo-select"></asp:DropDownList>
               </div>

               <div class="campo-grupo">
                   <asp:Label ID="LblDia" runat="server" Text="Selecione o Dia"></asp:Label>
                    <asp:DropDownList ID="ddlDia" runat="server" CssClass="campo-select" AutoPostBack="true" OnSelectedIndexChanged="ddlDia_SelectedIndexChanged"></asp:DropDownList>
               </div>

               <div class="campo-grupo">
                   <asp:Label ID="LblHorario" runat="server" Text="Selecione o Horário"></asp:Label>
                    <asp:DropDownList ID="ddlHorario" runat="server" CssClass="campo-select"></asp:DropDownList>
               </div>

                <asp:Label ID="lblMensagem" runat="server" CssClass="mensagem-status" Visible="false"></asp:Label>

                <div class="area-agendar">
                    <asp:Button ID="BtnAgendar" runat="server" Text="Agendar" CssClass="btn-agendar" OnClick="BtnAgendar_Click"/>
                </div>
            </main>
       </div>
    </form>
</body>
</html>


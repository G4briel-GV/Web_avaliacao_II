<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfirmaMentoria.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.ConfirmaMentoria" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Confirmação - Agendamento</title>
    <style>
         body {
         margin: 0;
         font-family: Arial, sans-serif;
         background-color: #f8f8f8;
         color: #465d67;
         padding-top: 96px;
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
             z-index: 100;
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
         }

         .titulo-cabecalho {
             font-size: 26px;
             font-weight: bold;
             margin-left: 12px;
         }

         .btnSair {
             background-color: #ad0f0a;
             color: #ffffff;
             border: none;
             border-radius: 6px;
             padding: 10px 18px;
             font-size: 14px;
             font-weight: bold;
             cursor: pointer;
         }

         .card {
            max-width: 720px;
            margin: 0 auto 18px auto;
            padding: 24px;
            background-color: #ffffff;
            border-radius: 6px;
            border: 1px solid #e0e0e0;
        }

        .titulo-card {
            margin-top: 0;
            margin-bottom: 12px;
            font-size: 20px;
        }

        .mensagem-confirmacao {
            display: block;
            font-size: 16px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="cabecalho">
            <div class="conteudo-cabecalho">
                <div>
                    <img class="logo-sistema" src="FATEC.png" alt="Logo do sistema" />
                    <span class="titulo-cabecalho">Área do Aluno</span>
                </div>
                <asp:Button ID="BtnVoltar" runat="server" Text="Voltar" CssClass="btnSair" OnClick="BtnVoltar_Click" />
            </div>
        </header>

        <section class="card">
            <h2 class="titulo-card">Agendamento Confirmado</h2>
            <asp:Label ID="LblMensagemConfirmacao" runat="server" CssClass="mensagem-confirmacao"></asp:Label>
        </section>
    </form>
</body>
</html>
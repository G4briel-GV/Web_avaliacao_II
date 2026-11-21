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

        .bloco-campo {
        margin-bottom : 16px;
        }

        .linha-campo {
        display: flex;
        gap: 10px;
        align-items: center;
        }

        .label-campo {
        display: block;
        font-weight: bold;
        margin-bottom: 6px;
        }

        .campo-texto {
        flex: 1;
        padding: 10px;
        font-size: 14px;
        background-color: #f8f8f8;
        border: 1px solid #c5d0d6;
        border-radius: 6px;
        box-sizing: border-box;
        }

        .btn-selecionar {
        padding: 10px 14px;
        font-size: 14px;
        font-weight: bold;
        background-color: #eef2f4;
        color: #465d67;
        border: 1px solid #c5d0d6;
        border-radius: 6px;
        cursor: pointer;
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

                <div class="bloco-campo">
                    <asp:Label ID="LblMentor" runat="server" Text="Selecione o Mentor" CssClass="label-campo"></asp:Label>
                
                    <div class="linha-campo">
                    <asp:TextBox ID="TxtMentor" runat="server" ReadOnly="true" CssClass="campo-texto"></asp:TextBox>
                    <asp:Button ID="BtnSelecionarMentor" runat="server" Text="Selecionar Mentor" CssClass="btn-selecionar" OnClick="BtnSelecionarMentor_Click" />
                    </div>

                    <asp:ListBox ID="LstMentores" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="LstMentores_SelectedIndexChanged"></asp:ListBox>
                </div>

                <div class="bloco-agendamento">
                    <asp:Label ID="LblDisciplina" runat="server" Text="Selecione a Disciplina" CssClass="label-campo"></asp:Label>
                
                    <div class="linha-campo">
                    <asp:TextBox ID="TxtDisciplina" runat="server" ReadOnly="true" CssClass="campo-texto"></asp:TextBox>
                    <asp:Button ID="BtnSelecionarDisciplina" runat="server" Text="Selecionar Disciplina" CssClass="btn-selecionar" OnClick="BtnSelecionarDisciplina_Click" />
                    </div>

                    <asp:ListBox ID="LstDisciplinas" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="LstDisciplinas_SelectedIndexChanged"></asp:ListBox>
                </div>

                <div class="bloco-agendamento">
                    <asp:Label ID="LblDias" runat="server" Text="Selecione o Dia (seg à sex)" CssClass="label-campo"></asp:Label>

                    <div class="linha-campo">
                    <asp:TextBox ID="TxtDia" runat="server" ReadOnly="true" CssClass="campo-texto"></asp:TextBox>
                    <asp:Button ID="BtnSelecionarDia" runat="server" Text="Selecionar Dia" CssClass="btn-selecionar" OnClick="BtnSelecionarDia_Click" />
                    </div>

                    <asp:ListBox ID="LstDias" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="LstDias_SelectedIndexChanged"></asp:ListBox>
                </div>

                <div class="bloco-agendamento">
                    <asp:Label ID="LblHorario" runat="server" Text="Selecione o Horário" CssClass="label-campo"></asp:Label>
                
                    <div class="linha-campo">
                    <asp:TextBox ID="TxtHorario" runat="server" ReadOnly="true" CssClass="campo-texto"></asp:TextBox>
                    <asp:Button ID="BtnSelecionarHorario" runat="server" Text="Selecionar Horário" CssClass="btn-selecionar" OnClick="BtnSelecionarHorario_Click" />
                    </div>

                    <asp:ListBox ID="LstHorarios" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="LstHorarios_SelectedIndexChanged"></asp:ListBox>
                </div>

                <br /><br />
                <div class="area-agendar">
                    <asp:Button ID="BtnAgendar" runat="server" Text="Agendar" CssClass="btn-agendar" OnClick="BtnAgendar_Click"/>
                </div>
            </main>
       </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Horarios_mentor.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Horarios_mentor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Horários semanais do mentor</title>
    <style type="text/css">
        body { margin: 0; }

        .pagina-inicial {
          background-color: #f8f8f8;
          min-height: 100vh;
          width: 100%;
          display: flex;
          flex-direction: column;
          font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
          color: #465d67;
          padding: 0 24px;
          box-sizing: border-box;
        }

        .pagina-inicial .container {
          max-width: 1152px;
          width: 100%;
          margin: 0 auto;
        }

        .pagina-inicial .cabecalho {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 90px;
          background-color: #ffffff;
          border-bottom: 1px solid #dde3e6;
          box-shadow: 0px 4px 4px #00000040;
          z-index: 100;
        }

        .pagina-inicial .cabecalho-inner {
          max-width: 1280px;
          height: 100%;
          margin: 0 auto;
          padding: 0 64px 0 13px;
          display: flex;
          align-items: center;
          justify-content: space-between;
        }

        .pagina-inicial .cabecalho-marca {
          display: flex;
          align-items: center;
        }

        .pagina-inicial .logo-fatec-cruzeiro {
          width: 170px;
          height: 90px;
          object-fit: cover;
        }

        .pagina-inicial .logo-centro-paula {
          width: 170px;
          height: 90px;
          margin-left: -15px;
          aspect-ratio: 1.55;
          object-fit: cover;
        }

        .pagina-inicial .titulo-sistema {
          margin-left: 16px;
          font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
          font-weight: 700;
          color: #465d67;
          font-size: 50px;
          display: flex;
          align-items: center;
          letter-spacing: 0.1px;
          line-height: 44px;
        }

        .TextoInicial { 
            margin: 110px 0 8px 0; 
            text-align: center;
        }
        .text-abaixo   { 
            margin: 0 0 20px 0; 
            color: #7b8f98; 
            text-align: center;
        }
        .Botoes {
            margin-top: 16px;
            text-align: center;
        }

        .grid-horarios {
            width: 800px;
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
            border-radius: 10px;
            background-color: #ffffff;
        }

        .grid-horarios th {
          background-color: #465d67;
          color: #ffffff;
          padding: 10px;
          text-align: left;
        }

        .grid-horarios td {
          padding: 10px;
          border-bottom: 1px solid #dde3e6;
        }

        .btn-base {
          padding: 8px 16px;
          border: none;
          border-radius: 4px;
          color: #ffffff;
          cursor: pointer;
          margin-right: 8px;
        }

        .btn-adicionar { background-color: #7b8f98; }
        .btn-adicionar:hover { background-color: #6c7d85}
        .btn-salvar    { background-color: #465d67; }
        .btn-salvar:hover    { background-color: #384a52; }
        .btn-remover   { background-color: #c0392b; }
        .btn-remover:hover   { background-color: #942418; }
        .label-erro{
            text-align: center;
            color: black;
            padding: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pagina-inicial">
            <header class="cabecalho">
              <div class="cabecalho-inner">
                <div class="cabecalho-marca">
                  <img
                    class="logo-fatec-cruzeiro"
                    src="fatec_cruzeiro.jpg"
                    alt="Fatec Cruzeiro – Prof. Waldomiro May"
                  />
                  <img
                    class="logo-centro-paula"
                    src="cps_img.jpg"
                    alt="Centro Paula Souza"
                  />
                  <span class="titulo-sistema">Mentoria</span>
                </div>
              </div>
            </header>
            <h2 class="TextoInicial">Agenda Semanal do Mentor</h2>
            <p class="text-abaixo">Adicione os horários de atendimento para cada dia da semana.</p>

            <asp:GridView ID="gvHorarios" runat="server" AutoGenerateColumns="false" DataKeyNames="id_disponibilidade" CssClass="grid-horarios" GridLines="None" OnRowCommand="gvHorarios_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Dia da Semana">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlDiaSemana" runat="server" SelectedValue='<%# Eval("dia_semana") %>'>
                                <asp:ListItem Value="seg">seg</asp:ListItem>
                                <asp:ListItem Value="ter">ter</asp:ListItem>
                                <asp:ListItem Value="qua">qua</asp:ListItem>
                                <asp:ListItem Value="qui">qui</asp:ListItem>
                                <asp:ListItem Value="sex">sex</asp:ListItem>
                                <asp:ListItem Value="sab">sab</asp:ListItem>
                                <asp:ListItem Value="dom">dom</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Horário Inicial">
                        <ItemTemplate>
                            <asp:TextBox ID="txtHoraInicio" runat="server" Text='<%# Eval("inicio", "{0:hh\\:mm}") %>' TextMode="Time" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Horário Final">
                        <ItemTemplate>
                            <asp:TextBox ID="txtHoraFim" runat="server" Text='<%# Eval("fim", "{0:hh\\:mm}") %>' TextMode="Time" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ações">
                        <ItemTemplate>
                            <asp:Button ID="btnRemover" CommandName="Remover" runat="server" CommandArgument='<%# Eval("id_disponibilidade") %>' Text="Remover" CssClass="btn-base btn-remover" CausesValidation="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="Botoes">
                <asp:Button ID="btnAdicionar" runat="server" Text="Adicionar Novo Horário" CssClass="btn-base btn-adicionar" CausesValidation="false" OnClick="btnAdicionar_Click"/>
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar Agenda" CssClass="btn-base btn-salvar" OnClick="btnSalvar_Click"/>
            </div>
            <asp:Label ID="lblMensagem" runat="server" CssClass="label-erro"></asp:Label>
        </div>
    </form>
</body>
</html>
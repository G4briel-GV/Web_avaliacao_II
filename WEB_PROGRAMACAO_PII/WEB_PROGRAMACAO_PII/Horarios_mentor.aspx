<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Horarios_mentor.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Horarios_mentor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Horários semanais do mentor</title>
    <style type="text/css">
        .TextoInicial{
            margin-left: 16px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            color: #465d67;
            font-size: 36px;
            letter-spacing: 0.1px;
            line-height: 44px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2 class="TextoInicial">Agenda Semanal do Mentor</h2>
            <p class="text-muted">Adicione os horários de atendimento para cada dia da semana.</p>

            <asp:GridView ID="gvHorarios" runat="server" AutoGenerateColumns="false" DataKeyNames="id_disponibilidade" CssClass="table table-bordered table-striped" OnRowCommand="gvHorarios_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Dia da Semana">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlDiaSemana" runat="server" CssClass="form-select" SelectedValue='<%# Eval("dia_semana") %>'>
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
                            <asp:TextBox ID="txtHoraInicio" runat="server" Text='<%# Eval("inicio", "{0:hh\\:mm}") %>' TextMode="Time" CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Horário Final">
                        <ItemTemplate>
                            <asp:TextBox ID="txtHoraFim" runat="server" Text='<%# Eval("fim", "{0:hh\\:mm}") %>' TextMode="Time" CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ações">
                        <ItemTemplate>
                            <asp:Button ID="btnRemover" CommandName="Remover" runat="server" CommandArgument='<%# Eval("id_disponibilidade") %>' Text="Remover" CssClass="btn btn-danger btn-sm" CausesValidation="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="mt-3">
                <asp:Button ID="btnAdicionar" runat="server" Text="Adicionar Novo Horário" CssClass="btn btn-secondary" CausesValidation="false" OnClick="btnAdicionar_Click"/>
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar Agenda" CssClass="btn btn-primary"/>
            </div>
        </div>
    </form>
</body>
</html>

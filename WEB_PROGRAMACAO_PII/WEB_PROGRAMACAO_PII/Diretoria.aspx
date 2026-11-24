<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Diretoria.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Diretoria" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Controle de mentorias – Fatec Cruzeiro</title>
    <link rel="stylesheet" href="globals.css" />
    <link rel="stylesheet" href="styleguide.css" />
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        .pagina-controle-mentorias {
            background-color: #f8f8f8;
            min-height: 100vh;
            width: 100%;
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            color: #465d67;
        }

        /* Cabeçalho institucional fixo (padrão do sistema) */
        .pagina-controle-mentorias .cabecalho {
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

        .pagina-controle-mentorias .cabecalho-inner {
            max-width: 1280px;
            height: 100%;
            margin: 0 auto;
            padding: 0 64px 0 13px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .pagina-controle-mentorias .cabecalho-marca {
            display: flex;
            align-items: center;
        }

        .pagina-controle-mentorias .logo-fatec-cruzeiro {
            width: 154px;
            height: 74px;
            object-fit: cover;
        }

        .pagina-controle-mentorias .logo-centro-paula {
            width: 77px;
            height: 52px;
            margin-left: -15px;
            aspect-ratio: 1.55;
            object-fit: cover;
        }

        .pagina-controle-mentorias .titulo-sistema {
            margin-left: 16px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            color: #465d67;
            font-size: 36px;
            letter-spacing: 0.1px;
            line-height: 44px;
        }

        .pagina-controle-mentorias .cabecalho-acoes {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .pagina-controle-mentorias .perfil-usuario {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .pagina-controle-mentorias .perfil-titulo {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 15px;
            line-height: 20px;
            color: #465d67;
        }

        .pagina-controle-mentorias .perfil-subtitulo {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 12px;
            line-height: 16px;
            color: #64747c;
        }

        .pagina-controle-mentorias .btn-sair {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 44px;
            padding: 0 22px;
            background-color: #ad0f0a;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.15s ease;
            font-family: var(--m3-label-large-font-family, "Roboto", Helvetica, sans-serif);
            font-weight: var(--m3-label-large-font-weight, 500);
            font-size: var(--m3-label-large-font-size, 14px);
            letter-spacing: var(--m3-label-large-letter-spacing, 0.1px);
            line-height: var(--m3-label-large-line-height, 20px);
            color: var(--m3-schemes-on-primary, #ffffff);
        }

        .pagina-controle-mentorias .btn-sair:hover {
            background-color: #920c08;
        }

        /* Área principal */
        .pagina-controle-mentorias .conteudo-principal {
            padding: 118px 64px 48px;
        }

        .pagina-controle-mentorias .container {
            max-width: 1152px;
            margin: 0 auto;
        }

        /* Breadcrumb */
        .pagina-controle-mentorias .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            line-height: 18px;
            color: #64747c;
            margin-bottom: 12px;
        }

        .pagina-controle-mentorias .breadcrumb-separador {
            color: #9aa6ac;
        }

        /* Título e botão principal */
        .pagina-controle-mentorias .topo-pagina {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            margin-bottom: 24px;
        }

        .pagina-controle-mentorias .titulo-pagina {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 28px;
            line-height: 36px;
            color: #465d67;
            margin-bottom: 4px;
        }

        .pagina-controle-mentorias .subtitulo-pagina {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 14px;
            line-height: 20px;
            color: #64747c;
        }

        .pagina-controle-mentorias .btn-primario {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 44px;
            padding: 0 28px;
            background-color: #ad0f0a;
            border: none;
            border-radius: 8px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 14px;
            line-height: 20px;
            color: #ffffff;
            white-space: nowrap;
            cursor: pointer;
            transition: background-color 0.15s ease;
        }

        .pagina-controle-mentorias .btn-primario:hover {
            background-color: #920c08;
        }

        /* Cards de métricas */
        .pagina-controle-mentorias .cards-metricas {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .pagina-controle-mentorias .card-metrica {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 88px;
            padding: 16px 20px;
            background-color: #ffffff;
            border: 1px solid #dde3e6;
            border-radius: 8px;
        }

        .pagina-controle-mentorias .card-metrica--alerta::before {
            content: "";
            position: absolute;
            left: 0;
            top: 14px;
            bottom: 14px;
            width: 3px;
            background-color: #ad0f0a;
            border-radius: 0 2px 2px 0;
        }

        .pagina-controle-mentorias .card-metrica-titulo {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 13px;
            line-height: 18px;
            color: #64747c;
        }

        .pagina-controle-mentorias .card-metrica-valor {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 28px;
            line-height: 34px;
            color: #465d67;
            margin-top: 8px;
        }

        .pagina-controle-mentorias .card-metrica-valor--alerta {
            color: #ad0f0a;
        }

        /* Barra de filtros */
        .pagina-controle-mentorias .barra-filtros {
            display: grid;
            grid-template-columns: 1.45fr 1fr 1fr 1fr auto;
            align-items: end;
            gap: 16px;
            margin-bottom: 24px;
        }

        .pagina-controle-mentorias .campo-filtro {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .pagina-controle-mentorias .campo-label {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 12px;
            line-height: 16px;
            color: #465d67;
        }

        .pagina-controle-mentorias .campo-controle {
            width: 100%;
            height: 38px;
            padding: 0 12px;
            background-color: #ffffff;
            border: 1px solid #dde3e6;
            border-radius: 8px;
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-size: 13px;
            color: #465d67;
            outline: none;
            transition: border-color 0.15s ease;
        }

        .pagina-controle-mentorias .campo-controle::placeholder {
            color: #64747c;
        }

        .pagina-controle-mentorias .campo-controle:focus {
            border-color: #465d67;
        }

        .pagina-controle-mentorias .campo-select {
            appearance: none;
            padding-right: 32px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' viewBox='0 0 10 6'%3E%3Cpath fill='%23465d67' d='M0 0l5 6 5-6z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 8px 5px;
            cursor: pointer;
        }

        .pagina-controle-mentorias .btn-limpar {
            height: 38px;
            padding: 0 12px;
            background: transparent;
            border: none;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 13px;
            color: #465d67;
            cursor: pointer;
            white-space: nowrap;
        }

        .pagina-controle-mentorias .btn-limpar:hover {
            color: #ad0f0a;
        }

        /* Card da tabela */
        .pagina-controle-mentorias .card-tabela {
            background-color: #ffffff;
            border: 1px solid #dde3e6;
            border-radius: 10px;
            overflow: hidden;
        }

        .pagina-controle-mentorias .card-tabela-cabecalho {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 24px;
        }

        .pagina-controle-mentorias .card-tabela-titulo {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 19px;
            line-height: 26px;
            color: #465d67;
        }

        .pagina-controle-mentorias .card-tabela-contador {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-size: 12px;
            line-height: 16px;
            color: #64747c;
        }

        .pagina-controle-mentorias .tabela-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .pagina-controle-mentorias .tabela-mentorias {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .pagina-controle-mentorias .tabela-mentorias thead,
        .pagina-controle-mentorias .tabela-mentorias tr:first-child th {
            background-color: #f1f4f6;
            border-top: 1px solid #dde3e6;
            border-bottom: 1px solid #dde3e6;
        }

        .pagina-controle-mentorias .tabela-mentorias th {
            padding: 12px 16px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 12px;
            line-height: 16px;
            color: #465d67;
            vertical-align: middle;
        }

        .pagina-controle-mentorias .tabela-mentorias th:first-child,
        .pagina-controle-mentorias .tabela-mentorias td:first-child {
            padding-left: 24px;
        }

        .pagina-controle-mentorias .tabela-mentorias th:last-child,
        .pagina-controle-mentorias .tabela-mentorias td:last-child {
            padding-right: 24px;
        }

        .pagina-controle-mentorias .tabela-mentorias td {
            padding: 13px 16px;
            border-bottom: 1px solid #eef1f3;
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-size: 13px;
            line-height: 18px;
            color: #64747c;
            vertical-align: middle;
        }

        .pagina-controle-mentorias .tabela-mentorias tbody tr:last-child td {
            border-bottom: none;
        }

        .pagina-controle-mentorias .tabela-mentorias tr.linha-alerta {
            background-color: #fdf6f6;
        }

        .pagina-controle-mentorias .celula-data {
            display: flex;
            flex-direction: column;
            font-size: 12px;
            line-height: 16px;
            color: #64747c;
        }

        .pagina-controle-mentorias .celula-destaque {
            color: #465d67;
        }

        .pagina-controle-mentorias .texto-ausente {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            color: #ad0f0a;
        }

        /* Badges de situação */
        .pagina-controle-mentorias .badge {
            display: inline-flex;
            align-items: center;
            width: 132px;
            height: 28px;
            padding: 0 12px;
            border-radius: 6px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 12px;
            line-height: 16px;
        }

        .pagina-controle-mentorias .badge--realizada {
            background-color: #e8f1ec;
            color: #2e6f40;
        }

        .pagina-controle-mentorias .badge--ausente {
            background-color: #f9e2e1;
            color: #ad0f0a;
        }

        .pagina-controle-mentorias .badge--agendada {
            background-color: #eceff1;
            color: #465d67;
        }

        /* Links de ação na coluna Registro */
        .pagina-controle-mentorias .link-registro {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 12px;
            line-height: 16px;
            color: #465d67;
            text-decoration: underline;
            white-space: nowrap;
        }

        .pagina-controle-mentorias .link-registro:hover {
            color: #ad0f0a;
        }

        /* Rodapé abaixo da tabela */
        .pagina-controle-mentorias .rodape-listagem {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 14px;
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-size: 12px;
            line-height: 16px;
            color: #64747c;
        }

        /* Ajustes responsivos */
        @media (max-width: 1024px) {
            .pagina-controle-mentorias .cabecalho-inner {
                padding: 0 24px;
            }
            .pagina-controle-mentorias .conteudo-principal {
                padding: 114px 24px 40px;
            }
            .pagina-controle-mentorias .cards-metricas {
                grid-template-columns: repeat(2, 1fr);
            }
            .pagina-controle-mentorias .barra-filtros {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 640px) {
            .pagina-controle-mentorias .topo-pagina,
            .pagina-controle-mentorias .rodape-listagem {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
            .pagina-controle-mentorias .cards-metricas,
            .pagina-controle-mentorias .barra-filtros {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body data-m3-mode="light">
    <form id="form1" runat="server">
        <div class="pagina-controle-mentorias">
            <!-- Cabeçalho institucional fixo -->
            <header class="cabecalho">
                <div class="cabecalho-inner">
                    <div class="cabecalho-marca">
                        <img
                            class="logo-fatec-cruzeiro"
                            src="img/logo-fatec-cruzeiro.png"
                            alt="Fatec Cruzeiro – Prof. Waldomiro May"
                        />
                        <img
                            class="logo-centro-paula"
                            src="img/logo-centro-paula-souza.png"
                            alt="Centro Paula Souza"
                        />
                        <span class="titulo-sistema">Mentoria</span>
                    </div>
                    <div class="cabecalho-acoes">
                        <div class="perfil-usuario">
                            <span class="perfil-titulo">Diretoria do curso</span>
                            <span class="perfil-subtitulo">Acesso administrativo</span>
                        </div>
                        <asp:Button ID="btnSair" runat="server" Text="Sair" CssClass="btn-sair" OnClick="btnSair_Click" />
                    </div>
                </div>
            </header>

            <!-- Conteúdo principal -->
            <main class="conteudo-principal">
                <div class="container">
                    <!-- Trilha de navegação -->
                    <nav class="breadcrumb" aria-label="Navegação estrutural">
                        <span>Diretoria do curso</span>
                        <span class="breadcrumb-separador">/</span>
                        <span class="breadcrumb-atual">Mentorias</span>
                    </nav>

                    <!-- Título da página e ação principal -->
                    <section class="topo-pagina">
                        <div class="topo-pagina-textos">
                            <h1 class="titulo-pagina">Controle de mentorias</h1>
                            <p class="subtitulo-pagina">
                                Acompanhe os agendamentos e a presença de alunos e mentores.
                            </p>
                        </div>
                        <asp:Button ID="btnExportarRelatorio" runat="server" Text="Exportar relatório" CssClass="btn-primario" />
                    </section>

                    <!-- Cards de indicadores -->
                    <section class="cards-metricas" aria-label="Resumo do período">
                        <article class="card-metrica">
                            <span class="card-metrica-titulo">Mentorias no período</span>
                            <asp:Label ID="lblTotalMentorias" runat="server" Text="6" CssClass="card-metrica-valor"></asp:Label>
                        </article>
                        <article class="card-metrica">
                            <span class="card-metrica-titulo">Realizadas</span>
                            <asp:Label ID="lblRealizadas" runat="server" Text="3" CssClass="card-metrica-valor"></asp:Label>
                        </article>
                        <article class="card-metrica card-metrica--alerta">
                            <span class="card-metrica-titulo">Falta do aluno</span>
                            <asp:Label ID="lblFaltaAluno" runat="server" Text="1" CssClass="card-metrica-valor card-metrica-valor--alerta"></asp:Label>
                        </article>
                        <article class="card-metrica card-metrica--alerta">
                            <span class="card-metrica-titulo">Falta do mentor</span>
                            <asp:Label ID="lblFaltaMentor" runat="server" Text="1" CssClass="card-metrica-valor card-metrica-valor--alerta"></asp:Label>
                        </article>
                    </section>

                    <!-- Barra de filtros -->
                    <div class="barra-filtros" aria-label="Filtrar mentorias">
                        <div class="campo-filtro campo-filtro--busca">
                            <label for="txtFiltroBusca" class="campo-label">Buscar aluno ou mentor</label>
                            <asp:TextBox
                                ID="txtFiltroBusca"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="campo-controle"
                                placeholder="Digite um nome"
                                AutoPostBack="true" OnTextChanged="FiltrarMentorias"
                                >
                            </asp:TextBox>
                        </div>

                        <div class="campo-filtro">
                            <label for="ddlFiltroPeriodo" class="campo-label">Período</label>
                            <asp:DropDownList ID="ddlFiltroPeriodo" runat="server" ClientIDMode="Static" CssClass="campo-controle campo-select" AutoPostBack="true">
                                <asp:ListItem Value="16-20-nov-2026" Selected="True">16–20 nov. 2026</asp:ListItem>
                                <asp:ListItem Value="23-27-nov-2026">23–27 nov. 2026</asp:ListItem>
                                <asp:ListItem Value="todos">Todos os períodos</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="campo-filtro">
                            <label for="ddlFiltroSituacao" class="campo-label">Situação</label>
                            <asp:DropDownList ID="ddlFiltroSituacao" runat="server" ClientIDMode="Static" CssClass="campo-controle campo-select" AutoPostBack="true">
                                <asp:ListItem Value="todas" Selected="True">Todas as situações</asp:ListItem>
                                <asp:ListItem Value="realizada">Realizada</asp:ListItem>
                                <asp:ListItem Value="aluno-ausente">Aluno ausente</asp:ListItem>
                                <asp:ListItem Value="mentor-ausente">Mentor ausente</asp:ListItem>
                                <asp:ListItem Value="agendada">Agendada</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="campo-filtro">
                            <label for="ddlFiltroPresenca" class="campo-label">Presença</label>
                            <asp:DropDownList ID="ddlFiltroPresenca" runat="server" ClientIDMode="Static" CssClass="campo-controle campo-select" AutoPostBack="true" >
                                <asp:ListItem Value="todos" Selected="True">Alunos e mentores</asp:ListItem>
                                <asp:ListItem Value="falta-aluno">Falta do aluno</asp:ListItem>
                                <asp:ListItem Value="falta-mentor">Falta do mentor</asp:ListItem>
                                <asp:ListItem Value="pendente">Pendente</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <asp:Button ID="btnLimpar" runat="server" Text="Limpar" CssClass="btn-limpar" OnClick="btnLimpar_Click"  />
                    </div>

                    <!-- Tabela de mentorias -->
                    <section class="card-tabela" aria-labelledby="titulo-tabela-mentorias">
                        <header class="card-tabela-cabecalho">
                            <h2 id="titulo-tabela-mentorias" class="card-tabela-titulo">
                                Mentorias do curso
                            </h2>
                            <asp:Label ID="lblContadorTabela" runat="server" Text="6 registros no período" CssClass="card-tabela-contador"></asp:Label>
                        </header>

                        <div class="tabela-wrapper">
                            <asp:GridView
                                ID="gvMentorias"
                                runat="server"
                                AutoGenerateColumns="False"
                                CssClass="tabela-mentorias"
                                GridLines="None"
                                BorderStyle="None"
                                BorderWidth="0"
                            >
                                <Columns>
                                    <asp:TemplateField HeaderText="Data / hora">
                                        <ItemTemplate>
                                            <div class="celula-data">
                                                <span><%# Eval("Data") %></span>
                                                <span><%# Eval("Hora") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Aluno" HeaderText="Aluno" ItemStyle-CssClass="celula-destaque" />
                                    <asp:BoundField DataField="Mentor" HeaderText="Mentor" />
                                    <asp:BoundField DataField="Assunto" HeaderText="Assunto" />
                                    <asp:BoundField DataField="PresencaAluno" HeaderText="Presença<br />do aluno" HtmlEncode="False" />
                                    <asp:BoundField DataField="PresencaMentor" HeaderText="Presença<br />do mentor" HtmlEncode="False" />

                                    <asp:TemplateField HeaderText="Situação">
                                        <ItemTemplate>
                                            <span class='<%# Eval("ClasseBadge") %>'><%# Eval("Situacao") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Registro">
                                        <ItemTemplate>
                                            <asp:LinkButton
                                                ID="lnkRegistro"
                                                runat="server"
                                                CssClass="link-registro"
                                                CommandName="VerRegistro"
                                                CommandArgument='<%# Eval("Id") %>'>
                                                <%# Eval("TextoRegistro") %>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </section>

                    <!-- Rodapé informativo da listagem -->
                    <footer class="rodape-listagem">
                        <asp:Label ID="lblRodapeExibicao" runat="server" Text="Exibindo 6 de 6 mentorias · Dados de exemplo"></asp:Label>
                        <span>Presenças de aluno e mentor são acompanhadas separadamente.</span>
                    </footer>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
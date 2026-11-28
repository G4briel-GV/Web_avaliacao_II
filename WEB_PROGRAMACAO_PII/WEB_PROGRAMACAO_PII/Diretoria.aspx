<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Diretoria.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Diretoria" %>
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

        /* Cabeçalho institucional fixo */
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

        /* Título e ação principal */
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
            padding: 0 24px;
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

        /* Painel de cadastro de mentor */
        .pagina-controle-mentorias .card-cadastro-mentor {
            background-color: #ffffff;
            border: 1px solid #dde3e6;
            border-left: 4px solid #ad0f0a;
            border-radius: 10px;
            padding: 20px 24px;
            margin-bottom: 24px;
        }

        .pagina-controle-mentorias .card-cadastro-titulo {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 17px;
            line-height: 24px;
            color: #465d67;
            margin-bottom: 4px;
        }

        .pagina-controle-mentorias .card-cadastro-subtitulo {
            font-size: 13px;
            color: #64747c;
            margin-bottom: 16px;
        }

        .pagina-controle-mentorias .form-cadastro-grid {
            display: grid;
            grid-template-columns: 1fr 1.2fr auto auto;
            align-items: end;
            gap: 12px;
        }

        .pagina-controle-mentorias .feedback-cadastro {
            display: block;
            margin-top: 12px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-size: 13px;
        }

        .pagina-controle-mentorias .feedback-sucesso {
            color: #2e6f40;
        }

        .pagina-controle-mentorias .feedback-erro {
            color: #ad0f0a;
        }

        /* Barra de filtros: TextBox (Aluno) + DropDownList (Mentor) + Botões */
        .pagina-controle-mentorias .barra-filtros {
            display: grid;
            grid-template-columns: 1.2fr 1fr auto auto;
            align-items: end;
            gap: 12px;
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
            height: 40px;
            padding: 0 14px;
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

        .pagina-controle-mentorias .btn-buscar {
            height: 40px;
            padding: 0 22px;
            background-color: #ad0f0a;
            border: none;
            border-radius: 8px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 13px;
            color: #ffffff;
            cursor: pointer;
            white-space: nowrap;
            transition: background-color 0.15s ease;
        }

        .pagina-controle-mentorias .btn-buscar:hover {
            background-color: #920c08;
        }

        .pagina-controle-mentorias .btn-limpar {
            height: 40px;
            padding: 0 16px;
            background: #ffffff;
            border: 1px solid #dde3e6;
            border-radius: 8px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 13px;
            color: #465d67;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.15s ease;
        }

        .pagina-controle-mentorias .btn-limpar:hover {
            border-color: #ad0f0a;
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
            padding: 20px 24px;
        }

        .pagina-controle-mentorias .card-tabela-titulo {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 19px;
            line-height: 26px;
            color: #465d67;
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

        .pagina-controle-mentorias .celula-destaque {
            color: #465d67;
            font-weight: 700;
        }

        .pagina-controle-mentorias .badge-situacao {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            border-radius: 6px;
            background-color: #eceff1;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 12px;
            color: #465d67;
        }

        /* Rodapé abaixo da tabela */
        .pagina-controle-mentorias .rodape-listagem {
            display: flex;
            align-items: center;
            justify-content: flex-end;
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
            .pagina-controle-mentorias .form-cadastro-grid,
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
            .pagina-controle-mentorias .barra-filtros,
            .pagina-controle-mentorias .form-cadastro-grid {
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
                            src="FATEC.png"
                            alt="Fatec Cruzeiro – Prof. Waldomiro May"
                        />
                        <span class="titulo-sistema">Coordenação</span>
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

                    <!-- Título da página e botão de cadastro de mentor -->
                    <section class="topo-pagina">
                        <div class="topo-pagina-textos">
                            <h1 class="titulo-pagina">Controle de mentorias</h1>
                            <p class="subtitulo-pagina">
                                Acompanhe os agendamentos, presenças e habilite alunos como mentores.
                            </p>
                        </div>
                        <asp:Button
                            ID="btnAbrirCadastroMentor"
                            runat="server"
                            Text="+ Cadastrar mentor"
                            CssClass="btn-primario"
                            OnClick="btnAbrirCadastroMentor_Click"
                        />
                    </section>

                    <!-- Painel retrátil para habilitar aluno como mentor via RA + TextBox de Disciplina -->
                    <asp:Panel ID="pnlCadastroMentor" runat="server" Visible="false" CssClass="card-cadastro-mentor">
                        <h2 class="card-cadastro-titulo">Habilitar aluno como mentor</h2>
                        <p class="card-cadastro-subtitulo">
                            Informe o RA do aluno matriculado e digite a disciplina. Ele manterá o acesso de aluno para agendar outras matérias.
                        </p>

                        <div class="form-cadastro-grid">
                            <div class="campo-filtro">
                                <label for="txtRaMentor" class="campo-label">RA do aluno</label>
                                <asp:TextBox
                                    ID="txtRaMentor"
                                    runat="server"
                                    ClientIDMode="Static"
                                    CssClass="campo-controle"
                                    placeholder="Digite o RA do aluno...">
                                </asp:TextBox>
                            </div>

                            <div class="campo-filtro">
                                <label for="txtDisciplinaMentor" class="campo-label">Disciplina da mentoria</label>
                                <asp:TextBox
                                    ID="txtDisciplinaMentor"
                                    runat="server"
                                    ClientIDMode="Static"
                                    CssClass="campo-controle"
                                    placeholder="Ex: Banco de Dados, Lógica...">
                                </asp:TextBox>
                            </div>

                            <asp:Button ID="btnSalvarMentor" runat="server" Text="Confirmar mentor" CssClass="btn-buscar" OnClick="btnSalvarMentor_Click" />
                            <asp:Button ID="btnCancelarMentor" runat="server" Text="Cancelar" CssClass="btn-limpar" OnClick="btnCancelarMentor_Click" />
                        </div>

                        <asp:Label ID="lblMensagemMentor" runat="server" Visible="false" CssClass="feedback-cadastro"></asp:Label>
                    </asp:Panel>

                    <!-- Barra de filtros: Busca por nome do Aluno + DropDownList de Mentor -->
                    <div class="barra-filtros" aria-label="Filtrar mentorias">
                        <div class="campo-filtro">
                            <label for="txtFiltroAluno" class="campo-label">Buscar por Aluno</label>
                            <asp:TextBox
                                ID="txtFiltroAluno"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="campo-controle"
                                placeholder="Digite o nome do aluno...">
                            </asp:TextBox>
                        </div>

                        <div class="campo-filtro">
                            <label for="ddlFiltroMentor" class="campo-label">Filtrar por Mentor</label>
                            <asp:DropDownList
                                ID="ddlFiltroMentor"
                                runat="server"
                                ClientIDMode="Static"
                                DataSourceID="SqlDataSourceMentores"
                                DataTextField="nome"
                                DataValueField="id_aluno"
                                AppendDataBoundItems="True"
                                AutoPostBack="True"
                                OnSelectedIndexChanged="btnBuscar_Click"
                                CssClass="campo-controle campo-select">
                                <asp:ListItem Text="Todos os mentores" Value="0" />
                            </asp:DropDownList>
                        </div>

                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn-buscar" OnClick="btnBuscar_Click" />
                        <asp:Button ID="btnLimpar" runat="server" Text="Limpar" CssClass="btn-limpar" OnClick="btnLimpar_Click" />
                    </div>

                    <!-- Tabela de mentorias conectada diretamente ao SqlDataSource -->
                    <section class="card-tabela" aria-labelledby="titulo-tabela-mentorias">
                        <header class="card-tabela-cabecalho">
                            <h2 id="titulo-tabela-mentorias" class="card-tabela-titulo">
                                Mentorias do curso
                            </h2>
                        </header>

                        <div class="tabela-wrapper">
                            <asp:GridView
                                ID="gvMentorias"
                                runat="server"
                                DataSourceID="SqlDataSource1"
                                AutoGenerateColumns="False"
                                CssClass="tabela-mentorias"
                                GridLines="None"
                                BorderStyle="None"
                                BorderWidth="0"
                                EmptyDataText="Nenhuma mentoria encontrada."
                            >
                                <Columns>
                                    <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM}" />
                                    <asp:BoundField DataField="nome_aluno" HeaderText="Aluno" ItemStyle-CssClass="celula-destaque" />
                                    <asp:BoundField DataField="nome_mentor" HeaderText="Mentor" />
                                    <asp:BoundField DataField="nome_materia" HeaderText="Assunto" />

                                    <asp:TemplateField HeaderText="Situação">
                                        <ItemTemplate>
                                            <span class="badge-situacao"><%# Eval("status") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                            <!-- SqlDataSource 1: Preenche o DropDownList de Mentores -->
                            <asp:SqlDataSource
                                ID="SqlDataSourceMentores"
                                runat="server"
                                ConnectionString="<%$ ConnectionStrings:MinhaConexao %>"
                                SelectCommand="SELECT id_aluno, nome FROM Aluno WHERE mentor = 'S' ORDER BY nome">
                            </asp:SqlDataSource>

                            <!-- SqlDataSource 2: Preenche a GridView sem a coluna de hora -->
                            <asp:SqlDataSource
                                ID="SqlDataSource1"
                                runat="server"
                                ConnectionString="<%$ ConnectionStrings:MinhaConexao %>"
                                SelectCommand="
                                    SELECT 
                                        Mentoria.data,
                                        Aluno.nome AS nome_aluno,
                                        Mentor.nome AS nome_mentor,
                                        Materia.nome AS nome_materia,
                                        Mentoria.status
                                    FROM Mentoria
                                    INNER JOIN Aluno ON Mentoria.id_aluno = Aluno.id_aluno
                                    INNER JOIN Aluno AS Mentor ON Mentoria.id_mentor = Mentor.id_aluno
                                    INNER JOIN Materia ON Mentoria.id_materia = Materia.id_materia">
                            </asp:SqlDataSource>
                        </div>
                    </section>

                    <!-- Rodapé institucional -->
                    <footer class="rodape-listagem">
                        <span>Controle de mentorias – Coordenação Fatec Cruzeiro.</span>
                    </footer>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
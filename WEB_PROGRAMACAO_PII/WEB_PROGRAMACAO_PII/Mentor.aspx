<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mentor.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Mentor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Detalhes da mentoria – Fatec Cruzeiro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      .pagina-mentoria-detalhes {
        background-color: #f9f9f9;
        min-height: 100vh;
        width: 100%;
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        color: #465d67;
      }

      .pagina-mentoria-detalhes .cabecalho {
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

      .pagina-mentoria-detalhes .cabecalho-inner {
        max-width: 1280px;
        height: 100%;
        margin: 0 auto;
        padding: 0 64px 0 13px;
        display: flex;
        align-items: center;
        justify-content: space-between;
      }

      .pagina-mentoria-detalhes .cabecalho-marca {
        display: flex;
        align-items: center;
      }

      .pagina-mentoria-detalhes .logo-fatec-cruzeiro {
        width: 154px;
        height: 74px;
        object-fit: cover;
      }

      .pagina-mentoria-detalhes .logo-centro-paula {
        width: 77px;
        height: 52px;
        margin-left: -15px;
        aspect-ratio: 1.55;
        object-fit: cover;
      }

      .pagina-mentoria-detalhes .titulo-sistema {
        margin-left: 16px;
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        color: #465d67;
        font-size: 36px;
        letter-spacing: 0.1px;
        line-height: 44px;
      }

      .pagina-mentoria-detalhes .cabecalho-acoes {
        display: flex;
        align-items: center;
        gap: 64px;
      }

      .pagina-mentoria-detalhes .nav-mentor {
        display: flex;
        align-items: center;
      }

      .pagina-mentoria-detalhes .nav-link {
        position: relative;
        display: inline-flex;
        align-items: center;
        padding: 8px 0;
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 16px;
        line-height: 22px;
        color: #465d67;
        white-space: nowrap;
        text-decoration: none;
      }

      .pagina-mentoria-detalhes .nav-link--ativo::after {
        content: "";
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0;
        height: 3px;
        background-color: #ad0f0a;
      }

      .pagina-mentoria-detalhes .btn-perfil {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        padding: 0;
        background: transparent;
        border: none;
        border-radius: 50%;
        cursor: pointer;
      }

      .pagina-mentoria-detalhes .perfil-do-usuario {
        width: 40px;
        height: 40px;
      }

      .pagina-mentoria-detalhes .conteudo-principal {
        padding: 114px 64px 48px;
      }

      .pagina-mentoria-detalhes .container {
        max-width: 1152px;
        margin: 0 auto;
      }

      .pagina-mentoria-detalhes .breadcrumb {
        display: flex;
        align-items: center;
        gap: 8px;
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-size: 13px;
        line-height: 18px;
        color: #64747c;
        margin-bottom: 7px;
      }

      .pagina-mentoria-detalhes .breadcrumb-separador {
        color: #9aa6ac;
      }

      .pagina-mentoria-detalhes .topo-pagina {
        margin-bottom: 18px;
      }

      .pagina-mentoria-detalhes .titulo-pagina {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 28px;
        line-height: 38px;
        color: #465d67;
        margin-bottom: 3px;
      }

      .pagina-mentoria-detalhes .subtitulo-pagina {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 15px;
        line-height: 20px;
        color: #64747c;
      }

      .pagina-mentoria-detalhes .grid-detalhes {
        display: grid;
        grid-template-columns: 350px 1fr;
        gap: 24px;
        align-items: stretch;
      }

      .pagina-mentoria-detalhes .coluna-direita {
        display: flex;
        flex-direction: column;
        gap: 20px;
        min-width: 0;
      }

      .pagina-mentoria-detalhes .card-materia {
        position: relative;
        display: flex;
        flex-direction: column;
        padding: 24px 24px 28px;
        background-color: #ffffff;
        border: 1px solid #dde3e6;
        border-radius: 8px;
        overflow: hidden;
      }

      .pagina-mentoria-detalhes .card-materia::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background-color: #ad0f0a;
      }

      .pagina-mentoria-detalhes .categoria-materia {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 12px;
        line-height: 16px;
        color: #ad0f0a;
        margin-bottom: 9px;
      }

      .pagina-mentoria-detalhes .nome-materia {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 25px;
        line-height: 34px;
        color: #465d67;
        margin-bottom: 11px;
      }

      .pagina-mentoria-detalhes .descricao-materia {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 14px;
        line-height: 19px;
        color: #64747c;
      }

      .pagina-mentoria-detalhes .divisor-card {
        width: 100%;
        height: 1px;
        background-color: #e4e8ea;
        margin: 19px 0;
      }

      .pagina-mentoria-detalhes .lista-info-materia {
        display: flex;
        flex-direction: column;
        gap: 16px;
        margin-bottom: 24px;
      }

      .pagina-mentoria-detalhes .info-item {
        display: flex;
        flex-direction: column;
        gap: 4px;
      }

      .pagina-mentoria-detalhes .info-rotulo {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 12px;
        line-height: 16px;
        color: #64747c;
      }

      .pagina-mentoria-detalhes .info-valor {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 14px;
        line-height: 19px;
        color: #465d67;
      }

      .pagina-mentoria-detalhes .info-valor--destaque {
        font-size: 16px;
        line-height: 22px;
      }

      .pagina-mentoria-detalhes .box-ocupacao {
        margin-top: auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 14px;
        background-color: #f4f6f7;
        border-radius: 5px;
      }

      .pagina-mentoria-detalhes .ocupacao-inscritos {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 13px;
        line-height: 18px;
        color: #465d67;
      }

      .pagina-mentoria-detalhes .ocupacao-capacidade {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 13px;
        line-height: 18px;
        color: #64747c;
      }

      .pagina-mentoria-detalhes .card-horarios {
        padding: 19px 24px 24px;
        background-color: #ffffff;
        border: 1px solid #dde3e6;
        border-radius: 8px;
      }

      .pagina-mentoria-detalhes .card-secao-cabecalho {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 16px;
      }

      .pagina-mentoria-detalhes .card-secao-titulo {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 20px;
        line-height: 27px;
        color: #465d67;
      }

      .pagina-mentoria-detalhes .card-secao-meta {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 13px;
        line-height: 18px;
        color: #64747c;
      }

      .pagina-mentoria-detalhes .grid-horarios {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
      }

      .pagina-mentoria-detalhes .item-horario {
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        min-height: 80px;
        padding: 12px 16px 12px 19px;
        background-color: #f4f6f7;
        border-radius: 5px;
        overflow: hidden;
      }

      .pagina-mentoria-detalhes .item-horario::before {
        content: "";
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        width: 3px;
        background-color: #ad0f0a;
      }

      .pagina-mentoria-detalhes .item-horario-topo {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 7px;
      }

      .pagina-mentoria-detalhes .horario-dia {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 14px;
        line-height: 19px;
        color: #465d67;
      }

      .pagina-mentoria-detalhes .horario-formato {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 13px;
        line-height: 18px;
        color: #64747c;
      }

      .pagina-mentoria-detalhes .item-horario-base {
        display: flex;
        align-items: baseline;
        justify-content: space-between;
        gap: 12px;
      }

      .pagina-mentoria-detalhes .horario-faixa {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 21px;
        line-height: 28px;
        color: #465d67;
      }

      .pagina-mentoria-detalhes .btn-alterar-horario {
        padding: 0;
        background: transparent;
        border: none;
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 13px;
        line-height: 18px;
        color: #000000;
        cursor: pointer;
        white-space: nowrap;
        transition: color 0.15s ease;
      }

      .pagina-mentoria-detalhes .btn-alterar-horario:hover {
        color: #ad0f0a;
        text-decoration: underline;
      }

      .pagina-mentoria-detalhes .card-alunos {
        background-color: #ffffff;
        border: 1px solid #dde3e6;
        border-radius: 8px;
        overflow: hidden;
      }

      .pagina-mentoria-detalhes .card-alunos-cabecalho {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 18px 24px 12px;
      }

      .pagina-mentoria-detalhes .tabela-wrapper {
        width: 100%;
        overflow-x: auto;
      }

      .pagina-mentoria-detalhes .tabela-alunos {
        width: 100%;
        border-collapse: collapse;
        text-align: left;
      }

      .pagina-mentoria-detalhes .tabela-alunos thead,
      .pagina-mentoria-detalhes .tabela-alunos tr.cabecalho-grid {
        background-color: #f4f6f7;
      }

      .pagina-mentoria-detalhes .tabela-alunos th {
        padding: 9px 16px;
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 12px;
        line-height: 16px;
        color: #64747c;
        vertical-align: middle;
      }

      .pagina-mentoria-detalhes .tabela-alunos th:first-child,
      .pagina-mentoria-detalhes .tabela-alunos td:first-child {
        padding-left: 24px;
      }

      .pagina-mentoria-detalhes .tabela-alunos th:last-child,
      .pagina-mentoria-detalhes .tabela-alunos td:last-child {
        padding-right: 24px;
      }

      .pagina-mentoria-detalhes .tabela-alunos th.coluna-situacao {
        text-align: center;
        width: 266px;
      }

      .pagina-mentoria-detalhes .tabela-alunos td {
        padding: 7px 16px;
        border-bottom: 1px solid #e4e8ea;
        vertical-align: middle;
      }

      .pagina-mentoria-detalhes .tabela-alunos tr:last-child td {
        border-bottom: none;
      }

      .pagina-mentoria-detalhes .celula-aluno {
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 14px;
        line-height: 19px;
        color: #465d67;
        white-space: nowrap;
      }

      .pagina-mentoria-detalhes .celula-curso {
        font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
        font-weight: 400;
        font-size: 13px;
        line-height: 18px;
        color: #64747c;
        white-space: nowrap;
      }

      .pagina-mentoria-detalhes .grupo-situacao {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 26px;
      }

      .pagina-mentoria-detalhes .btn-situacao {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 96px;
        height: 25px;
        border: none;
        border-radius: 4px;
        font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
        font-weight: 700;
        font-size: 12px;
        line-height: 16px;
        cursor: pointer;
        transition: filter 0.15s ease;
      }

      .pagina-mentoria-detalhes .btn-situacao:hover {
        filter: brightness(0.95);
      }

      .pagina-mentoria-detalhes .btn-situacao--presente {
        background-color: #eaf2ed;
        color: #34694c;
      }

      .pagina-mentoria-detalhes .btn-situacao--ausente {
        background-color: #fbe4e2;
        color: #ad0f0a;
      }

      .pagina-mentoria-detalhes .rodape-tabela-alunos {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 4px 0 8px;
      }

      .pagina-mentoria-detalhes .btn-ver-mais {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 2px;
        background: transparent;
        border: none;
        cursor: pointer;
      }

      .pagina-mentoria-detalhes .seta {
        width: 31px;
        height: 31px;
        aspect-ratio: 1;
      }

      @media (max-width: 1024px) {
        .pagina-mentoria-detalhes .cabecalho-inner {
          padding: 0 24px;
        }

        .pagina-mentoria-detalhes .conteudo-principal {
          padding: 114px 24px 40px;
        }

        .pagina-mentoria-detalhes .grid-detalhes {
          grid-template-columns: 1fr;
        }
      }

      @media (max-width: 640px) {
        .pagina-mentoria-detalhes .cabecalho-acoes {
          gap: 20px;
        }

        .pagina-mentoria-detalhes .grid-horarios {
          grid-template-columns: 1fr;
        }

        .pagina-mentoria-detalhes .grupo-situacao {
          gap: 12px;
        }
      }
    </style>
</head>
<body data-m3-mode="light">
    <form id="form1" runat="server">
        <div class="pagina-mentoria-detalhes">
            <header class="cabecalho">
              <div class="cabecalho-inner">
                <div class="cabecalho-marca">
                  <img
                    class="logo-fatec-cruzeiro"
                    src="FATEC.png"
                    alt="Fatec Cruzeiro – Prof. Waldomiro May"
                  />

                  <span class="titulo-sistema">Mentoria</span>
                </div>

                <div class="cabecalho-acoes">
                  <nav class="nav-mentor" aria-label="Navegação do mentor">
                    <a href="#minhas-mentorias" class="nav-link nav-link--ativo">
                      Minhas mentorias
                    </a>
                  </nav>

                  <button type="button" class="btn-perfil" aria-label="Perfil do usuário">
                    <img
                      class="perfil-do-usuario"
                      src="img/perfil-do-usu-rio.svg"
                      alt=""
                    />
                  </button>
                </div>
              </div>
            </header>

            <main class="conteudo-principal">
              <div class="container">
                <nav class="breadcrumb" aria-label="Navegação estrutural">
                  <span>Minhas mentorias</span>
                  <span class="breadcrumb-separador">/</span>
                  <span class="breadcrumb-atual">Detalhes</span>
                </nav>

                <section class="topo-pagina">
                  <div class="topo-pagina-textos">
                    <h1 class="titulo-pagina">Detalhes da mentoria</h1>
                    <p class="subtitulo-pagina">
                      Acompanhe as informações, os encontros e os alunos desta mentoria.
                    </p>
                  </div>
                </section>

                <div class="grid-detalhes">
                  <aside class="card-materia" aria-labelledby="titulo-materia">
                    <span class="categoria-materia">MATÉRIA</span>

                    <h2 id="titulo-materia" class="nome-materia">
                      Algoritmos e lógica<br />de programação
                    </h2>

                    <p class="descricao-materia">
                      Reforce os conceitos de lógica, estruturas<br />
                      condicionais e laços de repetição.
                    </p>

                    <div class="divisor-card" aria-hidden="true"></div>

                    <div class="lista-info-materia">
                      <div class="info-item">
                        <span class="info-rotulo">Mentor responsável</span>
                        <span class="info-valor info-valor--destaque">Lucas Oliveira</span>
                      </div>

                      <div class="info-item">
                        <span class="info-rotulo">Curso</span>
                        <span class="info-valor">Análise e Desenvolvimento de Sistemas</span>
                      </div>

                      <div class="info-item">
                        <span class="info-rotulo">Local dos encontros</span>
                        <span class="info-valor">Laboratório de Informática 02</span>
                      </div>
                    </div>

                    <div class="box-ocupacao">
                      <span class="ocupacao-inscritos">4 alunos inscritos</span>
                      <span class="ocupacao-capacidade">10 vagas</span>
                    </div>
                  </aside>

                  <div class="coluna-direita">
                    <section class="card-horarios" aria-labelledby="titulo-horarios">
                      <header class="card-secao-cabecalho">
                        <h2 id="titulo-horarios" class="card-secao-titulo">Horários</h2>
                        <span class="card-secao-meta">Encontros semanais</span>
                      </header>

                      <div class="grid-horarios">
                        <article class="item-horario">
                          <div class="item-horario-topo">
                            <span class="horario-dia">Terça-feira</span>
                            <span class="horario-formato">Presencial</span>
                          </div>
                          <div class="item-horario-base">
                            <strong class="horario-faixa">14h às 16h</strong>
                            <button type="button" class="btn-alterar-horario">
                              Alterar Horário
                            </button>
                          </div>
                        </article>

                        <article class="item-horario">
                          <div class="item-horario-topo">
                            <span class="horario-dia">Quinta-feira</span>
                            <span class="horario-formato">Presencial</span>
                          </div>
                          <div class="item-horario-base">
                            <strong class="horario-faixa">14h às 16h</strong>
                            <button type="button" class="btn-alterar-horario">
                              Alterar Horário
                            </button>
                          </div>
                        </article>
                      </div>
                    </section>

                    <section class="card-alunos" aria-labelledby="titulo-lista-alunos">
                      <header class="card-alunos-cabecalho">
                        <h2 id="titulo-lista-alunos" class="card-secao-titulo">
                          Lista de Alunos
                        </h2>
                        <asp:Label ID="lblTotalAlunos" runat="server" CssClass="card-secao-meta" Text="0 alunos"></asp:Label>
                      </header>

                      <div class="tabela-wrapper">
                        <asp:GridView ID="gvAlunos" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="tabela-alunos"
                            GridLines="None"
                            OnRowCommand="gvAlunos_RowCommand">
                            <HeaderStyle CssClass="cabecalho-grid" />
                            <Columns>
                                <asp:TemplateField HeaderText="Aluno">
                                    <ItemTemplate>
                                        <span class="celula-aluno"><%# Eval("NomeAluno") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Curso / semestre">
                                    <ItemTemplate>
                                        <span class="celula-curso"><%# Eval("CursoSemestre") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Situação">
                                    <HeaderStyle CssClass="coluna-situacao" />
                                    <ItemTemplate>
                                        <div class="grupo-situacao">
                                            <asp:LinkButton ID="btnPresente" runat="server"
                                                CommandName="Presente"
                                                CommandArgument='<%# Eval("IdAluno") %>'
                                                CausesValidation="false"
                                                CssClass="btn-situacao btn-situacao--presente">
                                                Presente
                                            </asp:LinkButton>

                                            <asp:LinkButton ID="btnAusente" runat="server"
                                                CommandName="Ausente"
                                                CommandArgument='<%# Eval("IdAluno") %>'
                                                CausesValidation="false"
                                                CssClass="btn-situacao btn-situacao--ausente">
                                                Ausente
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                      </div>

                      <div class="rodape-tabela-alunos">
                        <button type="button" class="btn-ver-mais" aria-label="Ver mais alunos">
                          <img class="seta" src="img/seta.svg" alt="" />
                        </button>
                      </div>
                    </section>
                  </div>
                </div>
              </div>
            </main>
        </div>
    </form>
</body>
</html>
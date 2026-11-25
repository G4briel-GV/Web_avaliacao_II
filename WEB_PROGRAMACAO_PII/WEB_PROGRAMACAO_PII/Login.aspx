<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Login" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Acesso ao Sistema – Mentoria Fatec Cruzeiro</title>
    <link rel="stylesheet" href="globals.css" />
    <link rel="stylesheet" href="styleguide.css" />
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        .pagina-login {
            min-height: 100vh;
            width: 100%;
            display: flex;
            flex-direction: column;
            background-color: #000000;
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            color: #465d67;
        }

        /* Cabeçalho institucional fixo (padrão unificado do sistema) */
        .pagina-login .cabecalho {
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

        .pagina-login .cabecalho-inner {
            max-width: 1280px;
            height: 100%;
            margin: 0 auto;
            padding: 0 64px 0 13px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .pagina-login .cabecalho-marca {
            display: flex;
            align-items: center;
        }

        .pagina-login .logo-fatec-cruzeiro {
            width: 154px;
            height: 74px;
            object-fit: cover;
        }

        .pagina-login .logo-centro-paula {
            width: 77px;
            height: 52px;
            margin-left: -15px;
            aspect-ratio: 1.55;
            object-fit: cover;
        }

        .pagina-login .titulo-sistema {
            margin-left: 16px;
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            color: #465d67;
            font-size: 36px;
            letter-spacing: 0.1px;
            line-height: 44px;
        }

        /* Área principal com imagem de fundo */
        .pagina-login .area-login {
            position: relative;
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            padding: 130px 24px 28px;
        }

        .pagina-login .fundo-biblioteca {
            position: absolute;
            inset: 0;
            background-color: #000000;
            z-index: 0;
        }

        .pagina-login .nova-imagem {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .pagina-login .escurecimento-preto {
            position: absolute;
            inset: 0;
            background-color: #0000008c;
        }

        /* Card central de acesso */
        .pagina-login .card-acesso {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 640px;
            margin: auto 0;
            padding: 36px 40px 32px;
            background-color: var(--color-background-default-default, #ffffff);
            border-radius: var(--size-radius-200, 8px);
            box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.25);
            overflow: hidden;
        }

        .pagina-login .card-acesso::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background-color: #ad0f0a;
        }

        /* Topo do card */
        .pagina-login .card-acesso-topo {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
        }

        .pagina-login .card-acesso-titulo {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 28px;
            line-height: 38px;
            color: #465d67;
            margin-bottom: 12px;
        }

        .pagina-login .card-acesso-subtitulo {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 16px;
            line-height: 22.4px;
            color: #64747c;
        }

        .pagina-login .icone-acesso {
            width: 40px;
            height: 40px;
            flex-shrink: 0;
            margin-top: 3px;
        }

        /* Formulário */
        .pagina-login .form-login {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .pagina-login .campo-grupo {
            display: flex;
            flex-direction: column;
            gap: var(--size-space-200, 8px);
        }

        .pagina-login .campo-label {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 16px;
            line-height: 22.4px;
            color: var(--color-text-default-default, #1e1e1e);
        }

        .pagina-login .campo-input {
            width: 100%;
            min-width: 120px;
            padding: var(--size-space-300, 12px) var(--size-space-400, 16px);
            background-color: var(--color-background-default-default, #ffffff);
            border: 1px solid var(--color-border-default-default, #d9d9d9);
            border-radius: var(--size-radius-200, 8px);
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 16px;
            line-height: 20px;
            color: var(--color-text-default-default, #1e1e1e);
            outline: none;
            transition: border-color 0.15s ease;
        }

        .pagina-login .campo-input::placeholder {
            color: var(--color-text-default-tertiary, #b3b3b3);
        }

        .pagina-login .campo-input:focus {
            border-color: #465d67;
        }

        .pagina-login .mensagem-erro {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 13px;
            line-height: 18px;
            color: #ad0f0a;
        }

        /* Linha de ações do formulário */
        .pagina-login .form-acoes {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-top: 8px;
        }

        .pagina-login .link-esqueci-senha {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 12px;
            line-height: 16px;
            color: #465d67;
            text-decoration: underline;
        }

        .pagina-login .link-esqueci-senha:hover {
            color: #ad0f0a;
        }

        .pagina-login .btn-avancar {
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
            letter-spacing: 0.1px;
            line-height: 20px;
            color: var(--m3-schemes-on-primary, #ffffff);
            white-space: nowrap;
            cursor: pointer;
            transition: background-color 0.15s ease;
        }

        .pagina-login .btn-avancar:hover {
            background-color: #920c08;
        }

        /* Rodapé interno do card */
        .pagina-login .card-acesso-rodape {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
            margin-top: 32px;
        }

        .pagina-login .texto-apoio {
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 14px;
            line-height: 19.6px;
            color: #64747c;
        }

        .pagina-login .link-diretoria {
            font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
            font-weight: 700;
            font-size: 13px;
            line-height: 18px;
            color: #ad0f0a;
            text-decoration: underline;
        }

        .pagina-login .link-diretoria:hover {
            color: #920c08;
        }

        /* Rodapé inferior sobre o fundo escuro */
        .pagina-login .rodape-login {
            position: relative;
            z-index: 1;
            width: 100%;
            margin-top: 24px;
            text-align: center;
            font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
            font-weight: 400;
            font-size: 13px;
            line-height: 18.2px;
            color: #ffffff;
        }

        /* Ajustes responsivos */
        @media (max-width: 1024px) {
            .pagina-login .cabecalho-inner {
                padding: 0 24px;
            }
        }

        @media (max-width: 640px) {
            .pagina-login .area-login {
                padding: 114px 16px 24px;
            }

            .pagina-login .card-acesso {
                padding: 28px 24px 24px;
            }

            .pagina-login .card-acesso-titulo {
                font-size: 24px;
                line-height: 32px;
            }
        }
    </style>
</head>
<body data-m3-mode="light" data-color-mode="SDS-light">
    <form id="form1" runat="server">
        <div class="pagina-login">
            <!-- Cabeçalho institucional fixo (padrão unificado do sistema) -->
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
                </div>
            </header>

            <!-- Área principal com fundo da biblioteca -->
            <main class="area-login">
                <div class="fundo-biblioteca" aria-hidden="true">
                    <img
                        class="nova-imagem"
                        src="img/nova-imagem-biblioteca.png"
                        alt=""
                    />
                    <div class="escurecimento-preto"></div>
                </div>

                <!-- Card central de autenticação -->
                <section class="card-acesso" aria-labelledby="titulo-acesso">
                    <header class="card-acesso-topo">
                        <div class="card-acesso-textos">
                            <h1 id="titulo-acesso" class="card-acesso-titulo">
                                Acesse sua conta
                            </h1>
                            <p class="card-acesso-subtitulo">
                                Entre com seu e-mail institucional para continuar.
                            </p>
                        </div>
                        <img
                            class="icone-acesso"
                            src="img/cone-de-acesso.svg"
                            alt="Ícone de acesso"
                        />
                    </header>

                    <div class="form-login">
                        <div class="campo-grupo">
                            <label for="txtEmail" class="campo-label">E-mail</label>
                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                ClientIDMode="Static"
                                TextMode="Email"
                                CssClass="campo-input"
                                placeholder="aluno01@aluno.cps.sp.gov.br"
                                autocomplete="email">
                            </asp:TextBox>
                        </div>

                        <div class="campo-grupo">
                            <label for="txtSenha" class="campo-label">Senha</label>
                            <asp:TextBox
                                ID="txtSenha"
                                runat="server"
                                ClientIDMode="Static"
                                TextMode="Password"
                                CssClass="campo-input"
                                placeholder="••••••••"
                                autocomplete="current-password">
                            </asp:TextBox>
                        </div>

                        <asp:Label ID="lblMensagem" runat="server" CssClass="mensagem-erro" Visible="false"></asp:Label>

                        <div class="form-acoes">
                            <asp:LinkButton ID="lnkEsqueciSenha" runat="server" CssClass="link-esqueci-senha" OnClick="lnkEsqueciSenha_Click">
                                Esqueci a senha.
                            </asp:LinkButton>

                            <asp:Button ID="btnAvancar" runat="server" Text="Avançar" CssClass="btn-avancar" OnClick="btnAvancar_Click" />
                        </div>
                    </div>

                    <div class="card-acesso-rodape">
                        <p class="texto-apoio">
                            Sua jornada de aprendizado continua aqui.
                        </p>
                        <asp:LinkButton ID="LnkAcessoDiretoria" runat="server" CssClass="link-diretoria" OnClick="lnkAcessoDiretoria_Click">
                            Acesso da diretoria
                        </asp:LinkButton>
                    </div>
                </section>

                <!-- Assinatura institucional na base -->
                <footer class="rodape-login">
                    <p>Mentoria Fatec Cruzeiro · Apoio para sua jornada acadêmica</p>
                </footer>
            </main>
        </div>
    </form>
</body>
</html>
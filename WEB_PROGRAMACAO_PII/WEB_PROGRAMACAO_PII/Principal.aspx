<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="WEB_PROGRAMACAO_PII.Principal" %>

<!DOCTYPE html>
<html lang="pt-BR" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Mentoria – Fatec Cruzeiro</title>
  <style type="text/css">
    .pagina-inicial {
      background-color: #f8f8f8;
      min-height: 100vh;
      width: 100%;
      display: flex;
      flex-direction: column;
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      color: #465d67;
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
      letter-spacing: 0.1px;
      line-height: 44px;
    }

    .pagina-inicial .cabecalho-acoes {
      display: flex;
      align-items: center;
    }

    .pagina-inicial .btn-login {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      height: 44px;
      padding: 0 22px;
      background-color: #ad0f0a;
      border: none;
      color: #ffffff;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.15s ease;
    }

    .pagina-inicial .btn-login:hover {
      background-color: #920c08;
    }

    .pagina-inicial .btn-login-label {
      font-family: var(--m3-label-large-font-family, "Roboto", Helvetica, sans-serif);
      font-weight: var(--m3-label-large-font-weight, 500);
      font-size: var(--m3-label-large-font-size, 14px);
      letter-spacing: var(--m3-label-large-letter-spacing, 0.1px);
      line-height: var(--m3-label-large-line-height, 20px);
      color: var(--m3-schemes-on-primary, #ffffff);
      white-space: nowrap;
    }

    .pagina-inicial .conteudo-principal {
      padding-top: 90px;
      flex: 1;
    }

    .pagina-inicial .secao-hero {
      position: relative;
      width: 100%;
      min-height: 480px;
      padding: 64px;
      display: flex;
      align-items: center;
      overflow: hidden;
      background-color: #2b3940;
    }

    .pagina-inicial .hero-imagem-fundo {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      z-index: 0;
    }

    .pagina-inicial .hero-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(
        90deg,
        rgba(18, 24, 28, 0.72) 0%,
        rgba(18, 24, 28, 0.42) 55%,
        rgba(18, 24, 28, 0.18) 100%
      );
      z-index: 1;
    }

    .pagina-inicial .hero-conteudo {
      position: relative;
      z-index: 2;
    }

    .pagina-inicial .hero-eyebrow {
      display: block;
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 13px;
      line-height: 18.9px;
      letter-spacing: 0.4px;
      color: #ffffff;
      margin-bottom: 24px;
    }

    .pagina-inicial .hero-titulo {
      max-width: 580px;
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 46px;
      line-height: 52.9px;
      color: #ffffff;
      margin-bottom: 24px;
    }

    .pagina-inicial .hero-subtitulo {
      max-width: 565px;
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-weight: 400;
      font-size: 18px;
      line-height: 26.1px;
      color: #ffffff;
      margin-bottom: 32px;
    }

    .pagina-inicial .hero-acoes {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      gap: 16px;
      margin-bottom: 20px;
    }

    .pagina-inicial .btn-primario {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      min-width: 218px;
      height: 48px;
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

    .pagina-inicial .btn-primario:hover {
      background-color: #920c08;
    }

    .pagina-inicial .btn-secundario {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      min-width: 136px;
      height: 48px;
      padding: 0 24px;
      background-color: #ffffff;
      border: 1px solid #dde3e6;
      border-radius: 8px;
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 14px;
      line-height: 20px;
      color: #465d67;
      white-space: nowrap;
      cursor: pointer;
      transition: background-color 0.15s ease, border-color 0.15s ease;
    }

    .pagina-inicial .btn-secundario:hover {
      background-color: #f1f4f6;
      border-color: #c5cfd4;
    }

    .pagina-inicial .hero-nota {
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-weight: 400;
      font-size: 14px;
      line-height: 20.3px;
      color: #ffffff;
    }

    .pagina-inicial .secao-passos {
      background-color: #f8f8f8;
      padding: 35px 64px 80px;
    }

    .pagina-inicial .divisor-secao {
      width: 100%;
      height: 1px;
      background-color: #dde3e6;
      margin-bottom: 18px;
    }

    .pagina-inicial .secao-passos-titulo {
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 28px;
      line-height: 38px;
      color: #465d67;
      margin-bottom: 36px;
    }

    .pagina-inicial .cards-passos {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
    }

    .pagina-inicial .card-passo {
      position: relative;
      display: flex;
      flex-direction: column;
      min-height: 184px;
      padding: 20px 24px 24px;
      background-color: #ffffff;
      border: 1px solid #dde3e6;
      border-radius: 8px;
      overflow: hidden;
    }

    .pagina-inicial .card-passo::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background-color: #ad0f0a;
    }

    .pagina-inicial .card-passo-numero {
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 13px;
      line-height: 18px;
      color: #ad0f0a;
      margin-bottom: 14px;
    }

    .pagina-inicial .card-passo-titulo {
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 20px;
      line-height: 27px;
      color: #465d67;
      margin-bottom: 13px;
    }

    .pagina-inicial .card-passo-descricao {
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-weight: 400;
      font-size: 15px;
      line-height: 22px;
      color: #64747c;
    }

    .pagina-inicial .rodape {
      background-color: #000000;
      padding: 40px 64px 24px;
    }

    .pagina-inicial .rodape-colunas {
      display: grid;
      grid-template-columns: 1.1fr 0.9fr;
      gap: 48px;
      margin-bottom: 28px;
    }

    .pagina-inicial .rodape-titulo {
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 20px;
      line-height: 29px;
      color: #ffffff;
      margin-bottom: 16px;
    }

    .pagina-inicial .rodape-destaque {
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-weight: 400;
      font-size: 16px;
      line-height: 23.2px;
      color: #f5f5f5;
      margin-bottom: 12px;
    }

    .pagina-inicial .rodape-texto-suave {
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-weight: 400;
      font-size: 14px;
      line-height: 20.3px;
      color: #dde3e6;
    }

    .pagina-inicial .rodape-lista-contato {
      list-style: none;
      padding: 0;
      margin: 0 0 14px;
      display: flex;
      flex-direction: column;
      gap: 8px;
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-size: 14px;
      line-height: 20.3px;
      color: #f5f5f5;
    }

    .pagina-inicial .rodape-endereco {
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-size: 13px;
      line-height: 18.9px;
      color: #dde3e6;
    }

    .pagina-inicial .divisor-rodape {
      width: 100%;
      height: 1px;
      background-color: #64747c;
      margin-bottom: 14px;
    }

    .pagina-inicial .rodape-base {
      display: grid;
      grid-template-columns: 1fr auto 1fr;
      align-items: center;
      gap: 24px;
    }

    .pagina-inicial .rodape-link {
      font-family: "Arimo-Bold", Helvetica, Arial, sans-serif;
      font-weight: 700;
      font-size: 15px;
      line-height: 21.8px;
      color: #f5f5f5;
      text-decoration: underline;
      justify-self: start;
    }

    .pagina-inicial .rodape-link:hover {
      color: #ffffff;
    }

    .pagina-inicial .rodape-brasao {
      width: 130px;
      height: 60px;
      border-radius: 8px;
      aspect-ratio: 0.86;
      object-fit: cover;
    }

    .pagina-inicial .rodape-copyright {
      font-family: "Arimo-Regular", Helvetica, Arial, sans-serif;
      font-weight: 400;
      font-size: 12px;
      line-height: 17.4px;
      color: #dde3e6;
      text-align: right;
      justify-self: end;
    }

    @media (max-width: 1024px) {
      .pagina-inicial .cabecalho-inner {
        padding: 0 24px;
      }

      .pagina-inicial .secao-hero,
      .pagina-inicial .secao-passos,
      .pagina-inicial .rodape {
        padding-left: 24px;
        padding-right: 24px;
      }

      .pagina-inicial .cards-passos {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 768px) {
      .pagina-inicial .hero-titulo {
        font-size: 34px;
        line-height: 40px;
      }

      .pagina-inicial .rodape-colunas {
        grid-template-columns: 1fr;
        gap: 32px;
      }

      .pagina-inicial .rodape-base {
        grid-template-columns: 1fr;
        justify-items: start;
        gap: 16px;
      }

      .pagina-inicial .rodape-copyright {
        text-align: left;
        justify-self: start;
      }
    }
  </style>
</head>
<body data-m3-mode="light">
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

          <div class="cabecalho-acoes">
              <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login"/>
              <span class="btn-login-label">Login</span>
          </div>
        </div>
      </header>

      <main class="conteudo-principal">
        <section class="secao-hero" aria-labelledby="titulo-hero">
          <img
            class="hero-imagem-fundo"
            src="biblioteca.jpg"
            alt="Biblioteca"
          />
          <div class="hero-overlay" aria-hidden="true"></div>

          <div class="container hero-conteudo">
            <span class="hero-eyebrow">MENTORIA PARA ALUNOS</span>

            <h1 id="titulo-hero" class="hero-titulo">
              Seu futuro merece<br />uma boa conversa.
            </h1>

            <p class="hero-subtitulo">
              Conecte-se com mentores, tire suas dúvidas e encontre<br />
              mais clareza para sua jornada acadêmica e profissional.
            </p>

            <div class="hero-acoes">
                <asp:Button ID="btnAgendar" runat="server" Text="Agendar minha mentoria" CssClass="btn-primario"/>
                <asp:Button ID="btnMentor" runat="server" Text="Sou mentor" CssClass="btn-secundario"/>
            </div>

            <p class="hero-nota">No seu ritmo. Com orientação de verdade.</p>
          </div>
        </section>

        <section class="secao-passos" aria-labelledby="titulo-passos">
          <div class="container">
            <div class="divisor-secao" aria-hidden="true"></div>

            <h2 id="titulo-passos" class="secao-passos-titulo">
              Passos para agendar sua Mentoria:
            </h2>

            <div class="cards-passos">
              <article class="card-passo">
                <span class="card-passo-numero">01</span>
                <h3 class="card-passo-titulo">Encontre seu mentor</h3>
                <p class="card-passo-descricao">
                  Escolha quem pode ajudar com suas<br />
                  dúvidas e seus objetivos.
                </p>
              </article>

              <article class="card-passo">
                <span class="card-passo-numero">02</span>
                <h3 class="card-passo-titulo">Escolha um horário</h3>
                <p class="card-passo-descricao">
                  Encontre um momento que combine<br />
                  com sua rotina de estudos.
                </p>
              </article>

              <article class="card-passo">
                <span class="card-passo-numero">03</span>
                <h3 class="card-passo-titulo">Converse e evolua</h3>
                <p class="card-passo-descricao">
                  Receba orientação e tire suas dúvidas.
                </p>
              </article>
            </div>
          </div>
        </section>
      </main>

      <footer class="rodape">
        <div class="container rodape-inner">
          <div class="rodape-colunas">
            <div class="rodape-coluna">
              <h3 class="rodape-titulo">Sobre</h3>
              <p class="rodape-destaque">
                Faculdade de Tecnologia de Cruzeiro – Prof. Waldomiro May
              </p>
              <p class="rodape-texto-suave">
                Educação tecnológica de qualidade para formar profissionais competentes.
              </p>
            </div>

            <div class="rodape-coluna">
              <h3 class="rodape-titulo">Contato</h3>
              <ul class="rodape-lista-contato">
                <li>Tel: (12) 3141-1450</li>
                <li>WhatsApp: (12) 9 9667-0612</li>
                <li>Email: f127acad@cps.sp.gov.br</li>
              </ul>
              <p class="rodape-endereco">
                Avenida Rotary, 383 – Vila Paulista, Cruzeiro – SP, CEP 12.701-170
              </p>
            </div>
          </div>

          <div class="divisor-rodape" aria-hidden="true"></div>

          <div class="rodape-base">
            <a
              href="https://fateccruzeiro.edu.br/"
              target="_blank"
              rel="noopener noreferrer"
              class="rodape-link"
            >
              Acesse o site da Fatec Cruzeiro
            </a>

            <img
              class="rodape-brasao"
              src="sp.png"
              alt="Governo do Estado de São Paulo"
            />

            <p class="rodape-copyright">
              © 2026 – Faculdade de Tecnologia de Cruzeiro – Prof. Waldomiro May<br />
              Todos os direitos reservados | Vinculado ao Centro Paula Souza
            </p>
          </div>
        </div>
      </footer>
    </div>
  </form>
</body>
</html>

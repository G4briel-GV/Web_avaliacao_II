<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TelaAluno.aspx.cs" Inherits="TelaAluno.WebForm1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Minhas mentorias – Fatec Cruzeiro</title>
    <style>
        body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f8f8f8;
        color: #465d67;
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

        .btnSair{
         background-color: #ad0f0a;
         color: #ffffff;
         border: none;
         border-radius: 6px;
         padding: 10px 18px;
         font-size: 14px;
         font-weight: bold;
         cursor: pointer;
         white-space: nowrap;
        }

        .conteudo-principal {
         max-width: 1200px;
         margin: 0 auto;
         padding: 100px 24px 40px;
        }

        .topo-pagina {
         display: flex;
         justify-content: space-between;
         align-items: center;
        }

        .titulo {
         margin: 0 0 4px 0;
         font-size: 26px;
        }

        .subtitulo {
         margin: 0;
         font-size: 14px;
         color: #64747c;
        }
        .btnAgendarMentoria {
         background-color: #ad0f0a;
         color: #ffffff;
         border: none;
         border-radius: 6px;
         padding: 10px 18px;
         font-size: 14px;
         font-weight: bold;
         cursor: pointer;
        }

        .card-mentoria {
         display: flex;
         align-items: flex-start;
         gap: 24px;
         margin-top: 38px;
         }

        .mentoria-agendada {
         background-color: #ffffff;
         border: 1px solid #e5eaed;
         border-radius: 12px;
         padding: 24px;
         flex: 2;
        }

        .proxima-mentoria {
         display: block;
         font-size: 12px;
         font-weight: bold;
         letter-spacing: 0.5px;
         color: #ad0f0a;
         margin-bottom: 8px;
        }

        .titulo-mentoria {
         margin: 0 0 6px 0;
         font-size: 24px;
         color: #364952;
        }

        .mentor {
         margin: 0 0 20px 0;
         font-size: 14px;
         color: #64747c;
        }

        .info-mentoria {
         display: flex;
         gap: 48px;
         flex-wrap: wrap;
         margin-bottom: 24px;
        }

        .label-info {
         display: block;
         font-size: 13px;
         color: #64747c;
         margin-bottom: 4px;
        }

        .valor-info {
         font-size: 15px;
         color: #364952;
         font-weight: normal;
        }

        .area-status {
         display: flex;
         align-items: center;
         margin-bottom: 16px;
        }

        .status-agendamento {
        display: inline-block;
        background-color: #eef1f3;
        color: #465d67;
        font-size: 13px;
        font-weight: bold;
        padding: 8px 14px;
        border-radius: 6px;
        }

        .card-ausencia {
         background-color: #f8f8f8;
         border: 1px solid #e5eaed;
         border-radius: 12px;
         padding: 24px;
         box-sizing: border-box;
         max-width: 360px;
        }

        .titulo-ausencia {
         margin: 0 0 12px 0;
         font-size: 18px;
         color: #364952;
        }
        .btn-ausencia{
         width: 100%;
         background-color: #ffffff;
         color: #ad0f0a;
         border: 1px solid #ad0f0a;
         border-radius: 6px;
         padding: 10px 16px;
         font-size: 14px;
         font-weight: bold;
         cursor: pointer;
         box-sizing: border-box;
        }
        .obs-ausencia {
         margin: 14px 0 0 0;
         font-size: 13px;
         color: #64747c;
        }

      </style>
    </head>
 <body>
    <form id="form1" runat="server">
        <div class ="pagina-Aluno-Mentoria">
            <header class="cabecalho">

                <div class="conteudo-cabecalho">
                    <div>
                        <img class="logo-sistema" src="FATEC.png" alt="Logo do sistema" />
                        <span class="titulo-cabecalho">Área do Aluno</span>
                    </div>

                    <div class="btn-cabecalho">
                        <asp:Button ID="BtnSair" runat="server" Text="Sair" CssClass="btnSair" OnClick="BtnSair_Click" />
                    </div>
                 </div>
            </header>

            <main class="conteudo-principal">
                <section class="topo-pagina">
                    <div>
                        <h1 class="titulo">Minhas mentorias</h1>
                        <p class="subtitulo">Acompanhe suas aulas e agende suas próximas mentorias.</p>
                    </div>

                    <asp:Button ID="BtnAgendarMentoria" runat="server" Text="Agendar Mentoria" CssClass="btnAgendarMentoria" OnClick="BtnAgendarMentoria_Click" />
                </section>

                <section class="card-mentoria">
                    <div class="mentoria-agendada">
                        <span class="proxima-mentoria">PRÓXIMA MENTORIA</span>

                        <h2 class="titulo-mentoria">
                            <asp:Label ID="LblMateria" runat="server" Text="Nenhuma mentoria agendada" />
                        </h2>

                        <p class="mentor">
                            <asp:Label ID="LblMentor" runat="server" Text="" />
                        </p>

                        <div class="info-mentoria">
                            <div>
                                <span class="label-info">Data</span>
                                <span class="valor-info">
                                    <asp:Label ID="LblDtMentoria" runat="server" Text="" />
                                </span>
                            </div>

                            <div>
                                <span class="label-info">Dia</span>
                                <span class="valor-info">
                                    <asp:Label ID="LblDiaSemana" runat="server" Text="" />
                                </span>
                            </div>

                            <div>
                                <span class="label-info">Horário</span>
                                <span class="valor-info">
                                    <asp:Label ID="LblHorarioProxima" runat="server" Text="" />
                                </span>
                            </div>
                        </div>

                        <div class="area-status">
                            <asp:Label ID="LblStatus" runat="server" Text="" CssClass="status-agendamento" />
                        </div>
                    </div>

                    <div class="card-ausencia">
                        <h3 class="titulo-ausencia">Não poderá comparecer?</h3>

                        <asp:Button ID="BtnComunicarAusencia" runat="server" Text="Comunicar ausência" CssClass="btn-ausencia" OnClick="BtnComunicarAusencia_Click" />

                        <p class="obs-ausencia">Obs.: avise com antecedência.</p>
                    </div>
                </section>
            </main>
        </div>
    </form>
</body>
</html>
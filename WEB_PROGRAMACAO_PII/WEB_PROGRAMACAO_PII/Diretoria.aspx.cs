using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WEB_PROGRAMACAO_PII
{
    public partial class Diretoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["tipo_usuario"] == null || Session["tipo_usuario"].ToString() != "coordenacao")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                CarregarDados();
            }
        }

        // Dados de exemplo para testar a tela antes de conectar ao BancoDados.mdf
        private DataTable ObterDadosExemplo()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Periodo", typeof(string));
            dt.Columns.Add("Data", typeof(string));
            dt.Columns.Add("Hora", typeof(string));
            dt.Columns.Add("Aluno", typeof(string));
            dt.Columns.Add("Mentor", typeof(string));
            dt.Columns.Add("Assunto", typeof(string));
            dt.Columns.Add("PresencaAluno", typeof(string));
            dt.Columns.Add("PresencaMentor", typeof(string));
            dt.Columns.Add("Situacao", typeof(string));
            dt.Columns.Add("FiltroSituacao", typeof(string));
            dt.Columns.Add("ClasseBadge", typeof(string));
            dt.Columns.Add("TextoRegistro", typeof(string));

            dt.Rows.Add(1, "16-20-nov-2026", "16/11", "08:00", "Ana Beatriz Lima", "Prof. Ricardo Alves", "Lógica de programação", "Presente", "Presente", "Realizada", "realizada", "badge badge--realizada", "Ver registro");
            dt.Rows.Add(2, "16-20-nov-2026", "16/11", "09:00", "Lucas Ferreira", "Profa. Camila Rocha", "Banco de dados", "Presente", "Presente", "Realizada", "realizada", "badge badge--realizada", "Ver registro");
            dt.Rows.Add(3, "16-20-nov-2026", "16/11", "10:00", "Mariana Costa", "Prof. Ricardo Alves", "Lógica de programação", "Ausente", "Presente", "Aluno ausente", "aluno-ausente", "badge badge--ausente", "Ver registro");
            dt.Rows.Add(4, "16-20-nov-2026", "16/11", "11:00", "Pedro Henrique", "Prof. André Santos", "Matemática", "Presente", "Ausente", "Mentor ausente", "mentor-ausente", "badge badge--ausente", "Ver registro");
            dt.Rows.Add(5, "16-20-nov-2026", "16/11", "13:00", "Juliana Ribeiro", "Profa. Camila Rocha", "Eng. de software", "Presente", "Presente", "Realizada", "realizada", "badge badge--realizada", "Ver registro");
            dt.Rows.Add(6, "16-20-nov-2026", "18/11", "14:00", "Rafael Oliveira", "Prof. André Santos", "Matemática", "Pendente", "Pendente", "Agendada", "agendada", "badge badge--agendada", "Registrar presença");

            return dt;
        }

        // Aplica os filtros dos DropDownLists e da busca no GridView e atualiza os cards
        private DataView FiltrarTabela()
        {
            DataTable dt = ObterDadosExemplo(); // Substituir pelo DataTable retornado da classe de banco do grupo
            DataView dv = dt.DefaultView;

            string filtro = "1=1";

            if (ddlFiltroPeriodo.SelectedValue != "todos")
            {
                filtro += $" AND Periodo = '{ddlFiltroPeriodo.SelectedValue}'";
            }

            if (!string.IsNullOrWhiteSpace(txtFiltroBusca.Text))
            {
                string busca = txtFiltroBusca.Text.Replace("'", "''");
                filtro += $" AND (Aluno LIKE '%{busca}%' OR Mentor LIKE '%{busca}%')";
            }

            if (ddlFiltroSituacao.SelectedValue != "todas")
            {
                filtro += $" AND FiltroSituacao = '{ddlFiltroSituacao.SelectedValue}'";
            }

            if (ddlFiltroPresenca.SelectedValue == "falta-aluno")
                filtro += " AND PresencaAluno = 'Ausente'";
            else if (ddlFiltroPresenca.SelectedValue == "falta-mentor")
                filtro += " AND PresencaMentor = 'Ausente'";
            else if (ddlFiltroPresenca.SelectedValue == "pendente")
                filtro += " AND (PresencaAluno = 'Pendente' OR PresencaMentor = 'Pendente')";

            dv.RowFilter = filtro;
            return dv;
        }

        private void CarregarDados()
        {
            DataView dv = FiltrarTabela();

            gvMentorias.DataSource = dv;
            gvMentorias.DataBind();

            int total = dv.Count;
            int realizadas = 0;
            int faltaAluno = 0;
            int faltaMentor = 0;

            foreach (DataRowView row in dv)
            {
                if (row["FiltroSituacao"].ToString() == "realizada") realizadas++;
                if (row["PresencaAluno"].ToString() == "Ausente") faltaAluno++;
                if (row["PresencaMentor"].ToString() == "Ausente") faltaMentor++;
            }

            lblTotalMentorias.Text = total.ToString();
            lblRealizadas.Text = realizadas.ToString();
            lblFaltaAluno.Text = faltaAluno.ToString();
            lblFaltaMentor.Text = faltaMentor.ToString();

            lblContadorTabela.Text = $"{total} registros no período";
            lblRodapeExibicao.Text = $"Exibindo {total} mentorias";
        }

        // Evento compartilhado pela caixa de busca e pelos 3 DropDownLists
        protected void FiltrarMentorias(object sender, EventArgs e)
        {
            CarregarDados();
        }

        // Botão "Limpar"
        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            txtFiltroBusca.Text = string.Empty;
            ddlFiltroPeriodo.SelectedIndex = 0;
            ddlFiltroSituacao.SelectedIndex = 0;
            ddlFiltroPresenca.SelectedIndex = 0;
            CarregarDados();
        }

        // Botão "Exportar relatório" (gera download em CSV limpo para Excel)
        protected void btnExportarRelatorio_Click(object sender, EventArgs e)
        {
            DataView dv = FiltrarTabela();
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("Data;Hora;Aluno;Mentor;Assunto;Presenca Aluno;Presenca Mentor;Situacao");
            foreach (DataRowView row in dv)
            {
                sb.AppendLine($"{row["Data"]};{row["Hora"]};{row["Aluno"]};{row["Mentor"]};{row["Assunto"]};{row["PresencaAluno"]};{row["PresencaMentor"]};{row["Situacao"]}");
            }

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "text/csv";
            Response.ContentEncoding = Encoding.UTF8;
            Response.BinaryWrite(Encoding.UTF8.GetPreamble());
            Response.AddHeader("content-disposition", "attachment;filename=Relatorio_Mentorias.csv");
            Response.Write(sb.ToString());
            Response.End();
        }

        // Botão "Sair"
        protected void btnSair_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        // Destaca em vermelho as linhas e células onde houve ausência no GridView
        protected void gvMentorias_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string presencaAluno = DataBinder.Eval(e.Row.DataItem, "PresencaAluno").ToString();
                string presencaMentor = DataBinder.Eval(e.Row.DataItem, "PresencaMentor").ToString();

                if (presencaAluno == "Ausente")
                {
                    e.Row.CssClass = "linha-alerta";
                    e.Row.Cells[4].CssClass = "texto-ausente";
                }

                if (presencaMentor == "Ausente")
                {
                    e.Row.CssClass = "linha-alerta";
                    e.Row.Cells[5].CssClass = "texto-ausente";
                }
            }
        }

        // Clique nos links "Ver registro" ou "Registrar presença" dentro do GridView
        protected void gvMentorias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerRegistro")
            {
                string idMentoria = e.CommandArgument.ToString();
                // Aqui vocês podem redirecionar para a tela de detalhes passando o ID, ex:
                // Response.Redirect($"RegistroMentoria.aspx?id={idMentoria}");
            }
        }

        protected void Fi(object sender, EventArgs e)
        {

        }
    }
}
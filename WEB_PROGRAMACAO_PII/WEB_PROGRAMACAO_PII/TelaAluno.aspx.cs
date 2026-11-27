using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;

namespace TelaAluno
{
    public partial class WebForm1 : Page
    {
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id_aluno"] == null)
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!IsPostBack)
            {
                CarregarProximaMentoria();
            }
        }

        private void CarregarProximaMentoria()
        {
            string sql = @"SELECT TOP 1
                               mat.nome AS nome_disciplina,
                               mentor.nome AS nome_mentor,
                               m.data,
                               m.hora_inicio,
                               m.hora_final,
                               m.status
                           FROM Mentoria m
                           INNER JOIN Materia mat ON m.id_materia = mat.id_materia
                           INNER JOIN Aluno mentor ON m.id_mentor = mentor.id_aluno
                           WHERE m.id_aluno = @idAluno
                             AND m.data = '2026-11-26'
                             AND m.status <> 'Cancelada'
                           ORDER BY m.data ASC, m.hora_inicio ASC";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@idAluno", SqlDbType.Int).Value = Convert.ToInt32(Session["id_aluno"]);

                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        DateTime dataMentoria = Convert.ToDateTime(dr["data"]);
                        TimeSpan horaInicio = (TimeSpan)dr["hora_inicio"];
                        TimeSpan horaFinal = (TimeSpan)dr["hora_final"];
                        CultureInfo ptBr = new CultureInfo("pt-BR");
                        string diaSemana = dataMentoria.ToString("dddd", ptBr);

                        LblMateria.Text = dr["nome_disciplina"].ToString();
                        LblMentor.Text = dr["nome_mentor"].ToString();
                        LblDtMentoria.Text = dataMentoria.ToString("dd/MM/yyyy");
                        LblDiaSemana.Text = char.ToUpper(diaSemana[0], ptBr) + diaSemana.Substring(1);
                        LblHorarioProxima.Text = $"{horaInicio:hh\\:mm} - {horaFinal:hh\\:mm}";
                        LblStatus.Text = dr["status"].ToString();
                    }
                    else
                    {
                        LblMateria.Text = "Nenhuma mentoria agendada";
                        LblMentor.Text = "-";
                        LblDtMentoria.Text = "-";
                        LblDiaSemana.Text = "-";
                        LblHorarioProxima.Text = "-";
                        LblStatus.Text = "-";
                    }
                }
            }
        }

        protected void BtnAgendarMentoria_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgendarMentoria.aspx");
        }

        protected void BtnSair_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void BtnComunicarAusencia_Click(object sender, EventArgs e)
        {
            BtnComunicarAusencia.Enabled = false;
            BtnComunicarAusencia.Text = "Ausência comunicada";
        }
    }
}
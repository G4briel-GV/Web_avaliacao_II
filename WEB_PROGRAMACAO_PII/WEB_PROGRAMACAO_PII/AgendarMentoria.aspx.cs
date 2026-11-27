using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace TelaAluno
{
    public partial class AgendarMentoria : System.Web.UI.Page
    {
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id_aluno"] == null ||
                (Session["tipo_usuario"] != null && Session["tipo_usuario"].ToString() == "coordenacao"))
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!IsPostBack)
            {
                CarregarMentores();
            }
        }

        private void CarregarMentores()
        {
            ddlMentor.Items.Clear();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT id_aluno, nome FROM Aluno WHERE mentor = 'S' ORDER BY nome", conn))
            {
                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    ddlMentor.DataSource = dr;
                    ddlMentor.DataTextField = "nome";
                    ddlMentor.DataValueField = "id_aluno";
                    ddlMentor.DataBind();
                }
            }

            ddlMentor.Items.Insert(0, new ListItem("", "0"));
        }

        protected void ddlMentor_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMensagem.Visible = false;
            ddlMateria.Items.Clear();
            ddlDia.Items.Clear();
            ddlHorario.Items.Clear();

            if (ddlMentor.SelectedValue == "0") return;

            int idMentor = Convert.ToInt32(ddlMentor.SelectedValue);
            HashSet<string> diasDisponiveis = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string sqlMateria = @"SELECT m.id_materia, m.nome
                                      FROM Materia m
                                      INNER JOIN mentor_materia md ON m.id_materia = md.id_materia
                                      WHERE md.id_aluno = @idMentor
                                      ORDER BY m.nome";

                using (SqlCommand cmd = new SqlCommand(sqlMateria, conn))
                {
                    cmd.Parameters.AddWithValue("@idMentor", idMentor);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        ddlMateria.DataSource = dr;
                        ddlMateria.DataTextField = "nome";
                        ddlMateria.DataValueField = "id_materia";
                        ddlMateria.DataBind();
                    }
                }
                ddlMateria.Items.Insert(0, new ListItem("", "0"));

                string sqlDias = @"SELECT DISTINCT LOWER(LTRIM(RTRIM(dia_semana))) AS dia_semana
                                   FROM Disponibilidade
                                   WHERE id_aluno = @idMentor";

                using (SqlCommand cmd = new SqlCommand(sqlDias, conn))
                {
                    cmd.Parameters.AddWithValue("@idMentor", idMentor);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            diasDisponiveis.Add(dr["dia_semana"].ToString());
                        }
                    }
                }
            }

            DateTime hoje = DateTime.Today;
            for (int i = 0; i < 14; i++)
            {
                DateTime dataFutura = hoje.AddDays(i);
                string siglaDia = ObterSiglaDiaSemana(dataFutura.DayOfWeek);

                if (diasDisponiveis.Contains(siglaDia))
                {
                    ddlDia.Items.Add(new ListItem($"{dataFutura:dd/MM/yyyy} ({siglaDia})", dataFutura.ToString("yyyy-MM-dd")));
                }
            }
            ddlDia.Items.Insert(0, new ListItem("", "0"));
        }

        protected void ddlDia_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMensagem.Visible = false;
            ddlHorario.Items.Clear();

            if (ddlMentor.SelectedValue == "0" || ddlDia.SelectedValue == "0" || string.IsNullOrEmpty(ddlDia.SelectedValue))
                return;

            DateTime dataSelecionada = Convert.ToDateTime(ddlDia.SelectedValue).Date;
            string siglaDia = ObterSiglaDiaSemana(dataSelecionada.DayOfWeek);

            string sqlHora = @"SELECT
                                CONVERT(VARCHAR(5), d.inicio, 108) + ' - ' + CONVERT(VARCHAR(5), d.fim, 108) AS texto,
                                CONVERT(VARCHAR(8), d.inicio, 108) + '|' + CONVERT(VARCHAR(8), d.fim, 108) AS valor
                               FROM Disponibilidade d
                               WHERE d.id_aluno = @idMentor
                                 AND LOWER(LTRIM(RTRIM(d.dia_semana))) = @diaSemana
                                 AND NOT EXISTS (
                                     SELECT 1 FROM Mentoria m
                                     WHERE m.id_mentor = d.id_aluno
                                       AND m.data = @data
                                       AND m.hora_inicio = d.inicio
                                       AND m.hora_final = d.fim
                                       AND m.status <> 'Cancelada'
                                 )
                               ORDER BY d.inicio";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sqlHora, conn))
            {
                cmd.Parameters.AddWithValue("@idMentor", Convert.ToInt32(ddlMentor.SelectedValue));
                cmd.Parameters.AddWithValue("@diaSemana", siglaDia);
                cmd.Parameters.Add("@data", SqlDbType.Date).Value = dataSelecionada;

                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    ddlHorario.DataSource = dr;
                    ddlHorario.DataTextField = "texto";
                    ddlHorario.DataValueField = "valor";
                    ddlHorario.DataBind();
                }
            }

            ddlHorario.Items.Insert(0, new ListItem("", "0"));
        }

        protected void BtnAgendar_Click(object sender, EventArgs e)
        {
            if (ddlMentor.SelectedValue == "0" || ddlMateria.SelectedValue == "0" ||
                ddlDia.SelectedValue == "0" || ddlHorario.SelectedValue == "0" ||
                string.IsNullOrEmpty(ddlHorario.SelectedValue))
            {
                lblMensagem.Text = "Selecione mentor, matéria, dia e horário.";
                lblMensagem.ForeColor = Color.DarkRed;
                lblMensagem.Visible = true;
                return;
            }

            string[] horas = ddlHorario.SelectedValue.Split('|');
            TimeSpan horaInicio = TimeSpan.Parse(horas[0]);
            TimeSpan horaFinal = TimeSpan.Parse(horas[1]);

            string sqlInsert = @"INSERT INTO Mentoria
                                (status, data, hora_inicio, hora_final, id_aluno, id_mentor, id_materia)
                                VALUES
                                (@status, @data, @horaInicio, @horaFinal, @idAluno, @idMentor, @idMateria)";

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(sqlInsert, conn))
                {
                    cmd.Parameters.AddWithValue("@status", "Agendada");
                    cmd.Parameters.Add("@data", SqlDbType.Date).Value = Convert.ToDateTime(ddlDia.SelectedValue).Date;
                    cmd.Parameters.Add("@horaInicio", SqlDbType.Time).Value = horaInicio;
                    cmd.Parameters.Add("@horaFinal", SqlDbType.Time).Value = horaFinal;
                    cmd.Parameters.AddWithValue("@idAluno", Convert.ToInt32(Session["id_aluno"]));
                    cmd.Parameters.AddWithValue("@idMentor", Convert.ToInt32(ddlMentor.SelectedValue));
                    cmd.Parameters.AddWithValue("@idMateria", Convert.ToInt32(ddlMateria.SelectedValue));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                Session["NomeAluno"] = Session["NomeAluno"] != null
                    ? Session["NomeAluno"].ToString()
                    : BuscarNomeAluno(Convert.ToInt32(Session["id_aluno"]));
                Session["MentorNome"] = ddlMentor.SelectedItem.Text;
                Session["MateriaNome"] = ddlMateria.SelectedItem.Text;
                Session["DataMentoria"] = ddlDia.SelectedItem.Text;
                Session["HorarioMentoria"] = ddlHorario.SelectedItem.Text;

                Response.Redirect("ConfirmaMentoria.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao agendar: " + ex.Message;
                lblMensagem.ForeColor = Color.DarkRed;
                lblMensagem.Visible = true;
            }
        }

        private string ObterSiglaDiaSemana(DayOfWeek dayOfWeek)
        {
            switch (dayOfWeek)
            {
                case DayOfWeek.Sunday: return "dom";
                case DayOfWeek.Monday: return "seg";
                case DayOfWeek.Tuesday: return "ter";
                case DayOfWeek.Wednesday: return "qua";
                case DayOfWeek.Thursday: return "qui";
                case DayOfWeek.Friday: return "sex";
                case DayOfWeek.Saturday: return "sab";
                default: return "";
            }
        }

        private string BuscarNomeAluno(int idAluno)
        {
            string sql = "SELECT nome FROM Aluno WHERE id_aluno = @idAluno";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@idAluno", idAluno);
                conn.Open();

                object resultado = cmd.ExecuteScalar();
                return (resultado == null || resultado == DBNull.Value) ? "Aluno" : resultado.ToString();
            }
        }

        protected void BtnVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("TelaAluno.aspx");
        }
    }
}
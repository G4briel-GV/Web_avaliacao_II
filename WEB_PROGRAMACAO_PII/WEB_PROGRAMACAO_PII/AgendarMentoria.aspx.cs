using System;
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
            if (Session["AlunoId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CarregarMentores();
                ddlDisciplina.Items.Add(new ListItem("-- Selecione o mentor --", "0"));
                ddlDia.Items.Add(new ListItem("-- Selecione o mentor --", "0"));
                ddlHorario.Items.Add(new ListItem("-- Selecione o dia --", "0"));
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
            ddlMentor.Items.Insert(0, new ListItem("-- Selecione um mentor --", "0"));
        }

        protected void ddlMentor_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMensagem.Visible = false;
            ddlDisciplina.Items.Clear();
            ddlDia.Items.Clear();
            ddlHorario.Items.Clear();

            if (ddlMentor.SelectedValue == "0")
            {
                ddlDisciplina.Items.Add(new ListItem("-- Selecione o mentor --", "0"));
                ddlDia.Items.Add(new ListItem("-- Selecione o mentor --", "0"));
                ddlHorario.Items.Add(new ListItem("-- Selecione o dia --", "0"));
                return;
            }

            int idMentor = Convert.ToInt32(ddlMentor.SelectedValue);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string sqlDisc = @"SELECT d.id_disciplina, d.nome
                                 FROM Disciplina d
                                 INNER JOIN mentor_disciplina md ON d.id_disciplina = md.id_disciplina
                                 WHERE md.id_aluno = @idMentor ORDER BY d.nome";

                using (SqlCommand cmd = new SqlCommand(sqlDisc, conn))
                {
                    cmd.Parameters.AddWithValue("@idMentor", idMentor);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        ddlDisciplina.DataSource = dr;
                        ddlDisciplina.DataTextField = "nome";
                        ddlDisciplina.DataValueField = "id_disciplina";
                        ddlDisciplina.DataBind();
                    }
                }
                ddlDisciplina.Items.Insert(0, new ListItem("-- Selecione a disciplina --", "0"));

                string sqlDias = @"SELECT DISTINCT CAST(dt_disponibilidade AS DATE) AS dia
                                 FROM Disponibilidade
                                 WHERE id_aluno = @idMentor ORDER BY dia";

                using (SqlCommand cmd = new SqlCommand(sqlDias, conn))
                {
                    cmd.Parameters.AddWithValue("@idMentor", idMentor);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            DateTime dia = Convert.ToDateTime(dr["dia"]);
                            ddlDia.Items.Add(new ListItem(dia.ToString("dd/MM/yyyy"), dia.ToString("yyyy-MM-dd")));
                        }
                    }
                }
                ddlDia.Items.Insert(0, new ListItem("-- Selecione o dia --", "0"));
            }

            ddlHorario.Items.Add(new ListItem("-- Selecione o dia --", "0"));
        }

        protected void ddlDia_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMensagem.Visible = false;
            CarregarHorariosDisponiveis();
        }

        private void CarregarHorariosDisponiveis()
        {
            ddlHorario.Items.Clear();

            if (ddlMentor.SelectedValue == "0" || ddlDia.SelectedValue == "0")
            {
                ddlHorario.Items.Add(new ListItem("-- Selecione o dia --", "0"));
                return;
            }

            string sqlHora = @"SELECT
                        CONVERT(VARCHAR(5), d.hora_inicio, 108) + ' - ' + CONVERT(VARCHAR(5), d.hora_final, 108) AS texto,
                        CONVERT(VARCHAR(8), d.hora_inicio, 108) + '|' + CONVERT(VARCHAR(8), d.hora_final, 108) AS valor
                     FROM Disponibilidade d
                     WHERE d.id_aluno = @idMentor
                       AND CAST(d.dt_disponibilidade AS DATE) = @data
                       AND NOT EXISTS (
                           SELECT 1 FROM Mentoria m
                           WHERE m.id_mentor = d.id_aluno
                             AND m.data = CAST(d.dt_disponibilidade AS DATE)
                             AND m.hora_inicio = d.hora_inicio
                             AND m.hora_final = d.hora_final
                             AND m.status <> 'Cancelada'
                       )
                     ORDER BY d.hora_inicio";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sqlHora, conn))
            {
                cmd.Parameters.AddWithValue("@idMentor", Convert.ToInt32(ddlMentor.SelectedValue));
                cmd.Parameters.Add("@data", SqlDbType.Date).Value = Convert.ToDateTime(ddlDia.SelectedValue).Date;

                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    ddlHorario.DataSource = dr;
                    ddlHorario.DataTextField = "texto";
                    ddlHorario.DataValueField = "valor";
                    ddlHorario.DataBind();
                }
            }

            ddlHorario.Items.Insert(0, new ListItem("-- Selecione o horário --", "0"));
        }

        protected void BtnAgendar_Click(object sender, EventArgs e)
        {
            if (ddlMentor.SelectedValue == "0" || ddlDisciplina.SelectedValue == "0" ||
                ddlDia.SelectedValue == "0" || ddlHorario.SelectedValue == "0")
            {
                lblMensagem.Text = "Selecione mentor, disciplina, dia e horário.";
                lblMensagem.ForeColor = Color.DarkRed;
                lblMensagem.Visible = true;
                return;
            }

            string[] horas = ddlHorario.SelectedValue.Split('|');
            TimeSpan horaInicio = TimeSpan.Parse(horas[0]);
            TimeSpan horaFinal = TimeSpan.Parse(horas[1]);

            string sqlInsert = @"INSERT INTO Mentoria
                                (status, data, hora_inicio, hora_final, id_aluno, id_mentor, id_disciplina)
                                VALUES
                                (@status, @data, @horaInicio, @horaFinal, @idAluno, @idMentor, @idDisciplina)";

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(sqlInsert, conn))
                {
                    cmd.Parameters.AddWithValue("@status", "Agendada");
                    cmd.Parameters.Add("@data", SqlDbType.Date).Value = Convert.ToDateTime(ddlDia.SelectedValue).Date;
                    cmd.Parameters.Add("@horaInicio", SqlDbType.Time).Value = horaInicio;
                    cmd.Parameters.Add("@horaFinal", SqlDbType.Time).Value = horaFinal;
                    cmd.Parameters.AddWithValue("@idAluno", Convert.ToInt32(Session["AlunoId"]));
                    cmd.Parameters.AddWithValue("@idMentor", Convert.ToInt32(ddlMentor.SelectedValue));
                    cmd.Parameters.AddWithValue("@idDisciplina", Convert.ToInt32(ddlDisciplina.SelectedValue));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                string nomeAluno = Session["NomeAluno"] != null
                    ? Session["NomeAluno"].ToString()
                    : BuscarNomeAluno(Convert.ToInt32(Session["AlunoId"]));

                Session["NomeAluno"] = nomeAluno;
                Session["MentorNome"] = ddlMentor.SelectedItem.Text;
                Session["DisciplinaNome"] = ddlDisciplina.SelectedItem.Text;
                Session["DataMentoria"] = ddlDia.SelectedItem.Text;
                Session["HorarioMentoria"] = ddlHorario.SelectedItem.Text;

                Response.Redirect("ConfirmaAgendamento.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao agendar: " + ex.Message;
                lblMensagem.ForeColor = Color.DarkRed;
                lblMensagem.Visible = true;
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
                if (resultado == null || resultado == DBNull.Value)
                {
                    return "Aluno";
                }

                return resultado.ToString();
            }

        }

        protected void BtnVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("TelaAluno.aspx");
        }
    }
}
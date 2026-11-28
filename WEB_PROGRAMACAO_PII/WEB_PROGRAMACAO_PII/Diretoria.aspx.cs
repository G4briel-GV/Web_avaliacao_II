using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WEB_PROGRAMACAO_PII
{
    // A palavra "partial" indica que esta classe se junta ao arquivo visual Diretoria.aspx
    public partial class Diretoria : System.Web.UI.Page
    {
        // Guarda o endereço do banco de dados ("MinhaConexao") configurado lá no Web.config
        string conexao = ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;


        // 1. VERIFICAÇÃO DE ACESSO AO ABRIR A PÁGINA

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica se existe uma sessão ativa e se o perfil logado é realmente "coordenacao"
            if (Session["tipo_usuario"] == null || Session["tipo_usuario"].ToString() != "coordenacao")
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }


        // 2. FILTRAR A GRIDVIEW PASSANDO A STRING SQL

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // Limpa os parâmetros anteriores antes de montar a nova busca
            SqlDataSource1.SelectParameters.Clear();

            // Monta o comando SQL básico como string
            string sql = @"SELECT 
                            Mentoria.data,
                            Aluno.nome AS nome_aluno,
                            Mentor.nome AS nome_mentor,
                            Materia.nome AS nome_materia,
                            Mentoria.status
                           FROM Mentoria
                           INNER JOIN Aluno ON Mentoria.id_aluno = Aluno.id_aluno
                           INNER JOIN Aluno AS Mentor ON Mentoria.id_mentor = Mentor.id_aluno
                           INNER JOIN Materia ON Mentoria.id_materia = Materia.id_materia
                           WHERE 1 = 1";

            // Se digitou o nome do aluno, adiciona o filtro pelo nome
            if (!string.IsNullOrWhiteSpace(txtFiltroAluno.Text))
            {
                sql += " AND Aluno.nome LIKE '%' + @aluno + '%'";
                SqlDataSource1.SelectParameters.Add("aluno", txtFiltroAluno.Text.Trim());
            }

            // Se escolheu um mentor diferente de "Todos" ("0"), adiciona o filtro pelo ID do mentor
            if (ddlFiltroMentor.SelectedValue != "0")
            {
                sql += " AND Mentoria.id_mentor = @id_mentor";
                SqlDataSource1.SelectParameters.Add("id_mentor", ddlFiltroMentor.SelectedValue);
            }

            // Passa a string SQL pronta para o SqlDataSource1 e atualiza a tabela na tela
            SqlDataSource1.SelectCommand = sql;
            gvMentorias.DataBind();
        }

        // Limpa os campos de filtro e recarrega todas as mentorias
        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            txtFiltroAluno.Text = "";
            ddlFiltroMentor.SelectedIndex = 0;
            btnBuscar_Click(sender, e);
        }


        // 3. CADASTRO / PROMOÇÃO DE ALUNO PARA MENTOR POR RA + TEXTBOX DE DISCIPLINA

        protected void btnAbrirCadastroMentor_Click(object sender, EventArgs e)
        {
            pnlCadastroMentor.Visible = !pnlCadastroMentor.Visible;
            lblMensagemMentor.Visible = false;
        }

        protected void btnCancelarMentor_Click(object sender, EventArgs e)
        {
            pnlCadastroMentor.Visible = false;
            txtRaMentor.Text = "";
            txtDisciplinaMentor.Text = "";
            lblMensagemMentor.Visible = false;
        }

        protected void btnSalvarMentor_Click(object sender, EventArgs e)
        {
            // Valida se o RA e a disciplina foram informados
            if (string.IsNullOrWhiteSpace(txtRaMentor.Text) || string.IsNullOrWhiteSpace(txtDisciplinaMentor.Text))
            {
                lblMensagemMentor.Text = "Informe o RA do aluno e a disciplina.";
                lblMensagemMentor.CssClass = "feedback-cadastro feedback-erro";
                lblMensagemMentor.Visible = true;
                return;
            }

            string ra = txtRaMentor.Text.Trim();
            string disciplina = txtDisciplinaMentor.Text.Trim();

            try
            {
                using (SqlConnection conn = new SqlConnection(conexao))
                {
                    conn.Open();

                    // 1. Busca o aluno no banco pelo RA informado
                    int idAluno = 0;
                    string nomeAluno = "";
                    SqlCommand cmdAluno = new SqlCommand("SELECT id_aluno, nome FROM Aluno WHERE RTRIM(matricula) = @ra", conn);
                    cmdAluno.Parameters.AddWithValue("@ra", ra);

                    using (SqlDataReader dr = cmdAluno.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            idAluno = Convert.ToInt32(dr["id_aluno"]);
                            nomeAluno = dr["nome"].ToString();
                        }
                    }

                    // Se não encontrou nenhum aluno com esse RA, avisa e para por aqui
                    if (idAluno == 0)
                    {
                        lblMensagemMentor.Text = $"Nenhum aluno encontrado com o RA {ra}.";
                        lblMensagemMentor.CssClass = "feedback-cadastro feedback-erro";
                        lblMensagemMentor.Visible = true;
                        return;
                    }

                    // 2. Promove o aluno marcando mentor = 'S'
                    SqlCommand cmdUpdate = new SqlCommand("UPDATE Aluno SET mentor = 'S' WHERE id_aluno = @id", conn);
                    cmdUpdate.Parameters.AddWithValue("@id", idAluno);
                    cmdUpdate.ExecuteNonQuery();

                    // 3. Busca o ID da matéria digitada (ou cria a matéria se ainda não existir)
                    int idMateria = 0;
                    SqlCommand cmdMat = new SqlCommand("SELECT id_materia FROM Materia WHERE nome = @nome", conn);
                    cmdMat.Parameters.AddWithValue("@nome", disciplina);
                    object resultadoMat = cmdMat.ExecuteScalar();

                    if (resultadoMat != null)
                    {
                        idMateria = Convert.ToInt32(resultadoMat);
                    }
                    else
                    {
                        SqlCommand cmdNovaMat = new SqlCommand("INSERT INTO Materia (nome) VALUES (@nome); SELECT SCOPE_IDENTITY();", conn);
                        cmdNovaMat.Parameters.AddWithValue("@nome", disciplina);
                        idMateria = Convert.ToInt32(cmdNovaMat.ExecuteScalar());
                    }

                    // 4. Vincula o aluno à matéria (se ainda não estiver vinculado)
                    SqlCommand cmdCheck = new SqlCommand("SELECT COUNT(*) FROM mentor_materia WHERE id_aluno = @aluno AND id_materia = @mat", conn);
                    cmdCheck.Parameters.AddWithValue("@aluno", idAluno);
                    cmdCheck.Parameters.AddWithValue("@mat", idMateria);

                    if (Convert.ToInt32(cmdCheck.ExecuteScalar()) == 0)
                    {
                        SqlCommand cmdVinc = new SqlCommand("INSERT INTO mentor_materia (id_aluno, id_materia) VALUES (@aluno, @mat)", conn);
                        cmdVinc.Parameters.AddWithValue("@aluno", idAluno);
                        cmdVinc.Parameters.AddWithValue("@mat", idMateria);
                        cmdVinc.ExecuteNonQuery();
                    }

                    lblMensagemMentor.Text = $"Mentor cadastrado com sucesso: {nomeAluno} ({disciplina})!";
                    lblMensagemMentor.CssClass = "feedback-cadastro feedback-sucesso";
                    lblMensagemMentor.Visible = true;
                }

                // Limpa os campos e atualiza o DropDownList de filtro de mentores
                txtRaMentor.Text = "";
                txtDisciplinaMentor.Text = "";

                ddlFiltroMentor.Items.Clear();
                ddlFiltroMentor.Items.Add(new ListItem("Todos os mentores", "0"));
                ddlFiltroMentor.DataBind();
            }
            catch (Exception ex)
            {
                lblMensagemMentor.Text = "Erro: " + ex.Message;
                lblMensagemMentor.CssClass = "feedback-cadastro feedback-erro";
                lblMensagemMentor.Visible = true;
            }
        }

        // =========================================================================
        // 4. BOTÃO SAIR (LOGOUT)
        // =========================================================================
        protected void btnSair_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
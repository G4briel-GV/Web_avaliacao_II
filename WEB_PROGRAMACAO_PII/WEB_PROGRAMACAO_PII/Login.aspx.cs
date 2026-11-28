using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WEB_PROGRAMACAO_PII
{
    public partial class Login : System.Web.UI.Page
    {
        string conexao = ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAvancar_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Preencha o e-mail e a senha.";
                lblMensagem.Visible = true;
                return;
            }

            // Acesso fixo da Coordenação / Diretoria
            if (email == "coordenacao@fatec.sp.gov.br" && senha == "1234")
            {
                Session["tipo_usuario"] = "coordenacao";
                Response.Redirect("Diretoria.aspx");
                return;
            }

            // Consulta no banco para Alunos e Mentores
            using (SqlConnection conn = new SqlConnection(conexao))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT id_aluno, nome, mentor FROM Aluno WHERE RTRIM(email) = @email AND RTRIM(senha) = @senha", conn);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@senha", senha);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Session["id_aluno"] = dr["id_aluno"].ToString();
                    Session["nome_usuario"] = dr["nome"].ToString();
                    Session["tipo_usuario"] = "aluno";
                    Session["eh_mentor"] = dr["mentor"].ToString().Trim();

                    Response.Redirect("Default.aspx");
                }
                else
                {
                    lblMensagem.Text = "E-mail ou senha inválidos.";
                    lblMensagem.Visible = true;
                }
            }
        }
    }
}
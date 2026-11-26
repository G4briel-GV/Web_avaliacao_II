using System;
using System.Web.UI;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WEB_PROGRAMACAO_PII
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensagem.Visible = false;
            }
        }

        // Botão "Avançar"
        protected void btnAvancar_Click(object sender, EventArgs e)
        {
            string destino = Request.QueryString["returnUrl"];
            string email = txtEmail.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Preencha seu e-mail institucional e senha.";
                lblMensagem.Visible = true;
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;
            DataTable resultado = new DataTable();

            try
            {
                using (SqlConnection conexao = new SqlConnection(cs))
                using (SqlCommand comando = new SqlCommand("EXEC ValidarLogin @email, @senha", conexao))
                {
                    comando.Parameters.AddWithValue("@email", email);
                    comando.Parameters.AddWithValue("@senha", senha);
                    using (SqlDataAdapter adaptador = new SqlDataAdapter(comando))
                    {
                        adaptador.Fill(resultado);
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao validar login: " + ex.Message;
                lblMensagem.Visible = true;
                return;
            }

            if (resultado.Rows.Count == 0)
            {
                lblMensagem.Text = "E-mail ou senha incorretos.";
                lblMensagem.Visible = true;
                return;
            }

            Session.Clear();
            Session["id_usuario"] = Convert.ToInt32(resultado.Rows[0]["id_usuario"]);

            if (resultado.Rows[0]["id_aluno"] != DBNull.Value)
            {
                Session["id_aluno"] = Convert.ToInt32(resultado.Rows[0]["id_aluno"]);
                if (resultado.Rows[0]["mentor"].ToString() == "S")
                {
                    Session["tipo_usuario"] = "mentor";
                    Response.Redirect(destino);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    Session["tipo_usuario"] = "aluno";
                    Response.Redirect(destino);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
            else if (resultado.Rows[0]["id_coordenacao"] != DBNull.Value)
            {
                Session["id_coordenacao"] = Convert.ToInt32(resultado.Rows[0]["id_coordenacao"]);
                Session["tipo_usuario"] = "coordenacao";
                Response.Redirect("Diretoria.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                Session.Clear();
                lblMensagem.Text = "Usuário sem perfil de acesso. Procure a secretaria.";
                lblMensagem.Visible = true;
            }
        }

        // Link "Esqueci a senha."
        protected void lnkEsqueciSenha_Click(object sender, EventArgs e)
        {
            lblMensagem.Text = "Entre em contato com a secretaria ou coordenação do curso para redefinir sua senha.";
            lblMensagem.Visible = true;
        }
    }
}
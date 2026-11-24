using System;
using System.Web.UI;

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
            string email = txtEmail.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Preencha seu e-mail institucional e senha.";
                lblMensagem.Visible = true;
                return;
            }

            // Validação inicial por domínio (substituir pela chamada ao banco de dados do grupo)
            if (email.EndsWith("@cps.sp.gov.br", StringComparison.OrdinalIgnoreCase))
            {
                Session["UsuarioEmail"] = email;
                Response.Redirect("Mentor.aspx");
            }
            else if (email.EndsWith("@aluno.cps.sp.gov.br", StringComparison.OrdinalIgnoreCase))
            {
                Session["UsuarioEmail"] = email;
                Response.Redirect("Principal.aspx");
            }
            else
            {
                lblMensagem.Text = "Utilize um e-mail institucional válido (@aluno.cps.sp.gov.br ou @cps.sp.gov.br).";
                lblMensagem.Visible = true;
            }
        }

        // Link "Esqueci a senha."
        protected void lnkEsqueciSenha_Click(object sender, EventArgs e)
        {
            lblMensagem.Text = "Entre em contato com a secretaria ou coordenação do curso para redefinir sua senha.";
            lblMensagem.Visible = true;
        }

        protected void lnkAcessoDiretoria_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string senha = txtSenha.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(senha))
            {
                lblMensagem.Text = "Informe o e-mail e a senha da diretoria nos campos acima antes de acessar.";
                lblMensagem.Visible = true;
                return;
            }

            // Valida se o e-mail pertence à diretoria/coordenação (ajustar com a consulta ao banco depois)
            if (email.EndsWith("@cps.sp.gov.br", StringComparison.OrdinalIgnoreCase) && senha == "admin123")
            {
                Session["UsuarioEmail"] = email;
                Session["PerfilAcesso"] = "Diretoria";
                Response.Redirect("Diretoria.aspx");
            }
            else
            {
                lblMensagem.Text = "Acesso restrito: credenciais inválidas para o perfil da diretoria.";
                lblMensagem.Visible = true;
            }
        }
    }
}
using System;
using System.Web.UI;

namespace WEB_PROGRAMACAO_PII
{
    public partial class Principal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnAgendar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgendarMentoria.aspx");
        }

        protected void btnMentor_Click(object sender, EventArgs e)
        {
            Response.Redirect("Mentor.aspx");
        }
    }
}
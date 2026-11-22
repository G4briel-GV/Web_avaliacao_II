using System;
using System.Web.UI;

namespace TelaAluno
{
    public partial class WebForm1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Aqui vão as conexões com o banco
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
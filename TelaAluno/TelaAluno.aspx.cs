using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TelaAluno
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            // Depois conectamos a leitura do banco aqui para preencher
            // os Labels da próxima mentoria e o GvHistoricoMentorias.
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
            Label1.Text = "Ausência comunicada";
            BtnComunicarAusencia.Enabled = false;
            BtnComunicarAusencia.Text = "Ausência comunicada";
        }
    }
    
}
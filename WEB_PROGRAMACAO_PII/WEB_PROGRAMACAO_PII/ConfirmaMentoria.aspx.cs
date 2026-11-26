using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WEB_PROGRAMACAO_PII
{
    public partial class ConfirmaMentoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["id_aluno"] == null)
                {
                    Response.Redirect("Login.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                if (Session["DisciplinaNome"] == null ||
                    Session["DataMentoria"] == null ||
                    Session["HorarioMentoria"] == null)
                {
                    Response.Redirect("AgendarMentoria.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                string nomeAluno = Session["NomeAluno"] != null ? Session["NomeAluno"].ToString() : "Aluno";
                string mentor = Session["MentorNome"] != null ? Session["MentorNome"].ToString() : "mentor";
                string disciplina = Session["DisciplinaNome"].ToString();
                string data = Session["DataMentoria"].ToString();
                string horario = Session["HorarioMentoria"].ToString();

                LblMensagemConfirmacao.Text =
                    "Parabéns, " + nomeAluno + "! Sua mentoria de " + disciplina +
                    " com " + mentor + " foi agendada para " + data + " (" + horario + ").";
            }
        }

        protected void BtnVoltar_Click(object sender, EventArgs e)
        {
            Session.Remove("NomeAluno");
            Session.Remove("MentorNome");
            Session.Remove("DisciplinaNome");
            Session.Remove("DataMentoria");
            Session.Remove("HorarioMentoria");

            Response.Redirect("TelaAluno.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
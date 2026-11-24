using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TelaAluno
{
    public partial class AgendarMentoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Carregar dados iniciais dos DropDownLists aqui depois
            }
        }

        protected void BtnVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("TelaAluno.aspx");
        }

        protected void BtnAgendar_Click(object sender, EventArgs e)
        {
            // Pegar valores selecionados quando integrar o banco:
            // string mentor = ddlMentor.SelectedValue;
            // string disciplina = ddlDisciplina.SelectedValue;
            // string dia = ddlDia.SelectedValue;
            // string horario = ddlHorario.SelectedValue;

            // Lógica de salvar no banco entra aqui depois
        }
    }
}
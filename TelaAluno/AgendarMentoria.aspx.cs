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
        protected void BtnVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("TelaAluno.aspx");
        }

        protected void BtnSelecionarMentor_Click(object sender, EventArgs e)
        {
            // Depois vamos colocar a lógica aqui
        }

        protected void BtnSelecionarDisciplina_Click(object sender, EventArgs e)
        {
            // Depois vamos colocar a lógica aqui
        }

        protected void BtnSelecionarDia_Click(object sender, EventArgs e)
        {
            // Depois vamos colocar a lógica aqui
        }

        protected void BtnSelecionarHorario_Click(object sender, EventArgs e)
        {
            // Depois vamos colocar a lógica aqui
        }

        protected void BtnAgendar_Click(object sender, EventArgs e)
        {
            // Depois vamos colocar a lógica aqui
        }


        protected void LstMentores_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void LstDisciplinas_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        
        protected void LstDias_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void LstHorarios_SelectedIndexChanged(object sender, EventArgs e)
        {
        }


    }
}
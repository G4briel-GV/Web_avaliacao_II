using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WEB_PROGRAMACAO_PII
{
    public partial class Horarios_mentor : System.Web.UI.Page
    {
        private void lerGradeParaTabela()
        {
            DataTable tabela = (DataTable)ViewState["tabela"];
            for (int i = 0; i < gvHorarios.Rows.Count; i++)
            {
                DropDownList ddl = (DropDownList)gvHorarios.Rows[i].FindControl("ddlDiaSemana");
                tabela.Rows[i]["dia_semana"] = ddl.SelectedValue;
                TextBox txtInicio = (TextBox)gvHorarios.Rows[i].FindControl("txtHoraInicio");
                if (string.IsNullOrWhiteSpace(txtInicio.Text))
                {
                    tabela.Rows[i]["inicio"] = DBNull.Value;
                }
                else
                {
                    tabela.Rows[i]["inicio"] = TimeSpan.Parse(txtInicio.Text);
                }

                TextBox txtFim = (TextBox)gvHorarios.Rows[i].FindControl("txtHoraFim");
                if (string.IsNullOrWhiteSpace(txtFim.Text))
                {
                    tabela.Rows[i]["fim"] = DBNull.Value;
                }
                else
                {
                    tabela.Rows[i]["fim"] = TimeSpan.Parse(txtFim.Text);
                }
            }
            ViewState["tabela"] = tabela;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                carregarHorarios();
            }
        }
        private void carregarHorarios()
        {
            int id_aluno = 1;
            string cs = ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;
            SqlConnection conexao = new SqlConnection(cs);
            try
            {
                SqlCommand comando = new SqlCommand("EXEC ListarDisponibilidadeMentor @id_aluno", conexao);
                comando.Parameters.AddWithValue("@id_aluno", id_aluno);
                DataTable tabela = new DataTable();
                SqlDataAdapter adaptador = new SqlDataAdapter(comando);
                adaptador.Fill(tabela);
                gvHorarios.DataSource = tabela;
                gvHorarios.DataBind();
                ViewState["tabela"] = tabela;
            }
            finally
            {
                conexao.Close();
            }
        }
        protected void gvHorarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remover")
            {
                lerGradeParaTabela();
                if (string.IsNullOrEmpty(e.CommandArgument.ToString()))
                {
                    GridViewRow linhaGrade = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                    int indice = linhaGrade.RowIndex;
                    DataTable tabela = (DataTable)ViewState["tabela"];
                    tabela.Rows.RemoveAt(indice);
                    ViewState["tabela"] = tabela;
                    gvHorarios.DataSource = tabela;
                    gvHorarios.DataBind();
                }
                else {
                    int id_disponibilidade = Convert.ToInt32((e.CommandArgument));
                    string cs = ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;
                    SqlConnection conexao = new SqlConnection(cs);
                    try
                    {
                        int id_aluno = 1;
                        conexao.Open();
                        SqlCommand comando = new SqlCommand("EXEC RemoverDisponibilidade @id_disponibilidade = @id_disponibilidade, @id_aluno = @id_aluno", conexao);
                        comando.Parameters.AddWithValue("@id_disponibilidade", id_disponibilidade);
                        comando.Parameters.AddWithValue("@id_aluno", id_aluno);
                        comando.ExecuteNonQuery();
                    }
                    finally
                    {
                        conexao.Close();
                    }
                    GridViewRow linhaGrade = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                    int indice = linhaGrade.RowIndex;
                    DataTable tabela = (DataTable)ViewState["tabela"];
                    tabela.Rows.RemoveAt(indice);
                    ViewState["tabela"] = tabela;
                    gvHorarios.DataSource = tabela;
                    gvHorarios.DataBind();
                }
            }
        }
        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            lerGradeParaTabela();
            DataTable tabela = (DataTable)ViewState["tabela"];
            DataRow linha = tabela.NewRow();
            linha["dia_semana"] = "seg";
            tabela.Rows.Add(linha);
            ViewState["tabela"] = tabela;
            gvHorarios.DataSource = tabela;
            gvHorarios.DataBind();
        }
    }
}
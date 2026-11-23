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
            int id_disponibilidade = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Remover")
            {
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
                    carregarHorarios();
                }
            }
        }
        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            DataTable tabela = (DataTable)ViewState["tabela"];
            DataRow linha = tabela.NewRow();
            linha["DiaSemana"] = "seg";
            tabela.Rows.Add(linha);
            ViewState["tabela"] = tabela;
            gvHorarios.DataSource = tabela;
            gvHorarios.DataBind();
        }
    }
}
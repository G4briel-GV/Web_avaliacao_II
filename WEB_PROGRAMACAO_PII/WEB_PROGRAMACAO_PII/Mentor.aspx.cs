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
    public partial class Mentor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (verificarLogin())
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }
            if (!IsPostBack)
            {
                carregarAlunos();
            }
        }
        private Boolean verificarLogin()
        {
            if (Session["id_usuario"] == null || Session["tipo_usuario"] == null || Session["tipo_usuario"].ToString() != "mentor")
            {
                return true;
            }
            return false;
        }
        private void carregarAlunos()
        {
            int id_mentoria = 1;
            string cs = ConfigurationManager.ConnectionStrings["MinhaConexao"].ConnectionString;
            SqlConnection conexao = new SqlConnection(cs);
            try
            {
                string sql = @"
                    SELECT DISTINCT
                        a.id_aluno AS IdAluno,
                        a.nome AS NomeAluno,
                        ISNULL(c.sigla, ISNULL(c.nome, 'Curso não informado')) AS CursoSemestre
                    FROM Aluno a
                    LEFT JOIN Aluno_Curso ac ON ac.id_aluno = a.id_aluno
                    LEFT JOIN Curso c ON c.id_curso = ac.id_curso
                    LEFT JOIN Mentoria m ON m.id_aluno = a.id_aluno AND m.id_mentoria = @id_mentoria
                    ORDER BY a.nome";

                SqlCommand comando = new SqlCommand(sql, conexao);
                comando.Parameters.AddWithValue("@id_mentoria", id_mentoria);
                DataTable tabela = new DataTable();
                SqlDataAdapter adaptador = new SqlDataAdapter(comando);
                adaptador.Fill(tabela);

                if (!tabela.Columns.Contains("SituacaoMarcada"))
                {
                    tabela.Columns.Add("SituacaoMarcada", typeof(string));
                }

                Dictionary<int, string> presencas = ViewState["presencasAlunos"] as Dictionary<int, string>;
                foreach (DataRow linha in tabela.Rows)
                {
                    int idAluno = Convert.ToInt32(linha["IdAluno"]);
                    if (presencas != null && presencas.ContainsKey(idAluno))
                    {
                        linha["SituacaoMarcada"] = presencas[idAluno];
                    }
                    else
                    {
                        linha["SituacaoMarcada"] = string.Empty;
                    }
                }

                gvAlunos.DataSource = tabela;
                gvAlunos.DataBind();
                ViewState["tabelaAlunos"] = tabela;

                lblTotalAlunos.Text = tabela.Rows.Count + (tabela.Rows.Count == 1 ? " aluno" : " alunos");
            }
            finally
            {
                conexao.Close();
            }
        }

        protected void gvAlunos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Presente" || e.CommandName == "Ausente")
            {
                string situacao = e.CommandName;
                int id_aluno = Convert.ToInt32(e.CommandArgument);

                Dictionary<int, string> presencas = ViewState["presencasAlunos"] as Dictionary<int, string>
                    ?? new Dictionary<int, string>();
                presencas[id_aluno] = situacao;
                ViewState["presencasAlunos"] = presencas;

                carregarAlunos();
            }
        }
    }
}
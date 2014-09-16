using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SuxPubC
{
    public partial class Pub : System.Web.UI.Page
    {
        int pubId;
        DataTable dtAtrakce = new DataTable();


        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!int.TryParse(Request.QueryString["Id"], out pubId)) //nevíme jakou hospodu editovat
            {
                Response.Redirect("Main.aspx");

            }
            else
            {
                if (Request.QueryString["command"] == "smazat") //smazání hospody
                {
                    using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
                    {
                        pripojeni.Open();

                        string dotaz = "UPDATE Pub SET [smazano] = 1 WHERE Id=@pubId";

                        using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                        {
                            prikaz.Parameters.AddWithValue("@pubId", pubId);
                            prikaz.ExecuteNonQuery();                     

                        }
                        pripojeni.Close();
                        Response.Redirect("Index.aspx");
                    }
                }

                FormView1.DefaultMode = FormViewMode.Edit;
                VykresliAtrakce();

                if (Session["prihlasen"] == null)//není přihlášen administrátor
                {
                    Panel panelUmisteni = (Panel)FormView1.FindControl("panelUmisteni");
                    panelUmisteni.Visible = false;

                }
            }

        }

        private void VykresliAtrakce()
        {

            
            dtAtrakce.Columns.Add("atakceId", typeof(int));
            dtAtrakce.Columns.Add("conId", typeof(int));
            dtAtrakce.Columns.Add("nazev", typeof(string));
            dtAtrakce.Columns.Add("komentar", typeof(string));

            Table tabulka = new Table();

            //Header tabulky
            TableRow header = new TableRow();
            TableCell idHeader = new TableCell();
            TableCell nazevHeader = new TableCell();
            TableCell komentarHeader = new TableCell();
            Label komentarLabel = new Label();
            komentarLabel.Text = "Komentář:";
            komentarHeader.Controls.Add(komentarLabel);
            TableCell cbHeader = new TableCell();
            header.Controls.Add(idHeader);
            header.Controls.Add(nazevHeader);
            header.Controls.Add(komentarHeader);
            header.Controls.Add(cbHeader);
            tabulka.Controls.Add(header);



            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "SELECT  at.Id as atrakceId, nazev, atcon.Id as conId,  pubId, poznamka  FROM dbo.Atrakce at  Left join dbo.AtrakceCon atcon ON at.Id= atcon.atrakceId AND atcon.pubId = @pubId WHERE at.smazano!= 1";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@pubId", pubId);
                    SqlDataReader dataReader = prikaz.ExecuteReader();
                    while (dataReader.Read()) // dokud neprojdeme vsechny zaznamy
                    {
                        int conId = 0;
                        int.TryParse(dataReader["conId"].ToString(), out conId);

                        TableRow row = new TableRow();
                        TableCell cellId = new TableCell();
                        TableCell cellNazev = new TableCell();
                        TableCell cellKomentar = new TableCell();
                        TableCell cellCheckBox = new TableCell();


                        Label lbId = new Label();
                        lbId.Text = dataReader["atrakceId"].ToString();
                        lbId.Visible = false;
                        cellId.Controls.Add(lbId);

                        Label lbNazev = new Label();
                        lbNazev.Text = (string)dataReader["nazev"];
                        cellNazev.Controls.Add(lbNazev);

                        CheckBox cbExistence = new CheckBox();
                        if (conId != 0)
                        {
                            cbExistence.Checked = true;
                        }
                        else
                        {
                            cbExistence.Checked = false;
                        }
                        cbExistence.ID = "cb_"+ dataReader["atrakceId"].ToString();
                        cellCheckBox.Controls.Add(cbExistence);

                        TextBox tbKomentar = new TextBox();
                        string poznamka = "";
                        if (dataReader["poznamka"] != DBNull.Value)
                        {
                            poznamka = dataReader["poznamka"].ToString();
                            tbKomentar.Text = poznamka;
                        }
                        tbKomentar.ID = "komentar_" + dataReader["atrakceId"].ToString();
                        cellKomentar.Controls.Add(tbKomentar);

                        row.Controls.Add(cellId);
                        row.Controls.Add(cellNazev);
                        row.Controls.Add(cellCheckBox);
                        row.Controls.Add(cellKomentar);
                        tabulka.Controls.Add(row);

                        
                        dtAtrakce.Rows.Add((int)dataReader["atrakceId"], conId, (string)dataReader["nazev"], poznamka);
                    }
                    dataReader.Close();

                }
                pripojeni.Close();
            }

            PlaceHolder phAtrakce = (PlaceHolder)FormView1.FindControl("PlaceHolderAtrakce");
            phAtrakce.Controls.Add(tabulka);









        }


        protected void btPridatPivo_Click(object sender, EventArgs e)
        {
            TextBox tbCena = (TextBox)FormView1.FindControl("tbCena");
            DropDownList ddlPivo = (DropDownList)FormView1.FindControl("ddlPivo");
            decimal cena = 0;
            decimal.TryParse(tbCena.Text, out cena);
                       

            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();


                string dotaz = "INSERT INTO PivaCon (pubId, pivoId, cena) VALUES ( @pubId, @pivoId, @cena)";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@pubId", Request.QueryString["Id"]);
                    prikaz.Parameters.AddWithValue("@pivoId", ddlPivo.SelectedValue);
                    prikaz.Parameters.AddWithValue("@cena", cena);
                    prikaz.ExecuteNonQuery();

                }
                pripojeni.Close();
            }

            GridView grPiva = (GridView)FormView1.FindControl("GridViewPiva");
            grPiva.DataBind();

        }

        protected void GridViewPiva_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            
        }

        private void UlozAtrakce()
        {
            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "DELETE FROM AtrakceCon WHERE pubId=@pubId";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@pubId", pubId);
                    prikaz.ExecuteNonQuery();
                }


                PlaceHolder phAtrakce = (PlaceHolder)FormView1.FindControl("PlaceHolderAtrakce");

                foreach (DataRow radek in dtAtrakce.Rows)
                {
                    CheckBox cb = (CheckBox)phAtrakce.FindControl("cb_" + radek[0]);

                    if (cb.Checked)
                    {
                        TextBox tbPoznamka = (TextBox)phAtrakce.FindControl("komentar_" + radek[0]);



                        dotaz = "INSERT INTO AtrakceCon (atrakceId, pubId, poznamka) VALUES ( @atrakceId, @pubId,@poznamka)";

                        using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                        {
                            prikaz.Parameters.AddWithValue("@atrakceId", radek[0]);
                            prikaz.Parameters.AddWithValue("@pubId", pubId);
                            prikaz.Parameters.AddWithValue("@poznamka", tbPoznamka.Text);
                            prikaz.ExecuteNonQuery();
                        }

                    }
                }


                pripojeni.Close();
            }
        }

        protected void btUlozAtrakce_Click(object sender, EventArgs e)
        {
            UlozAtrakce();
            FormView1.UpdateItem(true);

            DateTime datum = DateTime.Now;
            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "UPDATE Pub SET [datumPridani] = @datum WHERE [Id] = @Id";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@Id", pubId);
                    prikaz.Parameters.AddWithValue("@datum", datum);
                    prikaz.ExecuteScalar();

                }
                pripojeni.Close();
            }


            if (Session["prihlasen"] != null)
            {
                Response.Redirect("Index.aspx");
            }
            else
            {
                Response.Redirect("Main.aspx?thanks=true");
            }
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            

            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "SELECT MAX(Id) as Idecko FROM Pub";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    int maxId = (int)prikaz.ExecuteScalar();
                    pripojeni.Close();
                    Response.Redirect("Pub.aspx?Id=" + maxId);
                }
                
            }
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {



        }

        protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            UlozAtrakce();
        }



    }
}
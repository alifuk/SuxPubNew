using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SuxPubC
{
    public partial class Index : System.Web.UI.Page
    {
        public decimal gpsEJS;
        public decimal gpsNJS;

        public string nadpisBodu, textBodu;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["prihlasen"] == null)
            {
                Response.Redirect("Prihlaseni.aspx");
            }

            int pubId, smazat;
            if (int.TryParse(Request.QueryString["smazatPivo"], out smazat)) //Smazání piva
            {

                using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
                {
                    pripojeni.Open();
                    string dotaz = "UPDATE Piva SET [smazano] = 1 WHERE [Id] = @Id";

                    using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                    {
                        prikaz.Parameters.AddWithValue("@Id", smazat);
                        prikaz.ExecuteNonQuery();
                    }
                    pripojeni.Close();
                }

                Response.Redirect("Index.aspx");
            }
            else if (int.TryParse(Request.QueryString["smazatLokaci"], out smazat))
            {

                using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
                {
                    pripojeni.Open();
                    string dotaz = "UPDATE Lokace SET [smazano] = 1 WHERE [Id] = @Id";

                    using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                    {
                        prikaz.Parameters.AddWithValue("@Id", smazat);
                        prikaz.ExecuteNonQuery();
                    }
                    pripojeni.Close();
                }

                Response.Redirect("Index.aspx");
            }
            else if (int.TryParse(Request.QueryString["smazatAtrakci"], out smazat))
            {

                using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
                {
                    pripojeni.Open();
                    string dotaz = "UPDATE Atrakce SET [smazano] = 1 WHERE [Id] = @Id";

                    using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                    {
                        prikaz.Parameters.AddWithValue("@Id", smazat);
                        prikaz.ExecuteNonQuery();
                    }
                    pripojeni.Close();
                }

                Response.Redirect("Index.aspx");
            }
            else if (!int.TryParse(Request.QueryString["Id"], out pubId)) //pokud je vložen parametr, zobraz detail
            {
                PanelDetail.Visible = false;
            }
            else
            {
                PanelDetail.Visible = true;
                using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
                {
                    pripojeni.Open();
                    string dotaz = "SELECT * FROM dbo.Pub WHERE Id=@Id";

                    using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                    {
                        prikaz.Parameters.AddWithValue("@Id", pubId);
                        SqlDataReader dataReader = prikaz.ExecuteReader();
                        while (dataReader.Read()) // dokud neprojdeme vsechny zaznamy
                        {
                            //Pokud sou v db souřadnice, zobraz mapu
                            if (dataReader["gpsN"].ToString() != "" && dataReader["gpsE"].ToString() != "")
                            {
                                PanelMapa.Visible = true;
                                gpsEJS = (decimal)dataReader["gpsN"];
                                gpsNJS = (decimal)dataReader["gpsE"];

                                nadpisBodu = dataReader["nazev"].ToString();
                                textBodu = dataReader["adresa"].ToString();
                            }
                            else
                            {
                                PanelMapa.Visible = false;
                            }

                            //Vykreslení hvezdiček u celkového hodnocení
                            VygenerujHvězdy(dataReader["hodnoceni"].ToString(), "phHodnoceniStars");


                            //Vykreslení hvezdiček u obsluhy
                            VygenerujHvězdy(dataReader["obsluha"].ToString(), "phObsluhaStars");

                            //Vykreslení hvezdiček u obsluhy
                            VygenerujHvězdy(dataReader["prostredi"].ToString(), "phProstrediStars");


                        }
                        dataReader.Close();

                    }
                    pripojeni.Close();
                }
               

               

                


            }




        }

        //Vykreslení hvězd
        private void VygenerujHvězdy(string dbValue, string phName)
        {

            if (dbValue != "")
            {
                int pocetHvezd = int.Parse(dbValue);
                string hvezdicky = "<div class='starRate'><div><b></b></div><ul>";
                for (int i = 5; i > 0; i--)
                {
                    if (pocetHvezd == i)
                    {
                        hvezdicky += "<li><a ><span></span><b></b></a></li>";
                    }
                    else
                    {
                        hvezdicky += "<li><a ><span></span></a></li>";
                    }
                }
                hvezdicky += "</ul></div>";

                LiteralControl lcHvezdicky = new LiteralControl(hvezdicky);


                PlaceHolder phHodnoceniStars = (PlaceHolder)fvDetail.FindControl(phName);
                phHodnoceniStars.Controls.Add(lcHvezdicky);

            }

        }

        //Vytvoří v databázi novou hospodu a přesměruje nás na její editaci
        protected void btPridatHospodu_Click(object sender, EventArgs e)
        {
            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "INSERT INTO Pub (lokace, prostornost, hodnoceni, obsluha, prostredi, odUzivatele) VALUES ('1', 'Normální', '1', '1', '1', '0') SELECT SCOPE_IDENTITY()";
                int noveId;
                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    noveId = int.Parse(prikaz.ExecuteScalar().ToString());

                }
                pripojeni.Close();
                Response.Redirect("Pub.aspx?Id=" + noveId.ToString());
            }
        }




    }
}
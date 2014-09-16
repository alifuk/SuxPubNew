using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SuxPubC
{
    public partial class Main : System.Web.UI.Page
    {
        List<CheckBox> listCBAtrakce = new List<CheckBox>();
        List<CheckBox> listCBPiva = new List<CheckBox>();
        List<CheckBox> listCBLokace = new List<CheckBox>();
        int pocetFiltru = 0;
        string filtryAtrakce = "";
        string filtryPiva = "";
        string filtryLokace = "";
        int pocetPolozekFiltr = 5; //Počet položek ve sloupci v hledání
        public bool vyhledavano = false;


        protected void Page_Load(object sender, EventArgs e)
        {
            
            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();

                //Vypsání checkboxů všech atrakcí
                GenerujFiltry(pripojeni, "Atrakce", ref listCBAtrakce);
                //Vypsání checkboxů všech piv
                GenerujFiltry(pripojeni, "Piva", ref listCBPiva);
                //Vypsání checkboxů všech lokací
                GenerujFiltry(pripojeni, "Lokace", ref listCBLokace);


               if (!IsPostBack ) //Nebylo zmáčknuto tlačítko filtrace
                {
                    VypisHospody(false, false, false);
                }
                pripojeni.Close();
            }


        }

        private void GenerujFiltry(SqlConnection pripojeni, string table, ref List<CheckBox> list)
        {

            string dotaz = "SELECT [Id] ,[nazev] FROM [dbo].["+table+"] WHERE smazano = 0";

            using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
            {
                SqlDataReader dataReader = prikaz.ExecuteReader();
                int i = 0; // Index kolikátou položku procházíme
                while (dataReader.Read())
                {
                    if (dataReader["nazev"].ToString() != "Jiná lokace")
                    {

                        Literal divStart = new Literal();
                        divStart.Text = "<div class='vyhledavaciSloupec'>";

                        if (i % pocetPolozekFiltr == 0)
                        {
                            phHledani.Controls.Add(divStart);
                        }
                        Label lbPopis = new Label();
                        lbPopis.Text = dataReader["nazev"].ToString();
                        phHledani.Controls.Add(lbPopis);

                        CheckBox cbAtrakce = new CheckBox();
                        cbAtrakce.ID = table.Substring(0, 3) + dataReader["Id"];
                        phHledani.Controls.Add(cbAtrakce);
                        list.Add(cbAtrakce);

                        if ((i + 1) % pocetPolozekFiltr == 0)
                        {
                            Literal divEnd = new Literal();
                            divEnd.Text = "</div>";
                            phHledani.Controls.Add(divEnd);
                        }
                        else
                        {
                            Literal divBreak = new Literal();
                            divBreak.Text = "<br/>";
                            phHledani.Controls.Add(divBreak);
                        }


                        i++;
                    }
                }
                dataReader.Close();


                if (i % pocetPolozekFiltr != 0)
                {
                    Literal divEnd = new Literal();
                    divEnd.Text = "</div>";
                    phHledani.Controls.Add(divEnd);
                }

            }
            
        }


        private void VypisHospody(bool filtrovatAtrakce, bool filtrovatPiva, bool filtrovatLokace)
        {
            string countAny = "";

            if (!filtrovatAtrakce)
            {
                filtryAtrakce = "0=1";
            }
            else
            {
                filtryAtrakce = "atrakceId in (" + filtryAtrakce + ")";
            }

            if (!filtrovatPiva)
            {
                filtryPiva = "0=1";
            }
            else
            {
                filtryPiva = "pivoId in (" + filtryPiva + ")";
            }

            if (!filtrovatLokace)
            {
                filtryLokace = "1=1";
            }
            else
            {
                filtryLokace = "AND lok.Id in (" + filtryLokace + ")";
            }

            if (filtrovatLokace && !filtrovatPiva && !filtrovatAtrakce)
            {
                filtryAtrakce = "1=1";
                filtryPiva = "1=1";
                countAny = "OR 1=1";
            }


            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz;
                if (filtrovatAtrakce || filtrovatPiva || filtrovatLokace) //Pokud vyhledáváme
                {
                    dotaz = "SELECT count, pub.Id as pubId, 		pub.[nazev]  as nazev    ,[adresa]      ,[prostornost]      ,[hodnoceni]      ,[obsluha]      ,[poznamka]      ,[navstevnici]      ,[prostredi]      ,[gpsN]      ,[gpsE]      ,[datumPridani] , lok.nazev as lokace FROM(	SELECT Count([Id]) as count	, pubId		FROM (		SELECT [Id]		,[pubId]		FROM [dbo].[AtrakceCon]		WHERE " + filtryAtrakce + " UNION 		SELECT TOP 1000 [Id]		,[pubId]		FROM [dbo].[PivaCon]		WHERE " + filtryPiva + " 		) as spojeni  GROUP BY pubId  ) as filtrace  INNER JOIN dbo.Pub pub ON pub.Id = pubId  INNER JOIN dbo.lokace lok ON lok.Id = pub.lokace " + filtryLokace + " WHERE count=@count " + countAny + " AND odUzivatele != 1 AND pub.smazano != 1 ORDER BY count DESC, pub.nazev ASC";
                    lbHospodyNadpis.Text = "Hospody odpovídající hledání:";
                    vyhledavano = true;
                }
                else //Všechny hospody
                {
                    dotaz = "SELECT pub.Id as pubId, 		pub.[nazev]  as nazev    ,[adresa]      ,[prostornost]      ,[hodnoceni]      ,[obsluha]      ,[poznamka]      ,[navstevnici]      ,[prostredi]      ,[gpsN]      ,[gpsE]      ,[datumPridani]   , lok.nazev as lokace  FROM [dbo].[Pub] pub  INNER JOIN dbo.Lokace lok ON lok.Id = pub.lokace WHERE pub.smazano != 1 AND odUzivatele != 1 ORDER BY hodnoceni DESC, nazev ASC";
                    lbHospodyNadpis.Text = "Všechny hospody:";
                }
                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    if (filtrovatAtrakce || filtrovatPiva || filtrovatLokace)
                    {
                        prikaz.Parameters.AddWithValue("@count", pocetFiltru);
                    }
                    SqlDataReader dataReader = prikaz.ExecuteReader();
                    while (dataReader.Read()) // dokud neprojdeme vsechny zaznamy
                    {
                        //Název, adresa, lokace
                        string blok = "<div class='blok'><h4 style='display:inline-block;'>" + dataReader["nazev"] + " </h4>";
                        blok += "<h5 style='display:inline-block;'>&nbsp;&nbsp;" + dataReader["adresa"] + " - " + dataReader["lokace"] + "</h5>";
                        //Ohodnocení
                        blok += "<div class='hodnoceniPopisBar'><div class='ohodnoceni'>";
                        blok += "<table>";
                        blok += "<tr><td><h5>Obsluha</h5></td><td>" + VygenerujHvezdy(int.Parse(dataReader["obsluha"].ToString())) + "</td>";
                        blok += "<tr><td><h5>Prostředí </h5></td><td>" + VygenerujHvezdy(int.Parse(dataReader["prostredi"].ToString())) + "</td>";
                        blok += "<tr><td><h5>Celkem </h5></td><td>" + VygenerujHvezdy(int.Parse(dataReader["hodnoceni"].ToString())) + "</td>";
                        blok += "</table></div>";
                        //Popis
                        blok += "<h5 class='popis'>" + dataReader["poznamka"] + "</h5></div>";
                        //Piva
                        blok += "<div class='piva'><table>";
                        blok += VypisPiva(int.Parse(dataReader["pubId"].ToString()));
                        blok += "</table></div>";
                        //Atrakce
                        blok += "<div class='atrakce'><table>";
                        blok += VypisAtrakce(dataReader["prostornost"].ToString(), int.Parse(dataReader["pubId"].ToString()));
                        blok += "</table></div>";

                        //Atrakce i s detailem
                        /*blok += "<div class='atrakceFull'><table>";
                        blok += VypisAtrakceFull(dataReader["prostornost"].ToString(), int.Parse(dataReader["pubId"].ToString()));
                        blok += "</table></div>";*/

                        blok += "</div>";
                        Literal ltBlok = new Literal();
                        ltBlok.Text = blok;
                        phHospody.Controls.Add(ltBlok);


                    }
                    dataReader.Close();

                }

                pripojeni.Close();
            }

        }

        


        protected string VygenerujHvezdy(int pocetHvezd)
        {
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
            return hvezdicky;
        }

        private string VypisPiva(int pubId)
        {
            string piva = "";

            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "SELECT [pubId]      ,[pivoId]      ,[cena]	  ,piva.nazev as nazev FROM [dbo].[PivaCon] pivaC INNER JOIN dbo.Piva piva ON piva.Id = pivaC.pivoId WHERE pubId=@pubId";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@pubId", pubId);
                    SqlDataReader dataReader = prikaz.ExecuteReader();
                    while (dataReader.Read()) // dokud neprojdeme vsechny zaznamy
                    {
                        piva += "<tr><td><h5>"+dataReader["nazev"]+"</h5></td><td><h5>"+dataReader["cena"]+",-</h5></td></tr>";
                    }
                    dataReader.Close();

                }
                pripojeni.Close();
            }
            return piva;
        }

        private string VypisAtrakceFull(string prostornost, int pubId)
        {
            string atrakce = "";

            DataTable dtAtrakce = new DataTable();
            dtAtrakce.Columns.Add("nazev", typeof(string));
            dtAtrakce.Columns.Add("poznamka", typeof(string));

            if (prostornost == "Prostorné" || prostornost == "Stísněné")
            {
                dtAtrakce.Rows.Add(prostornost, "");
            }

            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();


                string dotaz = "SELECT  [poznamka]	,at.nazev as nazev FROM [dbo].[AtrakceCon] atC  INNER JOIN dbo.Atrakce at ON at.Id = atC.atrakceId  WHERE pubId=@pubId";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@pubId", pubId);
                    SqlDataReader dataReader = prikaz.ExecuteReader();
                    while (dataReader.Read()) // dokud neprojdeme vsechny zaznamy
                    {
                        dtAtrakce.Rows.Add(dataReader["nazev"], dataReader["poznamka"]);
                    }
                    dataReader.Close();

                }
                pripojeni.Close();

                
            }

            int pocet = dtAtrakce.Rows.Count;
            for (int i = 0; i < pocet ; i++) //vypsání řádků
            {
                atrakce += "<tr><td><h5>" + dtAtrakce.Rows[i].ItemArray[0] + "</h5></td><td><h5>" + dtAtrakce.Rows[i].ItemArray[1] + "</h5></td></tr>";
            }

            return atrakce;

        }


        private string VypisAtrakce(string prostornost, int pubId)
        {
            string atrakce = "";

            DataTable dtAtrakce = new DataTable();
            dtAtrakce.Columns.Add("nazev", typeof(string));
            dtAtrakce.Columns.Add("poznamka", typeof(string));

            if (prostornost == "Prostorné" || prostornost == "Stísněné")
            {
                dtAtrakce.Rows.Add(prostornost, "");
            }

            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();


                string dotaz = "SELECT  [poznamka]	,at.nazev as nazev FROM [dbo].[AtrakceCon] atC  INNER JOIN dbo.Atrakce at ON at.Id = atC.atrakceId  WHERE pubId=@pubId";

                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    prikaz.Parameters.AddWithValue("@pubId", pubId);
                    SqlDataReader dataReader = prikaz.ExecuteReader();
                    while (dataReader.Read()) // dokud neprojdeme vsechny zaznamy
                    {
                        dtAtrakce.Rows.Add(dataReader["nazev"], dataReader["poznamka"]);
                    }
                    dataReader.Close();

                }
                pripojeni.Close();
            }


            //pokud je lichý počet řádků, přidej prázdný
            if (dtAtrakce.Rows.Count % 2 == 1)
            {
                dtAtrakce.Rows.Add(" ", " ");
            }

            int pocet = dtAtrakce.Rows.Count;
            for (int i = 0; i < pocet / 2; i++) //vypsání řádků
            {
                atrakce += "<tr><td><h5>" + dtAtrakce.Rows[i].ItemArray[0] + "</h5></td><td><h5>" + dtAtrakce.Rows[pocet / 2 + i].ItemArray[0] + "</h5></td></tr>";
            }

            return atrakce;
        }

        protected void btPridat_Click(object sender, EventArgs e)
        {
            using (SqlConnection pripojeni = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SuxPubConnectionString"].ConnectionString))
            {
                pripojeni.Open();
                string dotaz = "INSERT INTO Pub (lokace, prostornost, hodnoceni, obsluha, prostredi, odUzivatele) VALUES ('1', 'Normální', '1', '1', '1', '1') SELECT SCOPE_IDENTITY()";
                int noveId;
                using (SqlCommand prikaz = new SqlCommand(dotaz, pripojeni))
                {
                    noveId = int.Parse(prikaz.ExecuteScalar().ToString());
                }
                pripojeni.Close();
                Response.Redirect("Pub.aspx?Id=" + noveId.ToString());
            }
        }

        protected void btHledat_Click(object sender, EventArgs e)
        {

            bool prvniAtrakce = true;
            bool prvniPivo = true;
            bool prvniLokace = true;

            foreach (CheckBox cbAtrakce in listCBAtrakce)
            {
                if (cbAtrakce.Checked)
                {
                    if (!prvniAtrakce)
                    {
                        filtryAtrakce += ",";
                    }
                    else
                    {
                        prvniAtrakce = false;
                    }
                    filtryAtrakce += cbAtrakce.ID.Substring(3);

                    pocetFiltru++;
                }
            }


            foreach (CheckBox cbPivo in listCBPiva)
            {
                if (cbPivo.Checked)
                {
                    if (!prvniPivo)
                    {
                        filtryPiva += ",";
                    }
                    else
                    {
                        prvniPivo = false;
                    }
                    filtryPiva += cbPivo.ID.Substring(3);

                    pocetFiltru++;
                }
            }

            foreach (CheckBox cbLokace in listCBLokace)
            {
                if (cbLokace.Checked)
                {
                    if (!prvniLokace)
                    {
                        filtryLokace += ",";
                    }
                    else
                    {
                        prvniLokace = false;
                    }
                    filtryLokace += cbLokace.ID.Substring(3);

                }
            }


            VypisHospody(!prvniAtrakce, !prvniPivo, !prvniLokace);


        }

    }
}
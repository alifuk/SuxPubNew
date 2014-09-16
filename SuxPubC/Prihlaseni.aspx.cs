using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SuxPubC
{
    public partial class Prihlaseni : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["odhlasit"] != null)
            {
                Session.Clear();
            }
        }

        protected void btPrihlasit_Click(object sender, EventArgs e)
        {
            
            if (tbHeslo.Text.ToString() == "gabrielova" )
            {
                Session["prihlasen"] = "admin";
                Response.Redirect("Index.aspx");
            }
            else
            {
                Response.Redirect("Prihlaseni.aspx");
            }
        }
    }
}
<%@ Page Title="SuxPub" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="SuxPubC.Main" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
      $(document).ready(function () {

        $("#panelHledani").hide();

        var vyhledavano = '<%= vyhledavano %>';

          if (vyhledavano == "True")
          {
              $("#btOtevritHledani").addClass("clicked");
              $("#panelHledani").show(100).addClass("otevreno");
          }


        $("#btOtevritHledani").on("click", function () {
            if ($("#panelHledani").hasClass("otevreno"))
            { //Pokud chceme zavřít vyhledávací panel
                $("#btOtevritHledani").removeClass("clicked");
                $("#panelHledani").hide(100).removeClass("otevreno");
            }
            else
            {//Pokud chceme otevřít vyhledávací panel
                $("#btOtevritHledani").addClass("clicked");
                $("#panelHledani").show(100).addClass("otevreno");
            }
        });


      }); 
</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container">

    <p class="small">
    Vítejte na stránkách, kde najdete vše potřebné o hospodách v České Lípě.</p>

    
    <button type="button" id="btOtevritHledani" class="btn" >Hledání</button>
    <asp:Button ID="btPridat" runat="server" CssClass="btn" OnClick="btPridat_Click" Text="Přidat hospodu" />


    <div ID="panelHledani">
    <asp:PlaceHolder ID="phHledani" runat="server"></asp:PlaceHolder>
    <asp:Button ID="btHledat" CssClass="btn" runat="server" Text="Vyhledat" OnClick="btHledat_Click" UseSubmitBehavior="false" />
    </div>
    
            <h2 style="clear:both;"><asp:Label ID="lbHospodyNadpis" runat="server" Text=""></asp:Label></h2>
    
        <asp:PlaceHolder ID="phHospody" runat="server"></asp:PlaceHolder>
    

<p>
    &nbsp;</p>
<p>
    &nbsp;</p>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SuxPubC.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <!--
    <div class="starRate">
<div><b></b></div>
<ul>
<li><a ><span></span><b></b></a></li>
<li><a ><span></span></a></li>
<li><a ><span></span></a></li>
<li><a ><span></span></a></li>
<li><a ><span></span></a></li>
</ul>
</div>
        -->







    <div style="float:left;">
    <h2>Přehled všech hospod</h2>
        <asp:Button ID="btPridatHospodu" runat="server" Text="Přidat hospodu" OnClick="btPridatHospodu_Click" />
       

        <asp:Button ID="btOdhlaseni" runat="server" PostBackUrl="~/Prihlaseni.aspx?odhlasit=true" Text="Odhlásit se" />
       

    <asp:GridView ID="gwHospody" runat="server" CellPadding="4" DataSourceID="SqlDataSourceHospody" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Id" AllowSorting="True" AllowPaging="True" PageSize="15">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                <asp:BoundField DataField="nazev" HeaderText="Název" SortExpression="nazev" />
                <asp:BoundField DataField="adresa" HeaderText="Adresa" SortExpression="adresa" />
                <asp:BoundField DataField="lokace" HeaderText="Lokace" SortExpression="lokace" />
                <asp:BoundField DataField="hodnoceni" HeaderText="Hodnocení" SortExpression="hodnoceni" />
                <asp:BoundField DataField="odUzivatele" HeaderText="odUživatele" SortExpression="odUzivatele" />
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="Index.aspx?Id={0}" Text="Detail" />
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="Pub.aspx?Id={0}" Text="Upravit" />
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="Pub.aspx?Id={0}&amp;command=smazat" Text="Smazat" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceHospody" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT TOP 1000 Pub.[Id]
      ,Pub.[nazev]
      ,[adresa]
      ,[prostornost]
      ,Lok.nazev as lokace
      ,[hodnoceni]
      ,[obsluha]
      ,[prostredi]
     ,odUzivatele
     ,Lok.nazev AS lokace
  FROM dbo.[Pub] Pub
  INNER JOIN dbo.Lokace Lok ON Lok.Id = Pub.lokace
WHERE pub.smazano != 1 AND odUzivatele !=1
ORDER BY odUzivatele ASC , pub.nazev ASC"></asp:SqlDataSource>
    
    
    <br />

    


    <asp:Panel ID="PanelDetail" runat="server" >
        <div id="detail">

        <h2>Detail podniku:</h2><br />
        
            <asp:FormView ID="fvDetail" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceHospodaDetail">
                
                <ItemTemplate>
                    <table >
                        <tr><td>Název:</td><td><asp:Label ID="nazevLabel" runat="server" Text='<%# Bind("nazev") %>' /></td></tr>
                        <tr><td>Adresa:</td><td><asp:Label ID="adresaLabel" runat="server" Text='<%# Bind("adresa") %>' /></td></tr>
                        <tr><td>Celkové hodnocení:</td><td><asp:PlaceHolder ID="phHodnoceniStars" runat="server"></asp:PlaceHolder></td></tr>
                        <tr><td>Obsluha:</td><td><asp:PlaceHolder ID="phObsluhaStars" runat="server"></asp:PlaceHolder></td></tr>
                        <tr><td>Prostředí:</td><td><asp:PlaceHolder ID="phProstrediStars" runat="server"></asp:PlaceHolder></td></tr>
                        <tr><td>Prostornost:</td><td><asp:Label ID="prostornostLabel" runat="server" Text='<%# Bind("prostornost") %>' /></td></tr>
                        <tr><td>Lokace:</td><td><asp:Label ID="lokaceLabel" runat="server" Text='<%# Bind("lokace") %>' /></td></tr>
                        <tr><td>Návštěvníci:</td><td><asp:Label ID="navstevniciLabel" runat="server" Text='<%# Bind("navstevnici") %>' /></td></tr>
                        <tr><td style="vertical-align:top;">Poznámka:</td><td><asp:Label ID="poznamkaLabel" runat="server" Text='<%# Bind("poznamka") %>' /></td></tr>
                        <tr><td>gpsN:</td><td><asp:Label ID="gpsNLabel" runat="server" Text='<%# Bind("gpsN") %>' /></td></tr>
                        <tr><td>gpsE:</td><td><asp:Label ID="gpsELabel" runat="server" Text='<%# Bind("gpsE") %>' /></td></tr>
                    
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSourceHospodaDetail" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT 
      pub.Id,
                pub.[nazev]
      ,[adresa]
      ,[prostornost]
      ,lok.nazev as lokace
      ,[hodnoceni]
      ,[obsluha]
      ,[poznamka]
      ,[navstevnici]
      ,[prostredi]
      ,[gpsN]
      ,[gpsE]
      ,[datumPridani]
FROM [Pub] pub
INNER JOIN dbo.Lokace lok ON lok.Id = pub.lokace
WHERE pub.[Id] = @Id">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Id" QueryStringField="Id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <h3>Piva</h3><br />
            <asp:GridView ID="gvDetailPiva" runat="server" DataSourceID="SqlDataSourcePiva" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="pubId" HeaderText="pubId" SortExpression="pubId" Visible="False" />
                    <asp:BoundField DataField="nazev" HeaderText="nazev" SortExpression="nazev" />
                    <asp:BoundField DataField="cena" HeaderText="cena" SortExpression="cena" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourcePiva" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT TOP 1000 
      [pubId]
      ,Piva.nazev as nazev
      ,[cena]
  FROM .[dbo].[PivaCon] PivaC
  Inner join dbo.Piva Piva on Piva.Id = pivoId
  Where pubId=@pubId" InsertCommand="INSERT INTO Piva([nazev]) VALUES (@nazev)">
                <InsertParameters>
                    <asp:Parameter Name="nazev" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="pubId" QueryStringField="Id" DefaultValue="0" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
           
                <h3>Atrakce</h3>
                <br />
                <asp:GridView ID="gvDetailAtrakce" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceAtrakceDetail">
                    <Columns>
                        <asp:BoundField DataField="nazev" HeaderText="Název" SortExpression="nazev" />
                        <asp:BoundField DataField="poznamka" HeaderText="Poznámka" SortExpression="poznamka" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceAtrakceDetail" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT nazev, poznamka 
FROM [AtrakceCon] atcon
INNER JOIN dbo.Atrakce at ON at.Id = atcon.atrakceId

WHERE ([pubId] = @pubId)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="pubId" QueryStringField="Id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
               
                <asp:Panel ID="PanelMapa" runat="server">
                    
                    <script type="text/javascript" src="http://api4.mapy.cz/loader.js"></script>
    <script type="text/javascript">Loader.load();</script>

                    <div id="m" style="height:380px"></div>
                    <script type="text/javascript">
                       var gpsE = <%= gpsEJS %>;
                        var gpsN = <%= gpsNJS %>;
                        var nadpisBodu = '<%= nadpisBodu %>';
                        var textBodu = '<%= textBodu %>';

                        var center = SMap.Coords.fromWGS84(gpsN, gpsE);
                        var m = new SMap(JAK.gel("m"), center, 13);
                        m.addDefaultLayer(SMap.DEF_BASE).enable();
                        m.addDefaultControls();

                        var layer = new SMap.Layer.Marker();
                        m.addLayer(layer);
                        layer.enable();

                        var card = new SMap.Card();
                        card.getHeader().innerHTML = "<b>"+nadpisBodu+"</b>";
                        card.getBody().innerHTML = textBodu;

                        var options = { 
                            title: nadpisBodu
                        };
                        var marker = new SMap.Marker(center, "myMarker", options);
                        marker.decorate(SMap.Marker.Feature.Card, card);
                        layer.addMarker(marker);
	                </script>
                                       
                </asp:Panel>

        </div>
    </asp:Panel>
        


        
  </div>





    <div style="float:right; display:block;"> 
<h3>Piva</h3>
    <asp:FormView ID="FormView3" runat="server" DataSourceID="SqlDataSourcePivaGrid" DefaultMode="Insert" DataKeyNames="Id">
        
        
        <InsertItemTemplate>nazev:
            <asp:TextBox ID="nazevTextBox" runat="server" Text='<%# Bind("nazev") %>' />
            <br /><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Vložit" />
            
            
        </InsertItemTemplate>
        
        
    </asp:FormView>
    <br />
<asp:GridView ID="gvPiva" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourcePivaGrid">
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
        <asp:BoundField DataField="nazev" HeaderText="nazev" SortExpression="nazev" />
        <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="Index.aspx?smazatPivo={0}" Text="Smazat" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSourcePivaGrid" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT * FROM [Piva] 
Where smazano != 1" DeleteCommand="DELETE FROM [Piva] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Piva] ([nazev]) VALUES (@nazev)" UpdateCommand="UPDATE [Piva] SET [nazev] = @nazev WHERE [Id] = @Id">
    <DeleteParameters>
        <asp:Parameter Name="Id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="nazev" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="nazev" Type="String" />
        <asp:Parameter Name="Id" Type="Int32" />
    </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h3>Lokace</h3><br />
    <asp:FormView ID="FormView2" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceLokace" DefaultMode="Insert">
        
        <InsertItemTemplate>
            Přidat lokaci:
            <asp:TextBox ID="nazevTextBox" runat="server" Text='<%# Bind("nazev") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Vložit" />
            
        </InsertItemTemplate>
        
    </asp:FormView>
    <br />
    <asp:GridView ID="GridViewLokace" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceLokace">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="nazev" HeaderText="nazev" SortExpression="nazev" />
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="Index.aspx?smazatLokaci={0}" Text="smazat" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceLokace" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" DeleteCommand="DELETE FROM [Lokace] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Lokace] ([nazev]) VALUES (@nazev)" SelectCommand="SELECT * FROM [Lokace]
Where smazano != 1" UpdateCommand="UPDATE [Lokace] SET [nazev] = @nazev WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="nazev" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="nazev" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h3>Atrakce</h3><br />
    <asp:FormView ID="fvAtrakce" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceAtrakce" DefaultMode="Insert">
        
        <InsertItemTemplate>
            Nová atrakce:
            <asp:TextBox ID="nazevTextBox" runat="server" Text='<%# Bind("nazev") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Vložit" />
            
        </InsertItemTemplate>
        
    </asp:FormView>
    <asp:GridView ID="gvAtrakce" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceAtrakce">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="nazev" HeaderText="Název" SortExpression="nazev" />
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="Index.aspx?smazatAtrakci={0}" Text="smazat" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceAtrakce" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" DeleteCommand="DELETE FROM [Atrakce] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Atrakce] ([nazev]) VALUES (@nazev)" SelectCommand="SELECT * FROM [Atrakce]
Where smazano != 1" UpdateCommand="UPDATE [Atrakce] SET [nazev] = @nazev WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="nazev" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="nazev" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
<br />
    
    </div>

    
</asp:Content>

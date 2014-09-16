<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Pub.aspx.cs" Inherits="SuxPubC.Pub" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourcePub" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating">
        <EditItemTemplate>
            <h2>Upravení hospody</h2>
            Název:
            <asp:TextBox ID="nazevTextBox" runat="server" Text='<%# Bind("nazev") %>' />
            <br />
            Prostornost:
            <asp:DropDownList ID="ddlProstornost" runat="server" SelectedValue='<%# Bind("prostornost") %>'>
                <asp:ListItem>Prostorné</asp:ListItem>
                <asp:ListItem Selected="True">Normální</asp:ListItem>
                <asp:ListItem>Stísněné</asp:ListItem>
            </asp:DropDownList>
            <br />
            Lokace:
            <asp:DropDownList ID="ddlLokace" runat="server" SelectedValue='<%# Bind("lokace") %>' DataSourceID="SqlDataSourceLokace" DataTextField="nazev" DataValueField="Id" ></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceLokace" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT * FROM [Lokace]
Where smazano != 1"></asp:SqlDataSource>
            <br />
            Celkové hodnocení počet hvězdiček:
            <asp:DropDownList ID="ddlHodnoceni" runat="server" SelectedValue='<%# Bind("hodnoceni") %>'>
                <asp:ListItem>0</asp:ListItem>
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
            </asp:DropDownList>
            <br />
            Obsluha počet hvězdiček:
            <asp:DropDownList ID="ddlObsluha" runat="server" SelectedValue='<%# Bind("obsluha") %>'>
                <asp:ListItem>0</asp:ListItem>
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
            </asp:DropDownList>
            <br />
            Poznámka:
            <asp:TextBox ID="poznamkaTextBox" runat="server" Text='<%# Bind("poznamka") %>' Height="56px" TextMode="MultiLine" Width="223px" />
            <br />
            Typ návštěvníků (slovy popsat):
            <asp:TextBox ID="navstevniciTextBox" runat="server" Text='<%# Bind("navstevnici") %>' />
            <br />
            Prostředí počet hvězdiček:
            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("prostredi") %>'>
                <asp:ListItem>0</asp:ListItem>
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
            </asp:DropDownList>
            <asp:Panel ID="panelUmisteni" runat="server">
            <br />
            Adresa:
            <asp:TextBox ID="adresaTextBox" runat="server" Text='<%# Bind("adresa") %>' />
            <br />
            gpsN:
            <asp:TextBox ID="gpsNTextBox" runat="server" Text='<%# Bind("gpsN") %>' />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="gpsNTextBox" Display="Dynamic" ErrorMessage="chybně zadáno, použijte desetinou čárku" ValidationExpression="\d+[,]\d+"></asp:RegularExpressionValidator>
            <br />
            gpsE:
            <asp:TextBox ID="gpsETextBox" runat="server" Text='<%# Bind("gpsE") %>' />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="gpsETextBox" Display="Dynamic" ErrorMessage="chybně zadáno, použijte desetinou čárku" ValidationExpression="\d+[,]\d+"></asp:RegularExpressionValidator>
            <br />
            </asp:Panel>
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Uložit" Visible="false"/>
           
        
        <br /><h3>Přidat pivo:</h3>
            <h5>Půl litr nápoje, není li napsáno jinak.</h5>
            <h5>
                Pokud pivo není v seznamu, napište ho i s cenou nahoru do poznámky, díky :)</h5>
<asp:DropDownList ID="ddlPivo" runat="server" DataSourceID="SqlDataSourcePiva" DataTextField="nazev" DataValueField="Id">
</asp:DropDownList>
&nbsp;Cena:
<asp:TextBox ID="tbCena" runat="server" Width="40px"></asp:TextBox>
<asp:SqlDataSource ID="SqlDataSourcePiva" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT * FROM [Piva]
Where smazano != 1"></asp:SqlDataSource>
<asp:Button ID="btPridatPivo" runat="server" OnClick="btPridatPivo_Click" Text="Přidat" />
            <br />
            <h3>Piva:</h3>
            <asp:GridView ID="GridViewPiva" runat="server" AutoGenerateColumns="False" DataKeyNames="Id,Id1" DataSourceID="SqlDataSourcePivaZobraz" OnRowCommand="GridViewPiva_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:BoundField DataField="pubId" HeaderText="pubId" SortExpression="pubId" Visible="False" />
                    <asp:BoundField DataField="pivoId" HeaderText="pivoId" SortExpression="pivoId" Visible="False" />
                    <asp:BoundField DataField="Id1" HeaderText="Id1" InsertVisible="False" ReadOnly="True" SortExpression="Id1" Visible="False" />
                    <asp:BoundField DataField="nazev" HeaderText="nazev" SortExpression="nazev" Visible="False" />
                    <asp:BoundField DataField="Pivko" HeaderText="Pivko" SortExpression="Pivko" />
                    <asp:BoundField DataField="cena" HeaderText="Cena" SortExpression="cena" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourcePivaZobraz" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" SelectCommand="SELECT *,  
Piva.nazev as Pivko
FROM [PivaCon]
Inner join dbo.Piva Piva ON Piva.Id=pivoId
 WHERE ([pubId] = @pubId)" DeleteCommand="DELETE FROM [PivaCon] WHERE [Id] = @Id" InsertCommand="INSERT INTO [PivaCon] ([pubId], [pivoId], [cena]) VALUES (@pubId, @pivoId, @cena)" UpdateCommand="UPDATE [PivaCon] SET [pubId] = @pubId, [pivoId] = @pivoId, [cena] = @cena WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="pubId" Type="Int32" />
                    <asp:Parameter Name="pivoId" Type="Int32" />
                    <asp:Parameter Name="cena" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="pubId" QueryStringField="Id" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="pubId" Type="Int32" />
                    <asp:Parameter Name="pivoId" Type="Int32" />
                    <asp:Parameter Name="cena" Type="Decimal" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <h3>Atrakce</h3>
            <h5>Pokud v hospodě atrakce je, zaškrtněte políčko. Volitelně připište poznámku. <br />Pokud se v hospodě nachází atrakce, která zde není vypsaná, připište jí do poznámky k hospodě.</h5>
            <asp:PlaceHolder ID="PlaceHolderAtrakce" runat="server"></asp:PlaceHolder>
            <br />
            <br />
            <asp:Button ID="btUlozAtrakce" runat="server" OnClick="btUlozAtrakce_Click" Text="Uložit a jít zpět" />
            <br />
<br />
             
        </EditItemTemplate>      
        
        
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSourcePub" runat="server" ConnectionString="<%$ ConnectionStrings:SuxPubConnectionString %>" DeleteCommand="DELETE FROM [Pub] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Pub] ([nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE]) VALUES (@nazev, @adresa, @prostornost, @lokace, @hodnoceni, @obsluha, @poznamka, @navstevnici, @prostredi, @gpsN, @gpsE)" SelectCommand="SELECT * FROM [Pub] WHERE Id=@Id" UpdateCommand="UPDATE [Pub] SET [nazev] = @nazev, [adresa] = @adresa, [prostornost] = @prostornost, [lokace] = @lokace, [hodnoceni] = @hodnoceni, [obsluha] = @obsluha, [poznamka] = @poznamka, [navstevnici] = @navstevnici, [prostredi] = @prostredi, [gpsN] = @gpsN, [gpsE] = @gpsE WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="nazev" Type="String" />
            <asp:Parameter Name="adresa" Type="String" />
            <asp:Parameter Name="prostornost" Type="String" />
            <asp:Parameter Name="lokace" Type="Int32" />
            <asp:Parameter Name="hodnoceni" Type="Int32" />
            <asp:Parameter Name="obsluha" Type="String" />
            <asp:Parameter Name="poznamka" Type="String" />
            <asp:Parameter Name="navstevnici" Type="String" />
            <asp:Parameter Name="prostredi" Type="Int32" />
            <asp:Parameter Name="gpsN" Type="Double" />
            <asp:Parameter Name="gpsE" Type="Double" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="Id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="nazev" Type="String" />
            <asp:Parameter Name="adresa" Type="String" />
            <asp:Parameter Name="prostornost" Type="String" />
            <asp:Parameter Name="lokace" Type="Int32" />
            <asp:Parameter Name="hodnoceni" Type="Int32" />
            <asp:Parameter Name="obsluha" Type="String" />
            <asp:Parameter Name="poznamka" Type="String" />
            <asp:Parameter Name="navstevnici" Type="String" />
            <asp:Parameter Name="prostredi" Type="Int32" />
            <asp:Parameter Name="gpsN" Type="Double" />
            <asp:Parameter Name="gpsE" Type="Double" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" PostBackUrl="~/Index.aspx" Text="Zpět bez uložení" />
    <br />
    <br />
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Prihlaseni.aspx.cs" Inherits="SuxPubC.Prihlaseni" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Heslo: <asp:TextBox ID="tbHeslo" runat="server" TextMode="Password"></asp:TextBox><asp:Button ID="btPrihlasit" runat="server" Text="Přihlásit" OnClick="btPrihlasit_Click" />
</asp:Content>

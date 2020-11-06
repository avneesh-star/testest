<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="emp.aspx.cs" Inherits="testlsit.emp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="position: center; margin-left: 10px; margin-top: 10px; width: 290px; background-color: aquamarine;">
            <table style="background-color: darkorchid">
                <tr>
                    <td>Name:</td>
                    <td>
                        <asp:TextBox ID="txt_name" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Gender:</td>
                    <td>
                        <asp:RadioButtonList ID="rbl_gender" runat="server" RepeatColumns="3">
                            <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Others" Value="3"></asp:ListItem>
                        </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td>Blood Group:</td>
                    <td>
                        <asp:RadioButtonList ID="rbl_blood_group" runat="server" DataSourceID="SqlDataSource1" DataTextField="bg_name" DataValueField="bg_id" RepeatColumns="4">
                        </asp:RadioButtonList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db_testlistConnectionString %>" SelectCommand="SELECT * FROM [blood_group]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>Department:</td>
                    <td>
                        <asp:DropDownList ID="ddl_department" DataSourceID="sqlds_department" DataTextField="dp_name" DataValueField="dp_id" runat="server">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sqlds_department" runat="server" ConnectionString="<%$ ConnectionStrings:db_testlistConnectionString %>" SelectCommand="select * from department"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>Location:</td>
                    <td>
                        <asp:DropDownList ID="ddl_location" runat="server" DataSourceID="sqlds_location" DataTextField="l_name" DataValueField="l_id"></asp:DropDownList>
                        <asp:SqlDataSource ID="sqlds_location" runat="server" ConnectionString="<%$ ConnectionStrings:db_testlistConnectionString %>" SelectCommand="SELECT * FROM [tbl_location]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btn_submit" Text="Submit" runat="server" OnClick="btn_submit_Click" /></td>
                </tr>
                
            </table>
        </div>
        <div style="position: center; margin-left: 350px; margin-top: -165px; background-color:lightgreen; width: 513px;">
            <table>
                <tr>
                    <td></td>
                    <td>
                        <asp:GridView ID="grd" runat="server" AutoGenerateColumns="False" OnRowCommand="grd_RowCommand" CellPadding="3" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2">
                            <Columns>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <%# Eval("emp_name") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Gender">
                                    <ItemTemplate>
                                        <%# Eval("emp_gender").Equals(1)?"Male":Eval("emp_gender").Equals(2)?"Female":"Others" %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText=" Blood Group">
                                    <ItemTemplate>
                                        <%# Eval("bg_name") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <%# Eval("dp_name") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <%# Eval("l_name") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btn_delete" Text="Delete" runat="server" CommandName="del" CommandArgument='<%# Eval("emp_id") %>' />
                                    </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btn_edit" Text="Edit" runat="server" CommandName="edt" CommandArgument='<%# Eval("emp_id") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FFF1D4" />
                            <SortedAscendingHeaderStyle BackColor="#B95C30" />
                            <SortedDescendingCellStyle BackColor="#F1E5CE" />
                            <SortedDescendingHeaderStyle BackColor="#93451F" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>

                    </td>
                    <td><asp:Label ID="lbl_msg" runat="server" Font-Bold="true" ForeColor="#ff0000"></asp:Label></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

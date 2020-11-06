using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
namespace testlsit
{
    public partial class emp : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("data source=AVNEESH\\SQLEXPRESS;initial catalog=db_testlist;integrated security=true");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                display();
            }
        }
        public void display()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_select_emp_rec", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr.HasRows)
            {
                grd.DataSource = dr;
                grd.DataBind();
            }
            else
            {
                lbl_msg.Text = "Record not avilable!!";
            }
            con.Close();
        }
        public void clear()
        {
            txt_name.Text = "";
            rbl_gender.SelectedItem.Selected = false;
            rbl_blood_group.SelectedItem.Selected = false;
            ddl_department.SelectedItem.Selected = false;
            ddl_location.SelectedItem.Selected = false;
            btn_submit.Text = "Submit";
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if(btn_submit.Text== "Submit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_insert_emp_rec", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_name", txt_name.Text);
                cmd.Parameters.AddWithValue("@emp_gender", rbl_gender.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@emp_blood", rbl_blood_group.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@emp_department", ddl_department.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@emp_location", ddl_location.SelectedItem.Value);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    lbl_msg.Text = "Data Saved!!";
                    clear();
                }
                else
                {
                    lbl_msg.Text = "Data not Saved!!";
                }
                display();
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_update_emp_rec", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_id", ViewState["ss"]);
                cmd.Parameters.AddWithValue("@emp_name", txt_name.Text);
                cmd.Parameters.AddWithValue("@emp_gender", rbl_gender.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@emp_blood", rbl_blood_group.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@emp_department", ddl_department.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@emp_location", ddl_location.SelectedItem.Value);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    lbl_msg.Text = "Data Updated!!";
                    clear();
                }
                else
                {
                    lbl_msg.Text = "Data not updated!!";
                }
                display();
            }
        }

        protected void grd_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_delete_emp_rec", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_id", e.CommandArgument);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    lbl_msg.Text = "Data Deleted!!";
                    
                }
                else
                {
                    lbl_msg.Text = "Data not Deleted!!";
                }
                display();
            }
            else if (e.CommandName == "edt")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_edit_emp_rec", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@emp_id", e.CommandArgument);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                con.Close();
                txt_name.Text = dt.Rows[0][1].ToString();
                rbl_gender.SelectedValue = dt.Rows[0][2].ToString();
                rbl_blood_group.SelectedValue = dt.Rows[0][3].ToString();
                ddl_department.SelectedValue = dt.Rows[0][4].ToString();
                ddl_location.SelectedValue = dt.Rows[0][5].ToString();
                btn_submit.Text = "Update";
                ViewState["ss"] = e.CommandArgument;
            }
        }
    }
}
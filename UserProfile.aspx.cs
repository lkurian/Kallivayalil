using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using SD = System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing;


public partial class UserProfile : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Params["ID"] == null)
            Session.Add("queryID", Session["ID"]);
        else
            Session.Add("queryID", Request.Params["ID"]);

        SqlDataSource3.UpdateParameters["Key"].DefaultValue = Constants.AESKey;
        if (!IsPostBack)
            Page.DataBind();
       
        lnkAddPhoto.Click += new EventHandler(lnkAddPhoto_Click);
        lblError.Visible = false;
    }

    void lnkAddPhoto_Click(object sender, EventArgs e)
    {
        pnlUpload.Visible = true;
    }

    protected void btnCancelCrop_Click(object sender, EventArgs e)
    {
        pnlCrop.Visible = false;
        pnlCropped.Visible = true;
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        Boolean FileOK = false;
        Boolean FileSaved = false;
        if (FileUpload1.HasFile)
        {
            Session["WorkingImage"] = FileUpload1.FileName;
            String FileExtension = Path.GetExtension(Session["WorkingImage"].ToString()).ToLower();
            String[] allowedExtensions = { ".png", ".jpeg", ".jpg", ".gif" };
            for (int i = 0; i < allowedExtensions.Length; i++)
            {
                if (FileExtension == allowedExtensions[i])
                {
                    FileOK = true;
                }
            }
        }


        if (FileOK)
        {
            try
            {
                Byte[] file = FileUpload1.FileBytes;
                AccessDB dbObj = new AccessDB();
                dbObj.Open();
                dbObj.Query = "Update tblUserProfile SET Photo=? where UserProfileID=?";
                dbObj.command.Parameters.Add(new System.Data.Odbc.OdbcParameter("Photo", file));
                dbObj.command.Parameters.Add(new System.Data.Odbc.OdbcParameter("UserProfileID", Session["ID"]));
                dbObj.command.Prepare();
                dbObj.ExecuteNonQuery();
                dbObj.Close();
                FileSaved = true;
            }
            catch (Exception ex)
            {
                lblError.Text = "File could not be uploaded." + ex.Message.ToString();
                lblError.Visible = true;
                FileSaved = false;
            }
        }
        else
        {
            lblError.Text = "Cannot accept files of this type.";
            lblError.Visible = true;
        }

        if (FileSaved)
        {
            pnlUpload.Visible = false;
            pnlCrop.Visible = true;
            pnlCropped.Visible = false;
        }

    }

    protected void btnCropPhoto_Click(object sender, EventArgs e)
    {
        pnlUpload.Visible = false;
        pnlCrop.Visible = true;
        pnlCropped.Visible = false;
    }

    protected void btnCrop_Click(object sender, EventArgs e)
    {
        try
        {
            if (W.Value != string.Empty)
            {
                int w = Convert.ToInt32(W.Value);
                int h = Convert.ToInt32(H.Value);
                int x = Convert.ToInt32(X.Value);
                int y = Convert.ToInt32(Y.Value);
                AccessDB dbObj = new AccessDB();
                dbObj.Open();
                dbObj.Query = "Select Photo from tblUserProfile where userprofileID=?";
                dbObj.command.Parameters.Add(new System.Data.Odbc.OdbcParameter("userprofileID", Session["ID"]));
                byte[] _buf = (byte[])dbObj.ExecuteScalar();
                dbObj.Close();

                MemoryStream msOrig = new MemoryStream(_buf);
                byte[] CropImage = Crop(msOrig, w, h, x, y);
                using (MemoryStream ms = new MemoryStream(CropImage, 0, CropImage.Length))
                {
                    ms.Write(CropImage, 0, CropImage.Length);
                    Byte[] Cropped = ms.ToArray();
                    AccessDB dbObj1 = new AccessDB();
                    dbObj1.Open();
                    dbObj1.Query = "Update tblUserProfile SET Photo=? where UserProfileID=?";
                    dbObj1.command.Parameters.Add(new System.Data.Odbc.OdbcParameter("Photo", Cropped));
                    dbObj.command.Parameters.Add(new System.Data.Odbc.OdbcParameter("UserProfileID", Session["ID"]));
                    dbObj1.command.Prepare();
                    dbObj1.ExecuteNonQuery();


                }
            }
        }catch(Exception ex)
        {
        }
        finally
        {
        pnlCrop.Visible = false;
        pnlCropped.Visible = true;
        }
    }

    /// <summary>
    /// Crop the image
    /// </summary>
    /// <param name="Img"></param>
    /// <param name="Width"></param>
    /// <param name="Height"></param>
    /// <param name="X"></param>
    /// <param name="Y"></param>
    /// <returns></returns>
    static byte[] Crop(Stream Img, int Width, int Height, int X, int Y)
    {
        try
        {
            using (SD.Image OriginalImage = SD.Image.FromStream(Img))
            {
                using (SD.Bitmap bmp = new SD.Bitmap(Width, Height, OriginalImage.PixelFormat))
                {
                    bmp.SetResolution(OriginalImage.HorizontalResolution, OriginalImage.VerticalResolution);
                    using (SD.Graphics Graphic = SD.Graphics.FromImage(bmp))
                    {
                        Graphic.SmoothingMode = SmoothingMode.AntiAlias;
                        Graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        Graphic.PixelOffsetMode = PixelOffsetMode.HighQuality;
                        Graphic.DrawImage(OriginalImage, new SD.Rectangle(0, 0, Width, Height), X, Y, Width, Height, SD.GraphicsUnit.Pixel);
                        MemoryStream ms = new MemoryStream();
                        bmp.Save(ms, OriginalImage.RawFormat);
                        return ms.GetBuffer();
                    }
                }
            }
        }
        catch (Exception Ex)
        {
            throw (Ex);
        }
    }






    protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        multiTabs.ActiveViewIndex = Int32.Parse(menuTabs.SelectedValue);
    }

    protected void lnkInsert_Click(object sender, EventArgs e)
    {
        DetailsView4.ChangeMode(DetailsViewMode.Insert);
    }

    protected void lnkInsertChild_Click(object sender, EventArgs e)
    {
        DetailsView5.ChangeMode(DetailsViewMode.Insert);
    }
}

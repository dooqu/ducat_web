using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modal;
using BLL;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace admin
{
    public partial class OrderDetail : BasePage
    {
        protected int regId;
        protected RegInfo reg;
        protected OrderInfo order;
        protected UserPolicyInfo policy;
        protected static string[] Types = new string[] { "FNC", "DNC", "FSCC", "DSCC", "FSSC", "SSC", "LLC", "DLLC" };
        protected void Page_Load(object sender, EventArgs e)
        {
            if(CanDo(RoleBehavior.OrderSetting) == false)
            {
                throw new Exception("您暂无权限访问订单管理");
            }
            if(Int32.TryParse(Request.Params["regid"], out regId) == false)
            {
                throw new Exception("订单信息未找到");
            }

            reg = BLL.Regs.GetRegInfoById(regId);

            if(reg == null)
            {
                throw new Exception("订单信息未找到");
            }

            if(reg.IsPayed)
            {
                order = Orders.GetOrderInfoByRegId(regId);

                if(order == null)
                {
                    throw new Exception("订单未找到");
                }

                if(order.UPId != 0)
                {
                    policy = Policies.GetUserPolicyInfoById(order.UPId);
                }               
            }

            if(Request.Params["func"] == "pdf")
            {
                PrintPDF();
                //Response.Redirect("OrderDetail.aspx?pageIndex" + this.regId.ToString());
                Response.Clear();
                //Response.AppendHeader("content-type", "octect-stream/application");
                Response.AppendHeader("Content-Disposition", "attachment;filename=order" + order.OrderId.ToString() + ".pdf");
                Response.WriteFile(Server.MapPath("/") + "pdfs/order_" + order.OrderId.ToString() + ".pdf");
                return;
            }

            Page.DataBind();
        }

        protected void PrintPDF()
        {
            //标题字体
            BaseFont basefont_Title = BaseFont.CreateFont(
              Server.MapPath("/") + "/font/msyh.ttf",
              BaseFont.IDENTITY_H,
              BaseFont.EMBEDDED);
            Font font_Title = new Font(basefont_Title, 32 * 0.667f, Font.BOLD, new BaseColor(68, 68, 68));
            //表格列字体

            Font font_Col = new Font(basefont_Title, 16 * 0.667f, Font.NORMAL, new BaseColor(68, 68, 68));
            //正文字体

            Font font_Context = new Font(basefont_Title, 16 * 0.667f, Font.NORMAL, new BaseColor(68, 68, 68));

            string strFileName = Server.MapPath("/") + "/pdfs/order_" + order.OrderId.ToString() + ".pdf";
            Document document = new Document(PageSize.A4.Rotate(), 2, 20, 20, 20);
            PdfWriter writer = PdfWriter.GetInstance(document,
                new System.IO.FileStream((strFileName), System.IO.FileMode.Create));

            document.Open();

            Paragraph p_Title = new Paragraph("订单信息", font_Title);
            p_Title.PaddingTop = 30.0f;

            p_Title.Alignment = Element.ALIGN_CENTER;
            document.Add(p_Title);

            //根据数据表内容创建一个PDF格式的表
            PdfPTable table = new PdfPTable(2);
            table.PaddingTop = 30.0f;
            table.TotalWidth = 500;//表格总宽度
            table.LockedWidth = true;//锁定宽度
            table.SetWidths(new float[] { 200, 300 });//设置每列宽度

            //设置列头背景色
            table.DefaultCell.BackgroundColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
            //设置列头文字水平、垂直居中
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_JUSTIFIED;
            table.DefaultCell.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
            table.DefaultCell.MinimumHeight = 30.0f;
            table.DefaultCell.PaddingLeft = 15.0f;
            table.DefaultCell.PaddingRight = 15.0f;

            //table.HeaderRows = 1;

            table.AddCell(new Phrase("项目名称", font_Col));
            table.AddCell(new Phrase("内容", font_Col));

            //table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.DefaultCell.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
            table.DefaultCell.BackgroundColor = BaseColor.WHITE;

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("注册州区", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.AreaName + "(" + reg.AreaNameEN + ")", font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司类型", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(Types[reg.SolutionId], font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("是否加急", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.IsSpc? "加急" : "不加急", font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("联系人姓名", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.LinkmanName, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("联系人手机", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.LinkmanTel, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("联系人Email", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.LinkmanEmail, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("联系人住址", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.LinkmanAddr, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("联系人微信", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.LinkmanWechat, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司注册名1", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.CompName1, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司注册名2", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.CompName2, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司注册名2", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.CompName2, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司注册地址", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.CompRegAddr, font_Col));

            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司运营项目", font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.CompProp, font_Col));

            var compType = Types[reg.SolutionId];
            if(compType != "FNC" && compType != "DNC" && compType != "LLC" && compType != "DLLC")
            {
                table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                table.AddCell(new Phrase("发行股票数", font_Col));
                table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                table.AddCell(new Phrase(reg.StockCount.ToString() + "股", font_Col));
            }

            string mem = (compType == "LLC" || compType == "DLLC") ? "成员" : "股东";
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司" + mem, font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.StockHolder + "股", font_Col));

            mem = (compType == "LLC" || compType == "DLLC") ? "经理" : "CEO";
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table.AddCell(new Phrase("公司" + mem, font_Col));
            table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table.AddCell(new Phrase(reg.CEOName, font_Col));

            if((compType != "LLC" && compType != "DLLC"))
            {
                table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                table.AddCell(new Phrase("CFO姓名", font_Col));
                table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                table.AddCell(new Phrase(reg.CFOName, font_Col));

                table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                table.AddCell(new Phrase("秘书长姓名", font_Col));
                table.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                table.AddCell(new Phrase(reg.Secretor, font_Col));
            }
            document.Add(table);

            p_Title = new Paragraph("付费和折扣信息", font_Title);
            p_Title.PaddingTop = 30.0f;

            p_Title.Alignment = Element.ALIGN_CENTER;
            document.Add(p_Title);

            PdfPTable table2 = new PdfPTable(2);
            table2.PaddingTop = 30.0f;
            table2.TotalWidth = 500;//表格总宽度
            table2.LockedWidth = true;//锁定宽度
            table2.SetWidths(new float[] { 200, 300 });//设置每列宽度
            table2.DefaultCell.MinimumHeight = 30.0f;
            table2.DefaultCell.PaddingLeft = 15.0f;
            table2.DefaultCell.PaddingRight = 15.0f;

            //设置列头背景色
            table2.DefaultCell.BackgroundColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
            //设置列头文字水平、垂直居中
            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_MIDDLE;
            table2.DefaultCell.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
            table2.DefaultCell.MinimumHeight = 30.0f;

            table2.AddCell(new Phrase("项目名称", font_Col));
            table2.AddCell(new Phrase("内容", font_Col));

            table2.DefaultCell.BackgroundColor = BaseColor.WHITE;
            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table2.AddCell(new Phrase("基础费用", font_Col));
            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table2.AddCell(new Phrase(order.BaseMoney + "元", font_Col));

            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table2.AddCell(new Phrase("政府费用", font_Col));
            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table2.AddCell(new Phrase(order.GovMoney + "元", font_Col));

            if(order.IsSpc)
            {
                table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                table2.AddCell(new Phrase("加急费用", font_Col));
                table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                table2.AddCell(new Phrase(order.SpcMoney + "元", font_Col));
            }


            if(order.UPId != 0)
            {
                table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                table2.AddCell(new Phrase("优惠活动", font_Col));
                table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                table2.AddCell(new Phrase(policy.Title, font_Col));

                table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                table2.AddCell(new Phrase("折扣金额", font_Col));
                table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                table2.AddCell(new Phrase(order.OrderDisMoney.ToString(), font_Col));
            }

            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            table2.AddCell(new Phrase("付费日期", font_Col));
            table2.DefaultCell.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
            table2.AddCell(new Phrase(order.DatePayed.ToString("yyyy年MM月dd日 hh点mm分ss秒"), font_Col));

            document.Add(table2);

            document.Close();
            writer.Close();
        }
    }
}
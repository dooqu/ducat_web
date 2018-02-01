<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AdManager.aspx.cs" Inherits="admin.AdManager" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function delImg(adid)
        {
            if (confirm("确定要删除该广告么"))
            {
                document.forms[0].method.value = "delImg";
                document.forms[0].adid.value = adid;
                document.forms[0].submit();
            }
        }
    </script>
    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>广告管理</h2>
            </div>
        </div>
    </div>
    <div style="width:100%;display:flex;flex-direction:row;flex-wrap:wrap">
        <asp:Repeater ID="adsRepeater" runat="server">
            <ItemTemplate>
                <div style='position:relative;margin:20px;border:1px solid #c0c0c0;width:200px;height:200px;border:1px solid #c0c0c0;background-position:center center;background-size:contain;background-repeat:no-repeat;background-image:url("/ads/<%#Eval("ImagePath")%>")'>
                    <img src="img/delete.png" style="width:25px;height:25px;position:absolute;right:0px;bottom:0px;" onclick="javascript:delImg('<%#Eval("AdId")%>')"/>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="row">
        <div id="authlist" class="jumbotron" style="overflow: hidden; padding: 10px;">
            <p>投放新的展示</p>
            <form enctype="multipart/form-data" method="post">
            <input type="hidden" value="" id="method" name="method" />
            <input type="hidden" value="" id="adid" name="adid" />
            <input type="file" id="adImage" name="adImage" class="form-control" />
            <input type="submit" class="btn btn-success" value="上传图片"/>
            </form>
        </div>
    </div>
</asp:Content>

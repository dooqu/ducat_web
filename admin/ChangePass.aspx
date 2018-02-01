<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChangePass.aspx.cs" Inherits="admin.ChangePass" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>订单详情</h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box border blue">
                <div class="box-title">
                    <h4><i class="fa fa-hand-o-up"></i></h4>
                    订单详情
                </div>
                <div class="box-body">
                    <!-- 添加用户的区域 -->
                    <form method="post">
                        <input type="hidden" id="func" name="func" value="change" />
                        <div style="width:500px;display:flex;flex-direction:row;height:50px">

                            <div style="width:0px;flex-grow:5">请输入旧密码:</div>
                            <div style="width:0px;flex-grow:8"><input type="password" class="form-control" id="oldPass" name="oldPass" /></div>
                        </div>
                        <div style="width:500px;display:flex;flex-direction:row;height:50px">

                            <div style="width:0px;flex-grow:5">请输入新密码:</div>
                            <div style="width:0px;flex-grow:8"><input type="password" class="form-control" id="newPass" name="newPass" /></div>
                        </div>                        
                        <div style="width:500px;display:flex;flex-direction:row;height:50px">

                            <div style="width:0px;flex-grow:5">请输入新密码确认:</div>
                            <div style="width:0px;flex-grow:8"><input type="password" class="form-control" id="newPassConfirm" name="newPassConfirm" /></div>
                        </div>                      
                        <div style="width:500px;display:flex;flex-direction:row;height:50px">
                            <div style="width:0px;flex-grow:5"></div>
                            <div style="width:0px;flex-grow:8">
                             <input type="submit" value="修改" class="button" />
                                </div>
                        </div>
                       
                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="UserManager.aspx.cs" Inherits="admin.UserManager" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <style>
                .page_control {
            display: flex;
            flex-direction: row;
        }

            .page_control a {
                display: block;
                width: auto;
                padding: 8px;
                border: 1px solid #9c9ace;
                background-color: #efefef;
                margin: 0px 5px;
            }

            .page_control .curr_page {
                background-color: #cecfff;
            }
    </style>
    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>注册用户管理</h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box border blue">
                <div class="box-title">
                    <h4><i class="fa fa-hand-o-up"></i></h4>
                    全部系统用户
                                                <div class="tools">
                                                    <a class="config" href="#box-config" data-toggle="modal">
                                                        <i class="fa fa-cog"></i>
                                                    </a>
                                                    <a class="reload" href="javascript:;">
                                                        <i class="fa fa-refresh"></i>
                                                    </a>
                                                    <a class="collapse" href="javascript:;">
                                                        <i class="fa fa-chevron-up"></i>
                                                    </a>
                                                    <a class="remove" href="javascript:;">
                                                        <i class="fa fa-times"></i>
                                                    </a>
                                                </div>
                </div>
                <div class="box-body">
                    <!-- 添加用户的区域 -->
                    <div class="jumbotron" style="padding: 10px;font-size:13px;">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>OpenID</th>
                                    <th>创建时间</th>
                                    <th>订单数</th>
                                    <th>推广码</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="usersRepeater" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Eval("UserId") %></td>
                                            <td><%#Eval("OpenId") %></td>
                                            <td><%#Eval("UserCreatedDate") %></td>
                                            <td><%#Eval("OrderCount") %></td>
                                            <td><%#Eval("UserPoliciesCount") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <div class="page_control" style="margin: 10px;text-align:right;">
                            <asp:Repeater ID="pageNumRepeater" runat="server">
                                <ItemTemplate>
                                    <a href="<%#((admin.PageControl.PageNumber)Container.DataItem).IsCurrPage? "#none" : "PoliciesManager.aspx?pageIndex=" + Eval("PageIndex").ToString() %>" class="<%#((admin.PageControl.PageNumber)Container.DataItem).IsCurrPage? "curr_page" : "" %>"><%#Eval("PageText") %></a>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</asp:Content>

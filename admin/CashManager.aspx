<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CashManager.aspx.cs" Inherits="admin.CashManager" %>
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
    <script language="javascript">
        function doCash(cashid)
        {
            if(confirm('确定要操作订单号为' + cashid + '的提现申请么？'))
            {
                document.forms[0].func.value = "docash";
                document.forms[0].cashid.value = cashid;
                document.forms[0].pageIndex2.value = '<%=pageIndex%>'
                document.forms[0].submit();
            }
        }
    </script>
    <form method="post">
        <input type="hidden" id="func" name="func" value="" />
        <input type="hidden" id="pageIndex2" name="pageIndex2" value="" />
        <input type="hidden" id="cashid" name="cashid" value="" />
    </form>
    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>优惠提现管理</h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box border blue">
                <div class="box-title">
                    <h4><i class="fa fa-hand-o-up"></i></h4>
                    全部提现订单
                </div>
                <div class="box-body">
                    <!-- 添加用户的区域 -->
                    <div class="jumbotron" style="padding: 10px;font-size:13px;">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>订单号</th>
                                    <th>用户ID</th>
                                    <th>OpenID</th>
                                    <th>提现金额</th>
                                    <th>微信号</th>
                                    <th>移动手机</th>
                                    <th>提交时间</th>
                                    <th> 状态</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="cashRepeater" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Eval("CashId") %></td>
                                            <td><%#Eval("UserId") %></td>
                                            <td><%#Eval("OpenId") %></td>
                                            <td><%#Eval("CashMoney") %></td>
                                            <td><%#Eval("WechatId") %></td>
                                            <td><%#Eval("Mobile") %></td>
                                            <td><%#Convert.ToDateTime(Eval("DateCreated")).ToString("yyyy年MM月dd日 hh:mm:ss") %></td>
                                            <td><%#Convert.ToBoolean(Eval("IsPayed"))? "已经转账" : "<a href='javascript:doCash(\"" + Eval("CashId").ToString() + "\")'>待处理</a>" %></td>
                                            <td></td>
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

<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderManager.aspx.cs" Inherits="admin.OrderManager" %>
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
                <h2>订单管理</h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box border blue">
                <div class="box-title">
                    <h4><i class="fa fa-hand-o-up"></i></h4>
                    全部订单
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
                                    <th>注册公司名</th>
                                    <th>订单金额</th>
                                    <th>折扣</th>
                                    <th>推广分成</th>
                                    <th>是否加急</th>
                                    <th>支付时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="orderRepeater" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Eval("OrderId") %></td>
                                            <td><%#Eval("UserId") %></td>
                                            <td><%#((Modal.UserInfo)Eval("User")).OpenID %></td>
                                            <td><%#((Modal.RegInfo)Eval("Reg")).CompName1 %></td>
                                            <td><%#(Convert.ToInt32(Eval("BaseMoney")) + Convert.ToInt32(Eval("GovMoney")))  %></td>
                                            <td><%#Convert.ToInt32(Eval("OrderDisMoney")) %></td>
                                            <td><%#Convert.ToInt32(Eval("OrderShareMoney"))%></td>
                                            <td><%#Convert.ToBoolean(Eval("IsSpc"))? "加急" : "不加急" %></td>
                                            <td><%#Convert.ToDateTime(Eval("DatePayed")).ToString("yyyy年MM月dd日 hh:mm:ss") %></td>
                                            <td><a href="OrderDetail.aspx?regId=<%#Eval("RegId") %>">详细</a></td>
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

<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="admin.OrderDetail" %>
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
                    <a href="OrderDetail.aspx?regid=<%=reg.RegId %>&func=pdf">下载pdf</a>
                </div>
                <div class="box-body">
                    <!-- 添加用户的区域 -->
                    <div class="jumbotron" style="padding: 10px;font-size:13px;display:flex;flex-direction:column;">
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">注册州区</div>
                            <div style="width:0px;flex-grow:12"><%= (reg.AreaName + "(" + reg.AreaNameEN + ")") %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司类型</div>
                            <div style="width:0px;flex-grow:12"><%= Types[reg.SolutionId] %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">注册周期</div>
                            <div style="width:0px;flex-grow:12"><%= (reg.IsSpc)? reg.SpcDays : reg.Days %>天</div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">是否加急</div>
                            <div style="width:0px;flex-grow:12"><%=reg.IsSpc? "加急" : "不加急" %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">联系人姓名</div>
                            <div style="width:0px;flex-grow:12"><%=reg.LinkmanName %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">联系人电话</div>
                            <div style="width:0px;flex-grow:12"><%=reg.LinkmanTel %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">联系人email</div>
                            <div style="width:0px;flex-grow:12"><%=reg.LinkmanEmail %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">联系人地址</div>
                            <div style="width:0px;flex-grow:12"><%=reg.LinkmanAddr %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">联系人微信</div>
                            <div style="width:0px;flex-grow:12"><%=reg.LinkmanWechat %></div>
                        </div>

                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司注册名1</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CompName1 %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司注册名2</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CompName2 %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司注册名3</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CompName3 %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司注册地址</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CompRegAddr %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司运营项目</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CompProp %></div>
                        </div>

                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">发行股票数</div>
                            <div style="width:0px;flex-grow:12"><%=reg.StockCount %>股</div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司股东</div>
                            <div style="width:0px;flex-grow:12"><%=reg.StockHolder %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司CEO</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CEOName %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">公司CFO</div>
                            <div style="width:0px;flex-grow:12"><%=reg.CFOName %></div>
                        </div>
                        <div style="width:100%;display:flex;flex-direction:row">
                            <div style="width:0px;flex-grow:4">秘书长</div>
                            <div style="width:0px;flex-grow:12"><%=reg.Secretor %></div>
                        </div>
                    </div>
                    <div class="jumbotron" style="padding: 10px; font-size: 13px; display: flex; flex-direction: column;">
                        <div style="width: 100%; display: flex; flex-direction: row">
                            <div style="width: 0px; flex-grow: 4">基础费用</div>
                            <div style="width: 0px; flex-grow: 12"><%= order.BaseMoney %>元</div>
                        </div>
                        <div style="width: 100%; display: flex; flex-direction: row">
                            <div style="width: 0px; flex-grow: 4">政府费用</div>
                            <div style="width: 0px; flex-grow: 12"><%= order.GovMoney %>元</div>
                        </div>
                        <div style="width: 100%; display: flex; flex-direction: row">
                            <div style="width: 0px; flex-grow: 4">加急费用</div>
                            <div style="width: 0px; flex-grow: 12"><%= (order.IsSpc)? order.SpcMoney : 0 %>元</div>
                        </div>
                        <div style="width: 100%; display: flex; flex-direction: row">
                            <div style="width: 0px; flex-grow: 4">优惠活动</div>
                            <div style="width: 0px; flex-grow: 12"><%=(policy != null )? policy.Title : "无" %></div>
                        </div>
                        <div style="width: 100%; display: flex; flex-direction: row">
                            <div style="width: 0px; flex-grow: 4">折扣金额</div>
                            <div style="width: 0px; flex-grow: 12"><%= order.OrderDisMoney %> 元</div>
                        </div>
                         <div style="width: 100%; display: flex; flex-direction: row">
                            <div style="width: 0px; flex-grow: 4">付费日期</div>
                            <div style="width: 0px; flex-grow: 12"><%=order.DatePayed.ToString("yyyy年MM月dd日 hh点mm分ss秒")%></div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</asp:Content>

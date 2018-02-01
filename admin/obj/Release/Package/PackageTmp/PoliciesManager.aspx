<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PoliciesManager.aspx.cs" Inherits="admin.PoliciesManager" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <style>
        .md_t, .md {
            align-items: center;
            height: 35px;
            background-color: #dcdcdc;
            display: flex;
        }

        .md {
            background-color: #efefef;
        }

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
        function checkForm()
        {
            if(document.getElementById("title").value == "")
            {
                alert("请填写优惠标题");
                return false;
            }
            if(document.getElementById("comment").value == "")
            {
                alert("请填写优惠备注");
                return false;
            }
            
            if (document.getElementById("disMoney").value == "" || isNaN(parseInt(document.getElementById("disMoney").value)) || parseInt(document.getElementById("disMoney").value) <= 0)
            {
                alert("客户优惠填写错误");
                return false;
            }

            if (document.getElementById("shareMoney").value == "" || isNaN(parseInt(document.getElementById("shareMoney").value)) || parseInt(document.getElementById("shareMoney").value) <= 0)
            {
                alert("推广提成填写错误");
                return false;
            }

            var startDate, endDate;
            startDate = new Date(document.getElementById("startDate").value);
            if(document.getElementById("startDate").value == "" || startDate == null)
            {
                alert("请正确填写优惠起始日期");
                return false;
            }
            
            endDate = new Date(document.getElementById("endDate").value);
            if (document.getElementById("endDate").value == "" || endDate == null)
            {
                alert("请正确填写优惠终止日期");
                return false;
            }
            
            if(startDate >= endDate)
            {
                alert("优惠的起始日期应小于终止日期");
                return false;
            }

            var selAreas = document.forms[0].areas;
            var options = selAreas.options;
            
            var anyOptionSelected = false;
            for (var i = 0; i < options.length; i++)
            {
                if(options[i].selected)
                {
                    anyOptionSelected = true;
                    break;
                }
            }

            if (anyOptionSelected == false)
            {
                alert("至少选择一个投放的州");
                return false;
            }

            var usage = 0;
            for (var i = 0; i < 4; i++)
            {
                if(document.getElementById("radio" + i).checked)
                {
                    usage = i;
                    break;
                }
            }
           
            switch(usage)
            {
                case 0:
                    if (document.getElementById("limitCountPerUser").value == "" || isNaN(parseInt(document.getElementById("limitCountPerUser").value)) || parseInt(document.getElementById("limitCountPerUser").value) <= 0)
                    {
                        alert("推广规则中，单用户使用限制必须是>1的整数");
                        return false;
                    }
                    break;

                case 1:
                    if (document.getElementById("minPrice").value == "" || isNaN(parseInt(document.getElementById("minPrice").value)) || parseInt(document.getElementById("minPrice").value) <= 0)
                    {
                        alert("推广规则中，满减的数额必须是>1的整数");
                        return false;
                    }

                    break;
            }

            document.getElementById("method").value = "newPolicy";
            return true;
        }

        function fillSelect(selOpt, areas)
        {
            var opt = document.getElementById(selOpt);

            var areaIds = areas.split(",");
            for(var i = 0; i < areaIds.length; i++)
            {
                var o = new Option(allAreas[areaIds[i]], areaIds[i]);
                opt.options.add(o);
            }
        }

        function del(policyid)
        {
            if(confirm("确定要删除该优惠策略？"))
            {
                document.getElementById("method").value = "delPolicy";
                document.forms[0].policyid.value = policyid;
                document.forms[0].submit();
            }

        }
    </script>
    <script>
        var allAreas = new Object();
        <asp:Repeater ID="areasObjectRepeater" runat="server">
<ItemTemplate>
        allAreas["<%#Eval("AreaId")%>"] = "<%#Eval("AreaName")%>";
            </ItemTemplate>
            </asp:Repeater>
    </script>


    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>优惠策略管理</h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
        <div class="box border blue">
            <div class="box-title">
                <h4><i class="fa fa-hand-o-up"></i>全部策略</h4>
            </div>
            <asp:Repeater ID="policiesRepeater" runat="server">
                <ItemTemplate>
                    <div style="width:auto;padding:20px 30px;">
                        <div class="row">
                            <div class="col-md-10 md_t"><b></b><%# Eval("Title") %></b>(<%# Eval("Comment") %>)</div>
                            <div class="col-md-2 md_t"><a href="javascript:del('<%#Eval("PolicyId") %>');">删除</a></div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 md">客户优惠:<%#Eval("DisMoney") %><%#((Modal.PolicyInfo)(Container.DataItem)).IsDisPercent? "%" : "元"%></div>
                            <div class="col-md-6 md">推广提成:<%#Eval("ShareMoney") %><%#((Modal.PolicyInfo)(Container.DataItem)).IsSharePercent? "%" : "元"%></div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 md">覆盖<%#GetAreas((System.Collections.Generic.List<int>)Eval("AreaIds")).ToString().Split(',').Length %>个州</div>
                            <div class="col-md-6 md">
                                <select id="areas_<%#Eval("PolicyId") %>"></select></div>
                            <script>fillSelect("areas_<%#Eval("PolicyId") %>", "<%#GetAreas((System.Collections.Generic.List<int>)Eval("AreaIds")).ToString()%>");</script>
                            
                        </div>
                        <div class="row">
                            <div class="col-md-6 md"><%#GetRule((Modal.PolicyInfo)Container.DataItem) %></div>
                            <div class="col-md-6 md">有效期从<%#Convert.ToDateTime(Eval("StartTime")).ToString("yyyy年MM月dd日") %>至<%#Convert.ToDateTime(Eval("EndTime")).ToString("yyyy年MM月dd日") %>(<%#(Convert.ToDateTime(Eval("EndTime")) > DateTime.Now)? "有效期内" : "已过期" %>)</div>
                            
                        </div>

                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="page_control" style="margin:30px">
            <asp:Repeater ID="pageNumRepeater" runat="server">
                <ItemTemplate>
                    <a href="<%#((admin.PageControl.PageNumber)Container.DataItem).IsCurrPage? "#none" : "PoliciesManager.aspx?pageIndex=" + Eval("PageIndex").ToString() %>" class="<%#((admin.PageControl.PageNumber)Container.DataItem).IsCurrPage? "curr_page" : "" %>"><%#Eval("PageText") %></a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <div id="authlist" class="jumbotron" style="overflow: hidden; padding: 10px;font-size:14px;margin:10px;">
            <div style="font-size:25px;margin:20px 0px;">添加新的优惠策略</div>
            
            <form method="post">
                <input type="hidden" name="method" id="method" value=""/>
                <input type="hidden" name="policyid" id="policyid" value="" />
                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                    <div style="flex-grow: 2; width: 0px;">优惠策略标题：</div>
                    <div style="flex-grow: 12; width: 0px;">
                        <input type="text" id="title" name="title" class="form-control" />
                    </div>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                    <div style="flex-grow: 2; width: 0px;">优惠策略备注：</div>
                    <div style="flex-grow: 12; width: 0px;">
                        <input type="text" id="comment" name="comment" class="form-control" />
                    </div>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                    <div style="flex-grow: 2; width: 0px;">优惠幅度：</div>
                    <div style="flex-grow: 1; width: 0px;">客户优惠:</div>
                    <div style="flex-grow: 2; width: 0px;">
                        <input type="number" id="disMoney" name="disMoney" value="1" min="1" class="form-control"/></div>
                    <div style="flex-grow: 2; width: 0px;">
                        <select id="isDisPercent" name="isDisPercent" class="form-control"  style="width:auto;margin-left:20px">
                            <option value="true">%</option>
                            <option value="false">元</option>
                        </select></div>
                    <div style="flex-grow: 1; width: 0px;">推广者提成:</div>
                    <div style="flex-grow: 2; width: 0px;">
                        <input type="number" id="shareMoney" value="1" min="1" name="shareMoney" class="form-control"/></div>
                    <div style="flex-grow: 2; width: 0px;">
                        <select id="isSharePercent" name="isSharePercent" class="form-control" style="width:auto;margin-left:20px">
                            <option value="true">%</option>
                            <option value="false">元</option>
                        </select></div>
                </div>
                

                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                    <div style="flex-grow: 2; width: 0px;">时段设置：</div>
                    <div style="flex-grow: 1; width: 0px;">开始日期:</div>
                    <div style="flex-grow: 2; width: 0px;">
                        <input type="date" id="startDate" name="startDate" value="年/月/日" class="form-control"/></div>
                    <div style="flex-grow: 2; width: 0px;"></div>
                    <div style="flex-grow: 1; width: 0px;">结束日期:</div>
                    <div style="flex-grow: 2; width: 0px;">
                        <input type="date" id="endDate"  name="endDate" class="form-control" value="年/月/日"/></div>
                    <div style="flex-grow: 2; width: 0px;"></div>
                </div>

                <div style="display: flex; flex-direction: row; width: 100%;font-size:13px;height:50px;">
                    <div style="width:0px;flex-grow:2">使用规则</div>
                    <div style="width:0px;flex-grow:1"><input id="radio0" checked="true" type="radio" name="usage" class="form-group" value="0"/></div>
                    <div style="width:0px;flex-grow:5"><label for="radio0">单用户最多使用次数</label></div>
                    <div style="width:0px;flex-grow:2"><input type="number" id="limitCountPerUser" name="limitCountPerUser" value="1"  min="1" class="form-control"/></div>
                    <div style="width:0px;flex-grow:2">次</div>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;font-size:13px;;height:50px;">
                    <div style="width:0px;flex-grow:2"></div>
                    <div style="width:0px;flex-grow:1"><input type="radio" id="radio1" name="usage" class="form-group" value="1"/></div>
                    <div style="width:0px;flex-grow:5"><label for="radio1">满金额使用</label></div>
                    <div style="width:0px;flex-grow:2"><input type="number" id="minPrice" name="minPrice" min="1" value="1" class="form-control"/></div>
                    <div style="width:0px;flex-grow:2">金额</div>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                    <div style="width:0px;flex-grow:2"></div>
                    <div  style="width:0px;flex-grow:1"><input type="radio" id="radio2" name="usage"  class="form-group" value="2"/></div>
                    <div  style="width:0px;flex-grow:9"><label for="radio2">新用户使用</label></div>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                    <div style="width:0px;flex-grow:2"></div>
                    <div  style="width:0px;flex-grow:1"><input type="radio" id="radio3" name="usage" class="form-group" value="3"/></div>
                    <div  style="width:0px;flex-grow:9"><label for="radio3">老用户使用</label></div>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;height:auto;padding:50px 0px">
                    <div style="width: 0px; flex-grow: 2">覆盖州区</div>
                    <div style="width: 0px; flex-grow: 6">
                        <select multiple class="form-control" style="height:150px" id="areas" name="areas">
                            <asp:Repeater ID="areasRepeater" runat="server">
                                <ItemTemplate>
                                    <option value="<%#Eval("AreaId") %>"><%#Eval("AreaName") %></option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </select>
                    </div>
                    <div style="width: 0px; flex-grow: 4"></div>
<%--                    <div style="width: 0px; flex-grow: 2;display:flex;flex-direction:column;justify-content:center;">
                        <input type="button" value=">>" onclick="addAreas()" class="form-control" style="margin:0px 30px 10px 30px;width:auto;"/>
                        <input type="button" value="<<" onclick="removeAreas()" class="form-control" style="margin:10px 30px 0px 30px;width:auto"/>
                    </div>
                    <div style="width: 0px; flex-grow: 4">
                        <select multiple class="form-control" style="height:120px"></select></div>--%>
                </div>
                <div style="display: flex; flex-direction: row; width: 100%;height:50px;">
                       <div style="width:0px;flex-grow:2"></div>   
                       <div style="width:0px;flex-grow:2"><input type="submit" class="btn btn-success" onclick="return checkForm();" value="创建优惠策略" /></div>   
                       <div style="width:0px;flex-grow:8"></div>
                </div>
                
            </form>
        </div>
        </div>
    </div>
</asp:Content>

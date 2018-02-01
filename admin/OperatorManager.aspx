<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OperatorManager.aspx.cs" Inherits="admin.OperatorManager" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function updateRoleOfUser(userid, roleid)
        {
            var container = document.getElementById("container_" + userid);

            var objSel = container.getElementsByTagName("select")[0];

            document.getElementById("method").value = "update_role";
            document.getElementById("userId").value = userid;
            document.getElementById("roleId").value = objSel.options[objSel.selectedIndex].value;;
            document.forms[0].submit();
        }


        function updateDepartmentOfUser(userid, departmentId)
        {
            var container = document.getElementById("departmentInfo_" + userid);

            var objSel = container.getElementsByTagName("select")[0];

            document.getElementById("method").value = "update_department";
            document.getElementById("userId").value = userid;
            //document.getElementById("departmentId").value = objSel.options[objSel.selectedIndex].value;;
            document.forms[0].submit();
        }

        function createUser()
        {
            document.getElementById("method").value = "create_user";

            if (document.getElementById("username").value == "")
            {
                alert("用户名不能为空");
                return;
            }

            if (document.getElementById("password").value == "")
            {
                alert("密码不能为空");
                return;
            }

            if (document.getElementById("mobile").value == "")
            {
                alert("手机ID不能为空");
                return;
            }
            document.forms[0].submit();
        }

        function deleteUser(userId, username)
        {
            if (confirm("确定要删除" + username + "?"))
            {
                document.getElementById("method").value = "delete_user";
                document.getElementById("userId").value = userId;
                document.forms[0].submit();
            }
        }
    </script>
    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>用户与角色管理</h2>
            </div>
        </div>
    </div>
    <!-- 表头结束-->
    <!-- 查询选项 -->
    <div class="row">
        <div class="col-sm-12">
            <asp:Repeater ID="roleRepeater" runat="server">
                <HeaderTemplate>
                    <div id="rolelist" style="display: none">
                        <select>
                </HeaderTemplate>
                <ItemTemplate>
                    <option value="<%#Eval("RoleId") %>"><%#Eval("RoleName") %></option>
                </ItemTemplate>
                <FooterTemplate>
                    </select>
                                        </div>
                </FooterTemplate>
            </asp:Repeater>

            <%--                                <asp:Repeater ID="departmentRepeater" runat="server">
                                    <HeaderTemplate>
                                        <div id="departmentlist" style="display: none">
                                            <select>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <option value="<%#Eval("DepartmentId") %>"><%#Eval("DepartmentName") %></option>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </select>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>--%>
            <script>
                function fillRoleOption(container, roleid)
                {
                    var optionHTML = document.getElementById("rolelist").innerHTML;
                    document.getElementById(container).innerHTML = optionHTML;
                    var objSel = document.getElementById(container).getElementsByTagName("select")[0];
                    var opts = objSel.options;

                    for (var i = 0; i < opts.length; i++)
                    {
                        if (opts[i].value == roleid)
                        {
                            opts[i].selected = true;
                            break;
                        }
                    }
                }

                function fillDepartmentOption(container, departmentId)
                {
                    var optionHTML = document.getElementById("departmentlist").innerHTML;
                    document.getElementById(container).innerHTML = optionHTML;
                    var objSel = document.getElementById(container).getElementsByTagName("select")[0];
                    var opts = objSel.options;

                    for (var i = 0; i < opts.length; i++)
                    {
                        if (opts[i].value == departmentId)
                        {
                            opts[i].selected = true;
                            break;
                        }
                    }
                }
            </script>
            <form name="roleForm" method="post" runat="server">
                <!--这个hidden的目的是存储post所需要调用的方法-->
                <input type="hidden" name="method" id="method" />
                <input type="hidden" name="userId" id="userId" />
                <input type="hidden" name="roleId" id="roleId" />
                <%--<input type="hidden" name="departmentId" id="departmentId" />--%>


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
                        <div class="jumbotron" style="padding: 10px">
                            <table style="font-size: 13px;">
                                <tr>
                                    <td>名字:</td>
                                    <td>
                                        <input type="text" style="width: 120px" id="username" name="username" class="form-control" /></td>
                                    <td>手机:</td>
                                    <td>
                                        <input type="text" style="width: 120px" id="mobile" name="mobile" class="form-control" /></td>
                                    <td>密码:</td>
                                    <td>
                                        <input type="password" style="width: 120px" id="password" name="password" class="form-control" /></td>
                                    <td>所属角色:</td>
                                    <td>
                                        <asp:Repeater ID="roleRepeater2" runat="server">
                                            <HeaderTemplate>
                                                <select class="form-control" id="newRoleOfUser" name="newRoleOfUser">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <option value="<%#Eval("RoleId") %>"><%#Eval("RoleName") %></option>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </select>                                     
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                                    <%--                                                       <td>所属部门:</td>--%>
                                    <%--                                                        <td>
                                                            <asp:Repeater ID="departmentRepeater2" runat="server">
                                                                <HeaderTemplate>
                                                                    <select class="form-control" id="newDepartmentOfUser" name="newDepartmentOfUser">
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <option value="<%#Eval("DepartmentId") %>"><%#Eval("DepartmentName") %></option>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    </select>                                     
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </td>--%>
                                    <td><a href="javascript:{createUser();}" class="btn btn-success">添加用户</a></td>
                                </tr>
                            </table>
                        </div>
                        <!-- 添加新用户结束 -->

                        <!-- 内部的用户列表-->
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>用户</th>
                                    <th>手机ID</th>
                                    <th>创建时间</th>
                                    <th>登录时间</th>
                                    <th>角色组</th>
                                    <%--                                                        <th>所属部门</th>--%>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="usersRepeater" runat="server">
                                    <ItemTemplate>
                                        <tr style="vertical-align: middle">
                                            <td><%#Eval("OperatorId") %></td>
                                            <td><%#Eval("Name") %></td>
                                            <td><%#Eval("Mobile") %></td>
                                            <td><%#Eval("CreateDate") %></td>
                                            <td><%#Eval("LastLoginDate") %></td>
                                            <td>
                                                <div id="container_<%#Eval("OperatorId") %>" style="float: left"></div>
                                                <script>fillRoleOption('container_<%#Eval("OperatorId") %>', '<%#Eval("RoleId") %>');</script>
                                                <a class="btn btn-xs btn-success" style="float: left; margin-left: 10px" href="javascript:{updateRoleOfUser('<%#Eval("OperatorId") %>', '<%#Eval("RoleId") %>');}">修改</a>

                                            </td>
                                            <%--                                                                <td>
                                                                    <div id="departmentInfo_<%#Eval("UserId") %>" style="float: left"></div>
                                                                    <script>fillDepartmentOption('departmentInfo_<%#Eval("UserId") %>', '<%#Eval("DepartmentId") %>');</script>
                                                                    <a class="btn btn-xs btn-success" style="float: left; margin-left: 10px" href="javascript:{updateDepartmentOfUser('<%#Eval("UserId") %>', '<%#Eval("DepartmentId") %>');}">修改</a>

                                                                </td>--%>
                                            <td><a href="javascript:{deleteUser('<%#Eval("OperatorId") %>', '<%#Eval("Name") %>');}" class="btn btn-xs btn-danger">删除</a></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <!-- 内部的用户列表结束-->

                    </div>
                    <!-- box body 结束 -->

                </div>
                <!-- end box -->
            </form>

        </div>
    </div>
</asp:Content>


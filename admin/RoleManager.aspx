<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RoleManager.aspx.cs" Inherits="admin.RoleManager" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        //更换角色的select时候，更新checkbox list的勾选
        function showAuth(e)
        {
            var authValue = parseInt(e.options[e.selectedIndex].id);

            var list = document.getElementById("authlist").getElementsByTagName("input");

            for (var i = 0; i < list.length; i++)
            {
                if ((authValue & parseInt(list[i].value)) > 0)
                {
                    list[i].checked = true;
                }
                else
                {
                    list[i].checked = false;
                }
            }
        }


        //更新权限
        function updateAuth()
        {
            var rolelist = document.getElementById("rolelist");

            if (rolelist.selectedIndex == -1)
            {
                alert("请选择一个角色");
                return;
            }

            var newAuthValue = 0;
            var list = document.getElementById("authlist").getElementsByTagName("input");

            for (var i = 0; i < list.length; i++)
            {
                if (list[i].checked)
                    newAuthValue += parseInt(list[i].value);
            }

            document.getElementById("method").value = "update";
            document.getElementById("authValue").value = newAuthValue;
            document.forms[0].submit();
        }


        //删除某个角色
        function deleteRole()
        {
            var rolelist = document.getElementById("rolelist");

            if (rolelist.selectedIndex == -1)
            {
                alert("请选择一个角色");
                return;
            }

            if (confirm("确定要删除角色[" + rolelist.options[rolelist.selectedIndex].text + "]？") == false)
                return;

            var id = rolelist.options[rolelist.selectedIndex].value;

            document.getElementById("method").value = "delete";
            document.forms[0].submit();
        }

        function createRole()
        {
            var roleName = document.getElementById("roleName").value;
            if (roleName == null || roleName == "")
            {
                alert("请输入角色名字");
                return;
            }

            if (roleName.indexOf(" ") != -1)
            {
                alert("角色名字包含非法字符");
                return;
            }

            document.getElementById("method").value = "create";
            document.forms[0].submit();
        }

    </script>
    <div class="row" style="height: 30px">
        <div class="col-sm-12">
            <div class="page-header" style="border: 0px solid red; line-height: 30px; height: 30px; padding-bottom: 0px">
                <h2>角色与权限管理</h2>
            </div>
        </div>
    </div>
    <!-- 表头结束-->
    <!-- 查询选项 -->
    <div class="row">
        <div class="col-sm-12">

            <form name="roleForm" method="post" runat="server">
                <input type="hidden" name="method" id="method" />
                <input type="hidden" name="authValue" id="authValue" value="0" />
                <div class="box border blue">
                    <div class="box-title">
                        <h4><i class="fa fa-hand-o-up"></i>全部角色</h4>

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
                        <p>角色组列表</p>
                        <select id="rolelist" name="rolelist" multiple onchange="showAuth(this)" class="form-control" style="height: 150px;">
                            <asp:Repeater ID="rolesRepeater" runat="server">
                                <ItemTemplate>
                                    <option style="font-size: 16px" value="<%#Eval("RoleId") %>" id="<%#Eval("AuthValue") %>"><%#Eval("RoleName") %></option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </select>
                        <br />
                        <div id="authlist" class="jumbotron" style="overflow: hidden; padding: 10px;">
                            <asp:Repeater ID="authRepeater" runat="server">
                                <ItemTemplate>
                                    <div style="display: block; margin: 0px 10px; float: left;">
                                        <input id="auth_<%#Eval("AuthorityId") %>" onclick="javascript: { return document.getElementById('rolelist').selectedIndex != -1; }" type="checkbox" value="<%#Eval("AuthorityId") %>" /><label style="font-size: 15px; font-weight: normal" for="auth_<%#Eval("AuthorityId") %>"><%#Eval("AuthorityName") %></label>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <p>
                            <button class="btn btn-success" onclick="javascript:{updateAuth();return false;}">重置权限</button>
                            <button class="btn btn-danger" onclick="javascript:{deleteRole();return false;}">删除角色</button>
                        </p>

                    </div>
                </div>
                <div id="authlist" class="jumbotron" style="overflow: hidden; padding: 10px;">
                    <p>创建新的角色</p>
                    <input type="text" id="roleName" name="roleName" class="form-control" />
                    <button class="btn btn-success" onclick="javascript:{createRole();return false;}">增加角色</button>
                </div>
                <!-- end box -->

                <script language="javascript">

                    var roleId = "<%=Convert.ToString(Request.QueryString["roleId"]) %>";
                    var ops = document.getElementById("rolelist").options;

                    for (var i = 0; i < ops.length; i++)
                    {
                        if (ops[i].value == roleId)
                        {
                            ops[i].selected = true;
                        }
                    }
                    showAuth(document.getElementById("rolelist"));
                </script>
            </form>

        </div>
    </div>
</asp:Content>
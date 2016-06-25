<!-- Content Wrapper. Contains page content -->
<%@ page import="CarSale.SystemRole" %>
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            系统权限管理
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="systemRoleRight" action="index">系统权限管理</g:link></li>
            <li class="active">权限管理</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <form id="searchForm" method="get" action="/work/systemRoleRight/index.do" class="form-inline">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row">

                                <div class="col-md-3">
                                    <label for="systemRoleId">角色名</label>
                                    <g:select id="systemRoleId" name='systemRoleId'
                                              value="${params?.id}"
                                              noSelection="${['': '请选择...']}"
                                              from='${CarSale.SystemRole.list()}'
                                              optionKey="id" optionValue="roleName"></g:select>
                                </div>


                                <div class="col-md-1">
                                    <button type="button" class="btn btn-default"
                                            onclick="showSystemRoleRight();"><i class="fa fa-search"></i> 查看</button>
                                </div>
                                <div class="col-md-1 col-md-offset-1">
                                    <g:link class="btn btn-link" controller="systemRole" action="index">角色管理&nbsp<i class="fa fa-hand-o-right"></i> </g:link>
                                </div>

                            </div>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-body no-padding" id="roleRightDetail">
                            %{--<g:render template="form"/>--}%
                            <h6 class="col-md-offset-1">请先选择角色...</h6>
                        </div>

                        <div class="box-footer">
                            <div class="row">
                                <div class="col-md-1 col-md-offset-9">
                                    <button id="editButton" type="button"
                                            class="btn btn-sm btn-primary" onclick="editSystemRoleRight();">
                                        <i class="fa fa-edit"></i> 编辑
                                    </button>
                                </div>

                                <div class="col-md-1">
                                    <button id="saveButton" type="button"
                                            class="btn btn-sm btn-primary" onclick="saveSystemRoleRight();">
                                        <i class="fa fa-save"></i> 保存
                                    </button>
                                </div>

                                <div class="col-md-1">
                                    <button id="cancelButton" type="button"
                                            class="btn btn-sm btn-primary" onclick="showSystemRoleRight()">
                                        <i class="fa fa-save"></i> 取消
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div><!-- /.box -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </form>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->


<!-- REQUIRED JS SCRIPTS -->

<!-- page script -->
<script>
    function showSystemRoleRight() {
        var id = $("#systemRoleId").val();
        $.post("/systemRoleRight/show", {id: id}, function (bdata) {
            $("#roleRightDetail").html(bdata);
        }, "html");
    }

    function editSystemRoleRight() {
        var id = $("#systemRoleId").val();
        $.post("/systemRoleRight/edit", {id:id}, function (bdata) {
            $("#roleRightDetail").html(bdata);
//            $("#editButton").attr("disabled",true);
        });
    }

    function saveSystemRoleRight() {
        var data = {};
        data['systemRoleId'] = $("#systemRoleId").val();
        var i = 0;
        $("li.list-group-item").each(function () {
            if ($(this).find("input[name='menuName']:checked").size() > 0) {
                data['menuList[' + i + '].menuId'] = $(this).find("input[name='menuId']").val();
                i++;
            }
        });

        data['length'] = i;

        $.post("/systemRoleRight/save", data, function (bdata) {
            if (bdata.status != "success") {
                bootbox.alert(bdata.message);
            } else {
                bootbox.alert("保存成功");
                showSystemRoleRight();
            }
        }, "json");
    }


</script>
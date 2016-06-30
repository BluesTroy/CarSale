<%--
  Created by IntelliJ IDEA.
  User: Troy
  Date: 2016/6/11
  Time: 12:47
--%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            员工角色维护
            <small>员工角色基本信息</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="systemStaffRole" action="index" >员工角色维护</g:link></li>
            <li class="active">员工角色基本信息</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <form id="searchForm" method="get" action="/systemStaffRole/index" class="form-inline">
            <g:hiddenField name="order" value="${params?.order}"/>
            <g:hiddenField name="sort" value="${params?.sort}"/>
            <g:hiddenField id="offset" name="offset" value="${params?.offset}"/>
            <g:hiddenField name="max" value="${params?.max}"/>
            <div class="box">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="staffCode">员工编号</label>
                                <input type="text" id="staffCode" name="staffCode"
                                       class="form-control input-md pull-right" style="width: 150px;"
                                       placeholder="模糊查询" value="${params?.staffCode}"/>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="realName">姓名</label>
                                <input type="text" id="realName" name="realName"
                                       class="form-control input-md pull-right" style="width: 150px;"
                                       placeholder="模糊查询" value="${params?.realName}"/>
                            </div>
                        </div>

                        <div class="col-md-1">
                            <button type="button" class="btn btn-default"
                                    onclick="javascript:searchPage();"><i class="fa fa-search"></i> 查询</button>
                        </div>

                        <div class="col-md-1">
                            <button type="button" class="btn btn-primary"
                                    onclick="javascript:resetPage();">重置</button>
                        </div>

                    </div>
                </div><!-- /.box-body -->
            </div><!-- /.box -->

            <div class="row">
                <div class="col-md-12" id="listBoxDiv">
                    <g:render template="table_list"/>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </form>

        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title"><i class="fa fa-info-circle"></i> 员工角色详情</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body" id="domainModalBody">
                        ...
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<!-- REQUIRED JS SCRIPTS -->

<!-- page script -->
<script>
    $(document).ready(function () {
        fixPaginationA();
    });

    function resetPage() {
        $("#searchForm")[0].reset();
        loadPage();
    }

    function searchPage(){
        $("#offset").val('0');
        loadPage();
    }

    function loadPage() {
        $.post("/systemStaffRole/loadPage", $("#searchForm").serializeArray(), function (bdata) {
            $("#listBoxDiv").html(bdata);
            fixPaginationA();
        }, "html").done();
    }

    function showStaffRole(id) {
        $.post("/systemStaffRole/edit", {id: id}, function (bdata) {
            $("#domainModalBody").html(bdata);
        }, "html");
    }



    function delSystemStaffRole() {
        var data={};
        var staffInfoId = $("#staffInfoId").val();
        var userName = $("#staffCode").text();
        var roleName = $("#delSystemRoleId option:selected").text();
        data['staffInfoId'] = $("#staffInfoId").val();
        data['systemRoleId'] = $("#delSystemRoleId").val();

        bootbox.confirm("您要删除 " + userName + " 用户的 "+roleName+" 角色吗？", function (isOk) {
            if (isOk) {
                $.post("/systemStaffRole/delete.do", data, function (data) {
                    if (data.status != "success") {
                        bootbox.alert(data.message, function () {

                        });
                    } else {
                        bootbox.alert("删除成功");
                        showStaffRole(staffInfoId);
                    }
                }, "json");
            }
        });
    }

    function saveSystemStaffRole() {
        var data={};
        var staffInfoId = $("#staffInfoId").val();
        data['staffInfoId'] = $("#staffInfoId").val();
        data['systemRoleId'] = $("#addSystemRoleId").val();

        $.post("/systemStaffRole/save", data, function (bdata) {
            if (bdata.status != "success") {
                bootbox.alert(bdata.message);
            } else {
                bootbox.alert("保存成功");
                showStaffRole(staffInfoId);
            }
        }, "json");


    }

    function setSort(name, dispayName) {
        $("#sort").val(name);
        if ($("#order").val() == "asc") {
            $("#order").val("desc");
        } else {
            $("#order").val("asc");
        }
        loadPage();
    }




</script>

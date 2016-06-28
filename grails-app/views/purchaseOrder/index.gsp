<%@ page import="CarSale.Warehouse" %>
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
                进货订单管理
            <small>进货订单基本信息</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="purchaseOrder" action="index" >进货订单管理</g:link></li>
            <li class="active">进货订单基本信息</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <form id="searchForm" method="get" action="/purchaseOrder/index" class="form-inline">
            <g:hiddenField name="order" value="${params?.order}"/>
            <g:hiddenField name="sort" value="${params?.sort}"/>
            <g:hiddenField id="offset" name="offset" value="${params?.offset}"/>
            <g:hiddenField name="max" value="${params?.max}"/>
            <div class="box">
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="orderCode">订单编号</label>
                                <input type="text" id="orderCode" name="orderCode"
                                       class="form-control input-md pull-right" style="width: 150px;"
                                       placeholder="模糊查询" value="${params?.orderCode}"/>
                            </div>
                        </div>


                        <div class="col-md-1">
                            <button type="button" class="btn btn-default"
                                    onclick="javascript:searchPage();"><i class="fa fa-search"></i> 查询</button>
                        </div>

                        <div class="col-md-1">
                            <button type="button" class="btn btn-danger"
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
                        <h3 class="box-title"><i class="fa fa-info-circle"></i> 进货订单详情</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body" id="domainModalBody">
                        ...
                    </div><!-- /.box-body -->
                    <div class="box-footer">
                        <div class="row">
                            <div class="col-md-2 col-md-offset-2">
                                <button class="btn btn-block btn-primary" onclick="createSupplier();">
                                    <i class="fa fa-plus"></i> 添加进货订单
                                </button>
                            </div>

                            <div class="col-md-2">
                                <button id="editButton" type="button" disabled="disabled"
                                        class="btn btn-block btn-primary" onclick="editSupplier();">
                                    <i class="fa fa-edit"></i> 编辑
                                </button>
                            </div>

                            <div class="col-md-2">
                                <button id="saveButton" type="button" disabled="disabled"
                                        class="btn btn-block btn-primary" onclick="saveSupplier();">
                                    <i class="fa fa-save"></i> 保存
                                </button>
                            </div>

                            <div class="col-md-2">
                                <button id="delButton" type="button" disabled="disabled"
                                        class="btn btn-block btn-primary" onclick="deleteSupplier();">
                                    <i class="fa fa-trash"></i> 删除
                                </button>
                            </div>
                        </div>
                    </div>
                </div><!-- /.box -->
            </div>
        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<!-- REQUIRED JS SCRIPTS -->

<div class="modal fade" id="saveInWarehouseModal" tabindex="-1" role="dialog" aria-labelledby="codeRangeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">保存到仓库</h4>
            </div>

            <div class="modal-body">
                <form id="saveInWarehouseForm" url="[controller: 'purchaseOrder', action: 'saveInWarehouse']">
                    <input type="hidden" name="purchaseOrderId" id="purchaseOrderId" value=""/>

                    <div class="row">
                        <div class="col-md-2">
                            <label for="warehouse">选择仓库</label>
                        </div>
                        <div class="col-md-6">
                            <g:select class="form-control" from="${CarSale.Warehouse.list()}" name="warehouse" optionKey="id" optionValue="warehouseName"
                                noSelection="['':'请选择...']" />
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="javascript:saveInfWarehouse();">保存</button>
            </div>
        </div>
    </div>
</div>

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
        $.post("/purchaseOrder/loadPage", $("#searchForm").serializeArray(), function (bdata) {
            $("#listBoxDiv").html(bdata);
            fixPaginationA();
        }, "html").done();
    }

    function showPurchaseOrder(id) {
        $.post("/purchaseOrder/edit", {id: id}, function (bdata) {
            $("#domainModalBody").html(bdata);
            // 所有输入表单控件只读显示
            $("#purchaseOrderForm input:not(:button,:hidden)").prop("readonly", true);
            $("#purchaseOrderForm select").prop("disabled", true);
            $("#delButton").attr("disabled", false);
            $("#editButton").attr("disabled", false);
        }, "html");
    }


    //////////////////////////////////
    function createSupplier() {
        $.post("/purchaseOrder/create", null, function (bdata) {
            $("#domainModalBody").html(bdata);
            $("#saveButton").attr("disabled", false);
        }, "html");
    }

    function editSupplier() {
        $("#purchaseOrderForm input:not(:button,:hidden)").prop("readonly", false);
        $("#purchaseOrderForm select").prop("disabled", false);
        $("#delButton").attr("disabled", false);
        $("#saveButton").attr("disabled", false);
    }

    function startSaveInWarehouse(id){
        $("#saveInWarehouseModal").modal("show");
        $("#purchaseOrderId").val(id);
    }
    function saveInfWarehouse(){
        $.post("/purchaseOrder/saveInWarehouse", $("#saveInWarehouseForm").serializeArray(), function (bdata) {
            $("#saveInWarehouseModal").modal("hide");
            if (bdata.status != "success") {
                bootbox.alert(bdata.message);
            } else {
                bootbox.alert("入库成功");
                loadPage();
                $("#domainModalBody").html("...");
                $("#delButton").attr("disabled", true);
                $("#saveButton").attr("disabled", true);
                $("#editButton").attr("disabled", true);
            }
        }, "json");
    }


    function deleteSupplier(){
        delSupplier($("#id").val());
    }

    function delSupplier(id) {
        var orderCode = $("#td_orderCode_" + id).html();

        bootbox.confirm("您要删除的是 " + orderCode + " 吗？", function (isOk) {
            if (isOk) {
                bootbox.confirm("确认删除吗？", function (isOk) {
                    if (isOk) {
                        $.post("/purchaseOrder/delete", {id: id}, function (bdata) {
                            if (bdata.status != "success") {
                                bootbox.alert(bdata.message, function () {

                                });
                            } else {
                                $("#offset").val('0');
                                loadPage();
                                if ($("#id") != null && $("#id").val() == id) {
                                    $("#domainModalBody").html("...");
                                    $("#delButton").attr("disabled", true);
                                    $("#saveButton").attr("disabled", true);
                                    $("#editButton").attr("disabled", true);
                                }
                            }
                        }, "json");
                    }
                });
            }
        });
    }

    function saveSupplier() {
        $.post("/purchaseOrder/save", $("#purchaseOrderForm").serializeArray(), function (bdata) {
            if (bdata.status != "success") {
                bootbox.alert(bdata.message);
            } else {
                bootbox.alert("保存成功");
                loadPage();
                $("#domainModalBody").html("...");
                $("#delButton").attr("disabled", true);
                $("#saveButton").attr("disabled", true);
                $("#editButton").attr("disabled", true);
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

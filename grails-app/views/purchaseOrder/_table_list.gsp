<%@ page import="java.text.DecimalFormat" %>
<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="purchaseOrderTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th class="cursorPointer" onclick="javascript:setSort('orderCode');">
                    <g:if test="${params?.sort == 'orderCode'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>订单编号</th>
                <th>汽车品牌</th>
                <th class="cursorPointer" onclick="javascript:setSort('singlePrice');">
                    <g:if test="${params?.sort == 'singlePrice'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>进货单价（万）</th>
                <th class="cursorPointer" onclick="javascript:setSort('carNumber');">
                    <g:if test="${params?.sort == 'carNumber'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>汽车数量</th>
                <th class="cursorPointer" onclick="javascript:setSort('totalPrice');">
                    <g:if test="${params?.sort == 'totalPrice'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>进货总价（万）</th>
                <th class="cursorPointer" onclick="javascript:setSort('orderTime');">
                    <g:if test="${params?.sort == 'orderTime'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>订单时间</th>
                <th class="cursorPointer" onclick="javascript:setSort('supplier');">
                    <g:if test="${params?.sort == 'supplier'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>供应商</th>
                <th class="cursorPointer" onclick="javascript:setSort('storageStatus');">
                    <g:if test="${params?.sort == 'storageStatus'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>入库状态</th>
                <th class="cursorPointer" onclick="javascript:setSort('dateCreated');">
                    <g:if test="${params?.sort == 'dateCreated'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <%
                def df = new DecimalFormat("0.00")
            %>
            <tbody id="domainTableTbody">
            <g:each in="${purchaseOrderList}">
                <tr id="tr_${it.id}" onclick="showPurchaseOrder('${it.id}')" class="cursorPointer">
                    <td id="td_orderCode_${it.id}">${it.orderCode}</td>
                    <td>${it.carInfo.carBrand}</td>
                    <td>${df.format(it.singlePrice)}</td>
                    <td>${it.carNumber}</td>
                    <td>${df.format(it.totalPrice)}</td>
                    <td><g:formatDate date="${it.orderTime}" formatName="default.date.format.date" /></td>
                    <td>${it.supplier.supplierName}</td>
                    <td><g:if test="${it.storageStatus}">已入库</g:if><g:else>未入库</g:else></td>
                    <td id="td_dateCreated_${it.id}"><g:formatDate date="${it.dateCreated}" formatName="default.date.format.datetime"/> </td>
                    <td id="td_operate_${it.id}" width="80px">
                        <g:if test="${it.storageStatus!=true}">
                        <button class="btn btn-default btn-xs" type="button"
                                onclick="startSaveInWarehouse('${it.id}')">入库</button>
                        </g:if>
                        <g:else>
                            <span>入库完成</span>
                        </g:else>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div><!-- /.box-body -->
    <div class="box-footer">
        <div class="row">
            <div class="col-md-3 pull-left paginatation-total">
                共有 <span id="domainTotalCount">${total}</span> 条记录
            </div>

            <div class="col-md-9">
                <div class="pagination pull-right">
                    <g:paginate controller="purchaseOrder" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

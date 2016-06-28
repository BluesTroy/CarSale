<%@ page import="java.text.DecimalFormat" %>
<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="orderInfoTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th>订单编号</th>
                <th>下单时间</th>
                <th>出库时间</th>
                <th>销售总数</th>
                <th>总价格（万元）</th>
                <th>销售员</th>
                <th>客户</th>
                <th>操作</th>
            </tr>
            </thead>
            <%
                def df = new java.text.DecimalFormat("0.00")
            %>
            <tbody id="domainTableTbody">
            <g:each in="${orderInfoList}">
                <tr id="tr_${it.id}" onclick="showOrderInfo('${it.id}')" class="cursorPointer">
                    <td id="td_orderCode_${it.id}">${it.orderCode}</td>
                    <td><g:formatDate date="${it.orderTime}" formatName="default.date.format.date"/></td>
                    <td><g:formatDate date="${it.outTime}" formatName="default.date.format.date"/></td>
                    <td>${it.saleNumber}</td>
                    <td>${it.totalPrice? df.format(it.totalPrice): ''}</td>
                    <td>${it.salesman?.realName}</td>
                    <td>${it.customer?.name}</td>
                    <td id="td_operate_${it.id}" width="100px">
                        <g:if test="${it?.orderDetails != null}">
                            <g:if test="${it?.outTime != null}">
                                已出库
                            </g:if>
                            <g:else>
                                <button class="btn btn-default btn-xs" type="button"
                                        onclick="outWarehouse('${it.id}')">出库</button>
                            </g:else>
                        </g:if>

                        <g:else>
                            无
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
                    <g:paginate controller="orderInfo" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

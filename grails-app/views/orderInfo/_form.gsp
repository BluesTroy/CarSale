<%@ page import="CarSale.Customer; CarSale.Salesman" %>
<div class="container-fluid">
    <g:form name="orderInfoForm" url="[controller: 'orderInfo', action: 'save']" useToken="true">
        <g:hiddenField name="id" value="${orderInfo?.id}"/>
        <g:hiddenField id="domainAction" name="domainAction" value="${action}"/>

    %{--<g:domainError model="${systemRole}"/>--}%
        <div class="row">
            <g:if test="${action == 'edit'}">
                <div class="form-group col-md-3">
                    <label for="orderCode">订单编号</label>
                    <span id="orderCode">${orderInfo?.orderCode}</span>
                </div>
            </g:if>
            <div class="form-group col-md-3">
                <label for="salesman">销售员</label>
                <g:select id="salesman" name="salesman" class="form-control" from="${CarSale.Salesman.list()}"
                          noSelection="['': '请选择...']" optionKey="id" optionValue="realName" value="${orderInfo?.salesman?.id}"/>
            </div>

            <div class="form-group col-md-3">
                <label for="customer">客户</label>
                <g:select id="customer" name="customer" class="form-control" from="${CarSale.Customer.list()}"
                          noSelection="['': '请选择...']" optionKey="id" optionValue="name" value="${orderInfo?.customer?.id}"/>
            </div>
            <div class="form-group col-md-3">
                <label for="saleNumber">销售总数</label>
                <input id="saleNumber" class="form-control" type="text" placeholder="必填项"
                       name="saleNumber" value="${orderInfo?.saleNumber}">
            </div>
            <div class="form-group col-md-3">
                <label for="orderTime">下单时间</label>
                <g:datePicker id="orderTime" name="orderTime" class="form-control" value="${orderInfo.orderTime}"
                              precision="day"/>
            </div>



        </div>
    </g:form>
    <g:if test="${action != 'create'}">
        <div id="orderDetailContainer">
            <g:render template="orderDetail_list"/>
        </div>
    </g:if>
</div>
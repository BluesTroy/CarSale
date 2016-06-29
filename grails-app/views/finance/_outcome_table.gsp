<%@ page import="java.text.SimpleDateFormat; java.text.DecimalFormat" %>
<div class="row">
    <div class="col-md-10 col-md-offset-1">
        <table class="table table-striped text-center"
               style="border: 1px solid #888888;background: #FFFFFF;width: 80%;">
            <caption class="text-center">支出汇总表</caption>
            <thead>
            <tr>
                <td >日期</td>
                <td>进货订单数</td>
                <td >订单支出(万元)</td>
            </tr>
            </thead>
            <tbody>
            <% DecimalFormat df = new java.text.DecimalFormat("0.00");
            %>
            <g:each in="${outcomeList}">
                <tr>
                    <td>${it.startTime}</td>
                    <td>${it.orderNumber}</td>
                    <td>${df.format(it.totalPrice)}</td>
                </tr>
            </g:each>
            <tr>
                <td><strong>总计</strong></td>
                <td><strong>${allOrderNumber}</strong></td>
                <td><strong>${df.format(allTotalPrice)}</strong></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>


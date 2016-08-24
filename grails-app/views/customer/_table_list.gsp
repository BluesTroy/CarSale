<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="customerTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th class="cursorPointer" onclick="javascript:setSort('name');">
                    <g:if test="${params?.sort == 'name'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>姓名</th>
                <th class="cursorPointer" onclick="javascript:setSort('sex');">
                    <g:if test="${params?.sort == 'sex'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>性别</th>
                <th class="cursorPointer" onclick="javascript:setSort('telephone');">
                    <g:if test="${params?.sort == 'telephone'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>手机</th>
                <th class="cursorPointer" onclick="javascript:setSort('email');">
                    <g:if test="${params?.sort == 'email'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>邮箱</th>
                <th class="cursorPointer" onclick="javascript:setSort('isMember');">
                    <g:if test="${params?.sort == 'isMember'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>会员？</th>
                <th class="cursorPointer" onclick="javascript:setSort('dateCreated');">
                    <g:if test="${params?.sort == 'dateCreated'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="domainTableTbody">
            <g:each in="${customerList}">
                <tr id="tr_${it.id}" onclick="showCustomer('${it.id}')" class="cursorPointer">
                    <td id="td_name_${it.id}">${it.name}</td>
                    <td><g:if test="${it.sex}">男</g:if><g:else>女</g:else></td>
                    <td>${it.telephone}</td>
                    <td>${it.email}</td>
                    <td><g:if test="${it.isMember}">是</g:if><g:else>否</g:else></td>
                    <td id="td_dateCreated_${it.id}">${it.dateCreated}</td>
                    <td id="td_operate_${it.id}" width="100px">
                        <button class="btn btn-default btn-xs" type="button"
                                onclick="delCustomer('${it.id}')">删除</button>
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
                    <g:paginate controller="customer" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

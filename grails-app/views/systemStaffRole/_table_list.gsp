<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="staffInfoTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th class="cursorPointer" onclick="javascript:setSort('staffCode');">
                    <g:if test="${params?.sort == 'staffCode'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>工号</th>
                <th class="cursorPointer" onclick="javascript:setSort('realName');">
                    <g:if test="${params?.sort == 'realName'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>姓名</th>
                <th class="cursorPointer" onclick="javascript:setSort('telephone');">
                    <g:if test="${params?.sort == 'telephone'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>手机</th>
                <th class="cursorPointer" onclick="javascript:setSort('phone');">
                    <g:if test="${params?.sort == 'phone'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>工作电话</th>
                <th class="cursorPointer" onclick="javascript:setSort('email');">
                    <g:if test="${params?.sort == 'email'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>工作邮箱</th>
                <th class="cursorPointer" onclick="javascript:setSort('dateCreated');">
                    <g:if test="${params?.sort == 'dateCreated'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>创建时间</th>
            </tr>
            </thead>
            <tbody id="domainTableTbody">
            <g:each in="${staffInfoList}">
                <tr id="tr_${it.id}" onclick="showStaffRole('${it.id}')" class="cursorPointer">
                    <td id="td_staffCode_${it.id}">${it.staffCode}</td>
                    <td>${it.realName}</td>
                    <td>${it.telephone}</td>
                    <td>${it.phone}</td>
                    <td>${it.email}</td>
                    <td id="td_dateCreated_${it.id}">${it.dateCreated}</td>
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
                    <g:paginate controller="systemStaffRole" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

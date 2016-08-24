<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="systemRoleTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th class="cursorPointer" onclick="javascript:setSort('roleName');">
                    <g:if test="${params?.sort == 'roleName'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>角色名</th>
                <th class="cursorPointer" onclick="javascript:setSort('description');">
                    <g:if test="${params?.sort == 'description'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>角色描述</th>
                %{--<th class="cursorPointer" onclick="javascript:setSort('salesman');">
                    <g:if test="${params?.sort == 'salesman'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>对应用户</th>--}%
                <th class="cursorPointer" onclick="javascript:setSort('dateCreated');">
                    <g:if test="${params?.sort == 'dateCreated'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="domainTableTbody">
            <g:each in="${systemRoleList}">
                <tr id="tr_${it.id}" onclick="showSystemRole('${it.id}')" class="cursorPointer">
                    <td id="td_roleName_${it.id}">${it.roleName}</td>
                    <td>${it.description}</td>
                    %{--<td></td>--}%
                    <td id="td_dateCreated_${it.id}">${it.dateCreated}</td>
                    <td id="td_operate_${it.id}" width="100px">
                        <button class="btn btn-default btn-xs" type="button"
                                onclick="delSystemRole('${it.id}')">删除</button>
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
                    <g:paginate controller="systemRole" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

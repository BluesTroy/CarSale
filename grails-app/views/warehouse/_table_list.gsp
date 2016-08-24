<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="warehouseTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th class="cursorPointer" onclick="javascript:setSort('warehouseCode');">
                    <g:if test="${params?.sort == 'warehouseCode'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>仓库编码</th>
                <th class="cursorPointer" onclick="javascript:setSort('warehouseName');">
                    <g:if test="${params?.sort == 'warehouseName'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>仓库名</th>
                <th class="cursorPointer" onclick="javascript:setSort('warehouseAddress');">
                    <g:if test="${params?.sort == 'warehouseAddress'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>仓库地址</th>
                <th class="cursorPointer" onclick="javascript:setSort('maxInventory');">
                    <g:if test="${params?.sort == 'maxInventory'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>最大库存</th>
                <th class="cursorPointer" onclick="javascript:setSort('nowInventory');">
                    <g:if test="${params?.sort == 'nowInventory'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>现存量</th>
                <th class="cursorPointer" onclick="javascript:setSort('dateCreated');">
                    <g:if test="${params?.sort == 'dateCreated'}"><i
                            class="fa fa-sort-amount-${params.order}"></i></g:if>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="domainTableTbody">
            <g:each in="${warehouseList}">
                <tr id="tr_${it.id}" onclick="showWarehouse('${it.id}')" class="cursorPointer">
                    <td id="td_warehouseCode_${it.id}">${it.warehouseCode}</td>
                    <td id="td_warehouseName_${it.id}">${it.warehouseName}</td>
                    <td id="td_warehouseAddress_${it.id}">${it.warehouseAddress}</td>
                    <td id="td_maxInventory_${it.id}">${it.maxInventory}</td>
                    <td id="td_nowInventory_${it.id}">${it.nowInventory}</td>
                    <td id="td_dateCreated_${it.id}">${it.dateCreated}</td>
                    <td id="td_operate_${it.id}" width="100px">
                        <button class="btn btn-default btn-xs" type="button"
                                onclick="delWarehouse('${it.id}')">删除</button>
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
                    <g:paginate controller="warehouse" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

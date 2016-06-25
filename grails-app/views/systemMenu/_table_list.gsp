<%@ page import="CarSale.SystemMenu" %>
<div class="box box-primary">
    <div class="box-body table-responsive no-padding">
        <table id="systemMenuTable" class="table table-hover table-bordered table-striped table-condensed">
            <thead>
            <tr>
                <th>菜单名</th>
                <th>菜单级别</th>
                <th>父菜单</th>
                <th>排序值</th>
                <th>菜单图标</th>
                <th>菜单地址</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="domainTableTbody">
            <g:each in="${systemMenuList}">
                <tr id="tr_${it.id}" onclick="showSystemMenu('${it.id}')" class="cursorPointer">
                    <td id="td_menuName_${it.id}">${it.menuName}</td>

                    <g:if test="${it.parentMenu == null || it.parentMenu == ''}">
                        <td>一级菜单</td>
                        <td>无</td>
                    </g:if>
                    <g:else>
                        <td>二级菜单</td>
                        <td>${CarSale.SystemMenu.get(it?.parentMenu)?.menuName}</td>
                    </g:else>

                    <td>${it.menuSort}</td>
                    <td>${it.menuIcon}</td>
                    <td>${it.menuUrl}</td>
                    <td id="td_operate_${it.id}" width="100px">
                        <button class="btn btn-default btn-xs" type="button"
                                onclick="delSystemMenu('${it.id}')">删除</button>
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
                    <g:paginate controller="systemMenu" action="index" total="${total}"
                                params='[order: "desc", sort: "dateCreated"]'/>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.box -->

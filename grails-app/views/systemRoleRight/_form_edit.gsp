<div class="container-fluid">
    <ul class="list-group">
        <g:each var="menuItem" in="${systemMenuList}">
            <li class="list-group-item">
            <g:hiddenField name="menuId" value="${menuItem?.id}"></g:hiddenField>
            <div class="row">
                <div class="col-md-2">
                    <g:if test="${menuItem.parentMenu != null}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</g:if>
                    <div class="checkbox">
                        <label>
                            <% boolean menuFlag = false %>
                            <g:each var="roleRightItem" in="${systemRoleRights}">
                                <g:if test="${menuItem.id == roleRightItem.systemMenu.id}">
                                    <% menuFlag = true %>

                                </g:if>
                            </g:each>
                            <g:if test="${menuFlag}">

                                <input type="checkbox" name="menuName" checked>${menuItem.menuName}
                            </g:if>
                            <g:else>
                                <input type="checkbox" name="menuName" >${menuItem.menuName}

                            </g:else>

                        </label>
                    </div>
                </div>

            </div>
        </g:each>

    </ul>
</div>

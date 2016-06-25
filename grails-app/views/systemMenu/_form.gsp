<div class="container-fluid">
    <g:form name="systemMenuForm" url="[controller: 'systemMenu', action: 'save']" useToken="true">
        <g:hiddenField name="id" value="${systemMenu?.id}"/>
        <g:hiddenField id="domainAction" name="domainAction" value="${action}"/>

    %{--<g:domainError model="${systemRole}"/>--}%
        <div class="row">

            <div class="form-group col-md-3">
                <label for="menuName">菜单名</label>
                <input id="menuName" class="form-control" type="text" placeholder="必填项"
                       name="menuName" value="${systemMenu?.menuName}">
            </div>
            <div class="form-group col-md-3">
                <label for="parentMenu">父菜单</label>
                <g:select name="parentMenu" class="form-control" from="${CarSale.SystemMenu.findAllByParentMenuIsNull()}" noSelection="['':'可选择...']"
                    optionKey="id" optionValue="menuName" value="${systemMenu?.parentMenu}" />
            </div>
            <div class="form-group col-md-3">
                <label for="menuSort">排序值</label>
                <input id="menuSort" class="form-control" type="text" placeholder="必填项"
                       name="menuSort" value="${systemMenu?.menuSort}">
            </div>
            <div class="form-group col-md-3">
                <label for="menuIcon">菜单图标</label>
                <input id="menuIcon" class="form-control" type="text" placeholder="必填项"
                       name="menuIcon" value="${systemMenu?.menuIcon}">
            </div>
            <div class="form-group col-md-3">
                <label for="menuUrl">菜单地址</label>
                <input id="menuUrl" class="form-control" type="text" placeholder="必填项"
                       name="menuUrl" value="${systemMenu?.menuUrl}">
            </div>
    </g:form>
</div>
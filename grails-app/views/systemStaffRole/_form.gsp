<g:set var="systemStaffRoleService" bean="systemStaffRoleService"/>
<div class="container-fluid">
    <g:form name="systemStaffRoleForm" url="[controller: 'systemStaffRole', action: 'save']" useToken="true">
        <g:hiddenField id="staffInfoId" name="staffInfoId" value="${staffInfo?.id}"/>
        <g:hiddenField name="domainAction" value="${action}"/>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-info">
                    <div class="box-body">
                        <div class="col-md-4">
                            <div>
                                <label>用户名</label>
                                <span id="staffCode">${staffInfo?.staffCode}</span>
                            </div>

                            <div>
                                <label for="roleName">角色名</label>
                                <select multiple id="roleName" class="form-control">
                                    <g:each in="${staffRoles}">
                                        <option>${it?.roleName}</option>
                                    </g:each>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-8" style="padding-top: 55px">
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="addSystemRoleId">授予角色</label>
                                    <g:select id="addSystemRoleId" name='systemRole'
                                              noSelection="${['': '请选择...']}"
                                              from='${staffNotRoles}'
                                              optionKey="id" optionValue="roleName"></g:select>
                                </div>


                                <div class="col-md-2">
                                    <button id="saveButton" type="button"
                                            class="btn btn-block btn-primary btn-sm" onclick="saveSystemStaffRole();">
                                        <i class="fa fa-save"></i> 添加
                                    </button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <label for="delSystemRoleId">撤销角色</label>
                                    <g:select id="delSystemRoleId" name='systemRole'
                                              noSelection="${['': '请选择...']}"
                                              from='${staffRoles}'
                                              optionKey="id" optionValue="roleName"></g:select>
                                </div>

                                <div class="col-md-2">
                                    <button id="deleteButton" type="button"
                                            class="btn btn-block btn-primary btn-sm" onclick="delSystemStaffRole();">
                                        <i class="fa fa-trash"></i> 删除
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </g:form>
</div>
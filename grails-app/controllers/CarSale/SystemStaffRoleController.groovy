package CarSale

import grails.converters.JSON

class SystemStaffRoleController {

    static layout = "main"

    def systemStaffRoleService

    def loadPage() {
        def result = search(params)
        render(template: "/${controllerName}/table_list",
                model:[systemStaffRoleList:result.systemStaffRoleList, total: result.total])
    }

    protected def search(params) {
        if (!params.max) params.max = 2
        if (!params.offset) params.offset = 0
        if (!params.order) params.order = 'desc'
        if (!params.sort) params.sort = 'dateCreated'

        def searchClosure = {
            if (params.staffCode) {
                like('staffCode', "%${params.staffCode}%")
            }
            if (params.realName) {
                like('realName', "%${params.realName}%")
            }
        }

        def c = SystemStaffRole.createCriteria()
        def systemStaffRoleList = c.list(params,searchClosure)
        [systemStaffRoleList:systemStaffRoleList, total: systemStaffRoleList.totalCount]


    }

    def index() {
        search(params)
    }

    def create(){
        def systemStaffRole = new SystemStaffRole()
        render(template: "/${controllerName}/form",
                model:[systemStaffRole: systemStaffRole, action:actionName])
    }

    def edit() {
        render(template: "/${controllerName}/form",
                model: [systemStaffRole: SystemStaffRole.get(params.id), action: actionName])
    }

    def save() {
        def haserror = false
        def message = new StringBuffer()
        def systemStaffRole

        log.error(params)
        println(actionName)
        println(params.domainAction)
        if (params.domainAction == 'edit') {
            systemStaffRole = SystemStaffRole.get(params.id)
            systemStaffRole.properties = params
        } else if (params.domainAction == 'create') {
            systemStaffRole = new SystemStaffRole(params)
        }
        if (!systemStaffRole.validate()) {
            haserror = true
            message.append(g.domainError([model:systemStaffRole]))
        } else {
            systemStaffRoleService.save(systemStaffRole)
            message.append('操作成功')
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message]
            render result as JSON

        }

    }

    def delete() {
        def systemStaffRole = SystemStaffRole.get(params.id)
        systemStaffRole.delete(flush:true)
        render(contentType:'application/json'){
            def result=['status':'success','message':'操作成功']
            render result as JSON
        }

    }
}

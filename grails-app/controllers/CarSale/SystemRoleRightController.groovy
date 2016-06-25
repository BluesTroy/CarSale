package CarSale

import grails.converters.JSON

class SystemRoleRightController {

    static layout = "main"

    def systemRoleRightService

    def loadPage() {
        def result = search(params)
        render(template: "/${controllerName}/table_list",
                model:[systemRoleRightList:result.systemRoleRightList, total: result.total])
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

        def c = SystemRoleRight.createCriteria()
        def systemRoleRightList = c.list(params,searchClosure)
        [systemRoleRightList:systemRoleRightList, total: systemRoleRightList.totalCount]


    }

    def index() {
        search(params)
    }

    def create(){
        def systemRoleRight = new SystemRoleRight()
        render(template: "/${controllerName}/form",
                model:[systemRoleRight: systemRoleRight, action:actionName])
    }

    def edit() {
        render(template: "/${controllerName}/form",
                model: [systemRoleRight: SystemRoleRight.get(params.id), action: actionName])
    }

    def save() {
        def haserror = false
        def message = new StringBuffer()
        def systemRoleRight

        log.error(params)
        println(actionName)
        println(params.domainAction)
        if (params.domainAction == 'edit') {
            systemRoleRight = SystemRoleRight.get(params.id)
            systemRoleRight.properties = params
        } else if (params.domainAction == 'create') {
            systemRoleRight = new SystemRoleRight(params)
        }
        if (!systemRoleRight.validate()) {
            haserror = true
            message.append(g.domainError([model:systemRoleRight]))
        } else {
            systemRoleRightService.save(systemRoleRight)
            message.append('操作成功')
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message]
            render result as JSON

        }

    }

    def delete() {
        def systemRoleRight = SystemRoleRight.get(params.id)
        systemRoleRight.delete(flush:true)
        render(contentType:'application/json'){
            def result=['status':'success','message':'操作成功']
            render result as JSON
        }

    }
}

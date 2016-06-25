package CarSale

import grails.converters.JSON

class SystemMenuController {

    static layout = "main"

    def systemMenuService

    def loadPage() {
        def result = search(params)
        render(template: "/${controllerName}/table_list",
                model:[systemMenuList:result.systemMenuList, total: result.total])
    }

    protected def search(params) {
        if (!params.max) params.max = 2
        if (!params.offset) params.offset = 0
        if (!params.order) params.order = 'desc'
        if (!params.sort) params.sort = 'dateCreated'

        def searchClosure = {
            if (params.menuName) {
                like('menuName', "%${params.menuName}%")
            }
        }

        def c = SystemMenu.createCriteria()
        def systemMenuList = c.list(params,searchClosure)
        [systemMenuList:systemMenuList, total: systemMenuList.totalCount]


    }

    def index() {
        search(params)
    }

    def create(){
        def systemMenu = new SystemMenu()
        render(template: "/${controllerName}/form",
                model:[systemMenu: systemMenu, action:actionName])
    }

    def edit() {
        render(template: "/${controllerName}/form",
                model: [systemMenu: SystemMenu.get(params.id), action: actionName])
    }

    def save() {
        def haserror = false
        def message = new StringBuffer()
        def systemMenu

        log.error(params)
        println(actionName)
        println(params.domainAction)
        if (params.domainAction == 'edit') {
            systemMenu = SystemMenu.get(params.id)
            systemMenu.properties = params
//            systemMenu.parentMenu=params.parentMenu.toString()
        } else if (params.domainAction == 'create') {
            systemMenu = new SystemMenu(params)
//            systemMenu.parentMenu=params.parentMenu.toString()
        }
        if (!systemMenu.validate()) {
            haserror = true
            message.append(g.domainError([model:systemMenu]))
        } else {
            systemMenuService.save(systemMenu)
            message.append('操作成功')
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message]
            render result as JSON

        }

    }

    def delete() {
        def haserror = false
        def message = new StringBuffer()
        def systemMenu = SystemMenu.get(params.id)
        if(SystemMenu.findAllByParentMenu(systemMenu.id).size()>0){ //如果该菜单有子菜单，则提示先删除该菜单的全部子菜单
            log.debug("isnulllllllllllll..................")
            haserror =true
            message.append("删除失败,该菜单存在子菜单,请先删除其所有子菜单.")
        }else{
            systemMenu.delete(flush:true)
            message.append("操作成功")
        }
        render(contentType:'application/json'){
            def result=['status':haserror? "failed":'success','message':message]
            render result as JSON
        }

    }
}

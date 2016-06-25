package CarSale

import grails.converters.JSON

class SystemRoleRightController {

    static layout = "main"

    def systemRoleRightService

    def show() {
        log.debug("show....")
        def systemRole = SystemRole.get(params.id)
        log.debug(systemRole.roleName)
        def systemRoleRights = SystemRoleRight.findAllBySystemRole(systemRole)
        def systemMenus =[]
        systemRoleRights.each {
            systemMenus.add(it.systemMenu)
        }
        systemMenus.sort{it.rootPath}
        render(template: "/${controllerName}/form",
                model: [systemMenus: systemMenus,action: "show"])
    }

    def index() {
    }

    def edit() {
        def systemRole = SystemRole.get(params.id)
        def systemRoleRights = SystemRoleRight.findAllBySystemRole(systemRole)
        def systemMenuList = SystemMenu.listOrderByRootPath()
        render(template: "/${controllerName}/form_edit",
                model: [systemMenuList: systemMenuList,systemRoleRights: systemRoleRights, action: "edit"])
    }

    def save() {
        def systemRole = SystemRole.get(params.systemRoleId)

        def menuList  = []
        params.length.toInteger().times {
            menuList.add(params.list("menuList[${it}]").get(0))
        }
        systemRoleRightService.saveRoleRights(systemRole,menuList)

        render(contentType: "application/json") {
            def result = ["status" : "success",
                          "message": "操作成功"]
            render result as JSON

        }

    }

}

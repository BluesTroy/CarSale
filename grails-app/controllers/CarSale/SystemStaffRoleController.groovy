package CarSale

import grails.converters.JSON

import static CarSale.StaffInfo.createCriteria
import static CarSale.StaffInfo.get

class SystemStaffRoleController {

    static layout = "main"

    def systemStaffRoleService

    def loadPage() {
        def result = search(params)
        render(template: "/${controllerName}/table_list",
                model:[staffInfoList:result.staffInfoList, total: result.total])
    }

    protected def search(params) {
        def listMaxNum = SystemParameter.findByParameterName('listMaxNum')?.parameterValue?.toInteger()
        if (!params.max) params.max = listMaxNum ?  listMaxNum:5
        if (!params.offset) params.offset = 0
        if (!params.order) params.order = 'desc'
        if (!params.sort) params.sort = 'dateCreated'

        def searchClosure = {
            if (params.staffCode) {
                like('staffCode', "%${params.staffCode}%")
            }
            if (params.description) {
                like('realName', "%${params.realName}%")
            }
        }

        def c = StaffInfo.createCriteria()
        def staffInfoList = c.list(params,searchClosure)
        [staffInfoList:staffInfoList, total: staffInfoList.totalCount]


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
        def staffInfo = StaffInfo.get(params.id)
        def systemStaffRoleList = SystemStaffRole.findAllByStaffInfo(staffInfo)
        def staffRoles = systemStaffRoleService.getStaffRoles(staffInfo)
        def staffNotRoles = systemStaffRoleService.getStaffNotRoles(staffInfo)
        log.debug("----------------------------")
        log.debug(systemStaffRoleList)
        log.debug(staffRoles)
        render(template: "/${controllerName}/form",
                model: [staffInfo:staffInfo,systemStaffRoleList: systemStaffRoleList,staffRoles:staffRoles,staffNotRoles:staffNotRoles, action: actionName])
    }

    def save() {
        def haserror = false
        def message = new StringBuffer()
        def systemStaffRole
        log.error(params)
        systemStaffRole = new SystemStaffRole(params)
        systemStaffRole.staffInfo = get(params.staffInfoId)
        systemStaffRole.systemRole = SystemRole.get(params.systemRoleId)
        if (!systemStaffRole.validate()) {
            haserror = true
            message.append(g.domainError([model:systemStaffRole]))
        } else {
            systemStaffRoleService.save(systemStaffRole)
            message.append('操作成功')
        }

        render(contentType: "application/json") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message, "systemStaffRole": systemStaffRole]
            render result as JSON
        }

    }

    def delete() {
        def staffInfo = get(params.staffInfoId)
        def systemRole = SystemRole.get(params.systemRoleId)
        def systemStaffRole = SystemStaffRole.findByStaffInfoAndSystemRole(staffInfo,systemRole)
        systemStaffRole.delete(flush: true)
        render(contentType: "application/json") {
            def result = ["status": "success", "message": "操作成功"]
            render result as JSON
        }

    }
}

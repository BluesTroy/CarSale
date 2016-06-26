package CarSale

import grails.transaction.Transactional

@Transactional
class SystemStaffRoleService {

    def save(systemStaffRole) {
        if (!systemStaffRole.validate()) {
//            throw new ValidationException("保存失败", systemStaffRole.errors)
        } else {
            systemStaffRole.save()
        }
    }


    def getStaffRoles(staffInfo) {
        def staffRoles = SystemStaffRole.findAllByStaffInfo(staffInfo)
        def roles = []
        staffRoles.each {
            roles.add(it.systemRole)
        }
        return roles
    }

    def getStaffNotRoles(staffInfo) {
        def userRoles = getStaffRoles(staffInfo)
        def roles =SystemRole.list()
//        userRoles.each {
//            roles.each{ r->
//                if (r.id==it.id){
//                    roles.remove(r)
//                }
//            }
//        }
        roles.removeAll(userRoles)
        return roles
    }



    def getStaffFirstMenus(staffInfo){
        def roles = getStaffRoles(staffInfo)
        def menus = []
        roles.each {
            SystemRoleRight.findAllBySystemRole(it).each { item ->
                if(item.systemMenu?.parentMenu==null){
                    menus.add(item.systemMenu)
                }
            }
        }
        menus?.unique()?.sort{it.rootPath}
    }

}

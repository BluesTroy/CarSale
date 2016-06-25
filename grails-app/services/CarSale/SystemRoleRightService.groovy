package CarSale

import grails.transaction.Transactional

@Transactional
class SystemRoleRightService {

    def save(systemRoleRight) {
        if(!systemRoleRight.validate()){
//            throw new ValidationException("保存失败", systemRoleRight.errors)
        }else {
            systemRoleRight.save()
        }
    }


    //为某一个角色授权，同时保存多条数据
    def saveRoleRights(systemRole,menuList){

        //先删除掉与该角色相关的记录
        def roleRightList = SystemRoleRight.findAllBySystemRole(systemRole)
        roleRightList.each {
            def rs = SystemRoleRight.get(it.id)
            rs.delete(flush:true)
        }


        int size = menuList.size()
        for(int i = 0;i<size;i++){
            def systemRoleRight = new SystemRoleRight()
            systemRoleRight.systemRole = systemRole
            systemRoleRight.systemMenu = SystemMenu.get(menuList.get(i).menuId)
            save(systemRoleRight)
        }
    }
}

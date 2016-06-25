package CarSale

import grails.transaction.Transactional

@Transactional
class SystemStaffRoleService {

    def save(systemStaffRole) {
        if(!systemStaffRole.validate()){
//            throw new ValidationException("保存失败", systemStaffRole.errors)
        }else {
            systemStaffRole.save()
        }
    }
}

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
}

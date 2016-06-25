package CarSale

import grails.transaction.Transactional

@Transactional
class SystemMenuService {

    def save(systemMenu) {
        if(!systemMenu.validate()){
//            throw new ValidationException("保存失败", systemMenu.errors)
        }else {
            systemMenu.save()
        }
    }
}

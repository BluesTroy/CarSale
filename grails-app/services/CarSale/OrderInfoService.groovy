package CarSale

import grails.transaction.Transactional

@Transactional
class OrderInfoService {
    def save(orderInfo) {
        if(!orderInfo.validate()){
//            throw new ValidationException("保存失败", orderInfo.errors)
        }else {
            orderInfo.save()
        }
    }

    def saveOrderDetail(orderDetail){
        if(!orderDetail.validate()){
//            throw new ValidationException("保存失败", orderDetail.errors)
        }else {
            orderDetail.save()
        }
    }

    def outWarehouse(orderInfo){
        orderInfo.outTime=new Date()
        def totalPrice = 0
        orderInfo.orderDetails?.each {
            totalPrice+=it.totalPrice
        }
        orderInfo.totalPrice = totalPrice
        orderInfo.save()
        orderInfo.orderDetails?.each{
            def carInfo = it.carInfo
            def warehouse = carInfo?.warehouse
            carInfo.inventory = carInfo.inventory-it.number
            warehouse.nowInventory = warehouse.nowInventory-it.number
            carInfo.save()
            warehouse.save()
        }
    }


}

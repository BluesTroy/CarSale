package CarSale

import grails.transaction.Transactional

@Transactional
class PurchaseOrderService {

    def save(purchase) {
        if (!purchase.validate()) {
//            throw new ValidationException("保存失败", purchase.errors)
        } else {
            purchase.save()
        }
    }

    def saveInWarehouse(params) {
        def purchaseOrder = PurchaseOrder.get(params.purchaseOrderId)
        def carInfo = purchaseOrder.carInfo
        def warehouse = Warehouse.get(params.warehouse)
        carInfo.warehouse = warehouse
        carInfo.inventory = (carInfo.inventory ? carInfo.inventory : 0) + purchaseOrder.carNumber
        carInfo.save()
        warehouse.nowInventory += purchaseOrder.carNumber
        warehouse.save()
        purchaseOrder.storageStatus = true
        purchaseOrder.storageTime = new Date()
        purchaseOrder.save()
    }

}

package CarSale

import grails.converters.JSON
import org.apache.commons.lang.StringUtils

class PurchaseOrderController {

    static layout = "main"

    def purchaseOrderService
    def utilService

    def loadPage() {
        def result = search(params)
        render(template: "/${controllerName}/table_list",
                model: [purchaseOrderList: result.purchaseOrderList, total: result.total])
    }

    protected def search(params) {
        def listMaxNum = SystemParameter.findByParameterName('listMaxNum')?.parameterValue?.toInteger()
        if (!params.max) params.max = listMaxNum ?  listMaxNum:5
        if (!params.offset) params.offset = 0
        if (!params.order) params.order = 'desc'
        if (!params.sort) params.sort = 'dateCreated'

        def searchClosure = {
            if (params.orderCode) {
                like('orderCode', "%${params.orderCode}%")
            }
        }

        def c = PurchaseOrder.createCriteria()
        def purchaseOrderList = c.list(params, searchClosure)
        [purchaseOrderList: purchaseOrderList, total: purchaseOrderList.totalCount]


    }

    def index() {
        search(params)
    }

    def create() {
        def purchaseOrder = new PurchaseOrder()
        render(template: "/${controllerName}/form",
                model: [purchaseOrder: purchaseOrder, action: actionName])
    }

    def edit() {
        render(template: "/${controllerName}/form",
                model: [purchaseOrder: PurchaseOrder.get(params.id), action: actionName])
    }

    def save() {
        def haserror = false
        def message = new StringBuffer()
        def purchaseOrder

        log.error(params)
        println(actionName)
        println(params.domainAction)
        if (params.domainAction == 'edit') {
            purchaseOrder = PurchaseOrder.get(params.id)
            purchaseOrder.properties = params
            purchaseOrder.totalPrice = purchaseOrder?.carNumber*purchaseOrder?.singlePrice
        } else if (params.domainAction == 'create') {
            purchaseOrder = new PurchaseOrder(params)
            purchaseOrder.orderCode = new Date().getTime().toString()
            purchaseOrder.totalPrice = purchaseOrder?.carNumber*purchaseOrder?.singlePrice
            purchaseOrder.storageStatus = false
        }
        if (!purchaseOrder.validate()) {
            haserror = true
            message.append(g.domainError([model: purchaseOrder]))
        } else {
            purchaseOrderService.save(purchaseOrder)
            message.append('操作成功')
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message]
            render result as JSON

        }

    }

    def saveInWarehouse(){
        log.debug("test................")
        log.error(params)
        purchaseOrderService.saveInWarehouse(params)

        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : "success",
                          "message": "入库成功"]
            render result as JSON

        }
    }

    def delete() {
        def purchaseOrder = PurchaseOrder.get(params.id)
        purchaseOrder.delete(flush: true)
        render(contentType: 'application/json') {
            def result = ['status': 'success', 'message': '操作成功']
            render result as JSON
        }

    }

    /**
     * 将所有订单导出为excel
     */
    def exportExcel() {
        log.debug("----------exportExcel------------")
        log.debug(params)
        def titleList = ["订单编号","汽车品牌","进货单价（万）","汽车数量","进货总价（万）","订单时间","供应商","入库状态"]
        def contentList = []
        def orderList = PurchaseOrder.listOrderByOrderTime()
        orderList.each {
            def contentCellList = []
            String orderCode = StringUtils.trimToEmpty(it.orderCode)    //订单编号
            String carBrand = StringUtils.trimToEmpty(it.carInfo.carBrand)  //汽车品牌
            String singlePrice = StringUtils.trimToEmpty(it.singlePrice.toString())    //进货单价（万）
            String carNumber = StringUtils.trimToEmpty(it.carNumber.toString())    //汽车数量
            String totalPrice = StringUtils.trimToEmpty(it.totalPrice.toString())    //进货总价（万）
            String orderTime = StringUtils.trimToEmpty(g.formatDate(formatName: "default.date.format.date", date: it.orderTime).toString()) //订单时间
            String supplier = StringUtils.trimToEmpty(it.supplier.supplierName) //供应商
            String storageStatus = '' //入库状态
            if (it.storageStatus){
                storageStatus = '已入库'
            }else {
                storageStatus = '未入库'
            }

            contentCellList.add(orderCode)
            contentCellList.add(carBrand)
            contentCellList.add(singlePrice)
            contentCellList.add(carNumber)
            contentCellList.add(totalPrice)
            contentCellList.add(orderTime)
            contentCellList.add(supplier)
            contentCellList.add(storageStatus)
            contentList.add(contentCellList)
        }

        response.setHeader("Content-disposition", "attachment; filename=PurchaseOrder.xls")
        response.setContentType("application/vnd.ms-excel")
        utilService.buildExcel(response.outputStream, titleList, contentList)
    }
}

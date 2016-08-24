package CarSale

import grails.converters.JSON
import org.apache.commons.lang.StringUtils

class OrderInfoController {

    static layout = "main"

    def orderInfoService
    def utilService

    def loadPage() {
        def result = search(params)
        render(template: "/${controllerName}/table_list",
                model: [orderInfoList: result.orderInfoList, total: result.total])
    }

    protected def search(params) {
        def listMaxNum = SystemParameter.findByParameterName('listMaxNum')?.parameterValue?.toInteger()
        if (!params.max) params.max = listMaxNum ?  listMaxNum:5
        if (!params.offset) params.offset = 0
        if (!params.order) params.order = 'desc'
        if (!params.sort) params.sort = 'orderTime'

        def searchClosure = {
            if (params.orderCode) {
                like('orderCode', "%${params.orderCode}%")
            }
        }

        def c = OrderInfo.createCriteria()
        def orderInfoList = c.list(params, searchClosure)
        [orderInfoList: orderInfoList, total: orderInfoList.totalCount]


    }

    def index() {
        search(params)
    }

    def create() {
        def orderInfo = new OrderInfo()
        render(template: "/${controllerName}/form",
                model: [orderInfo: orderInfo, action: actionName])
    }

    def edit() {
        render(template: "/${controllerName}/form",
                model: [orderInfo: OrderInfo.get(params.id), action: actionName])
    }

    def save() {
        def haserror = false
        def message = new StringBuffer()
        def orderInfo

        log.error(params)
        println(actionName)
        println(params.domainAction)
        if (params.domainAction == 'edit') {
            orderInfo = OrderInfo.get(params.id)
            orderInfo.properties = params
        } else if (params.domainAction == 'create') {
            orderInfo = new OrderInfo(params)
            orderInfo.orderCode=new Date().getTime().toString()
        }
        if (!orderInfo.validate()) {
            haserror = true
            message.append(g.domainError([model: orderInfo]))
        } else {
            orderInfoService.save(orderInfo)
            message.append('操作成功')
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message]
            render result as JSON

        }

    }

    def outWarehouse(){
        def orderInfo= OrderInfo.get(params.id)

        orderInfoService.outWarehouse(orderInfo)
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" :  "success",
                          "message": '操作成功']
            render result as JSON

        }
    }

    def saveOrderDetail() {
        def haserror = false
        def message = new StringBuffer()
        def orderInfo
        def orderDetail

        log.error(params)


        orderInfo = OrderInfo.get(params.orderInfoId)
        orderDetail = new OrderDetail(params)
        orderDetail.singlePrice=orderDetail?.carInfo?.price
        orderDetail.totalPrice = orderDetail.singlePrice*Integer.valueOf(params.number)
        orderDetail.orderInfo = orderInfo

        if (!orderDetail.validate()) {
            haserror = true
            message.append(g.domainError([model: orderDetail]))
        } else {
            orderInfoService.saveOrderDetail(orderDetail)
            message.append('操作成功')
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ["status" : haserror ? "failed" : "success",
                          "message": message, "id":orderInfo.id]
            render result as JSON

        }

    }

    def deleteOrderDetail(){
        def orderDetail = OrderDetail.get(params.id)
        def orderInfo = orderDetail.orderInfo
        orderDetail.delete(flush: true)
        render(contentType: 'application/json') {
            def result = ['status': 'success', 'message': '操作成功',id:orderInfo.id]
            render result as JSON
        }
    }

    def delete() {
        def orderInfo = OrderInfo.get(params.id)
        orderInfo.delete(flush: true)
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
        def titleList = ["订单编号","下单时间","出库时间","销售内容","销售总数","总价格（万元）","销售员","客户"]
        def contentList = []
        def orderList = OrderInfo.listOrderByOrderTime()
        orderList.each {
            def contentCellList = []
            String orderCode = StringUtils.trimToEmpty(it.orderCode)    //订单编号
            String orderTime = StringUtils.trimToEmpty(g.formatDate(formatName: "default.date.format.date", date: it.orderTime).toString()) //下单时间
            String outTime = StringUtils.trimToEmpty(g.formatDate(formatName: "default.date.format.date", date: it.outTime).toString()) //出库时间
            String saleContent = '' //销售内容
            it.orderDetails.each {
                saleContent+=it.carInfo.carBrand+it.number+"辆；"
            }
            String saleNumber = StringUtils.trimToEmpty(it.saleNumber.toString())  //销售总数
            String totalPrice = StringUtils.trimToEmpty(it.totalPrice.toString())  //总价格（万元）
            String salesman = StringUtils.trimToEmpty(it.salesman.realName) //销售员
            String customer = StringUtils.trimToEmpty(it.customer.name) //客户

            contentCellList.add(orderCode)
            contentCellList.add(orderTime)
            contentCellList.add(outTime)
            contentCellList.add(saleContent)
            contentCellList.add(saleNumber)
            contentCellList.add(totalPrice)
            contentCellList.add(salesman)
            contentCellList.add(customer)
            contentList.add(contentCellList)
        }

        response.setHeader("Content-disposition", "attachment; filename=Order.xls")
        response.setContentType("application/vnd.ms-excel")
        utilService.buildExcel(response.outputStream, titleList, contentList)
    }
}

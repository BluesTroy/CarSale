package CarSale

import grails.transaction.Transactional

import java.text.SimpleDateFormat

@Transactional
class FinanceService {

    def getIncomeList(params) {

        Date startTime = new Date(Long.valueOf(params.startOrderTime))
        Date endTime = new Date(Long.valueOf(params.endOrderTime))
        SimpleDateFormat format
        def DATE_TYPE = Calendar.YEAR

        //timeSpan  1-年 2-月 3-日
        if (params.timeSpan == '1') {  //按年的跨度
            log.debug("-----:year---")
            format = new SimpleDateFormat("yyyy")
            DATE_TYPE = Calendar.YEAR
        } else if (params.timeSpan == '2') {    //按月的跨度
            log.debug("-----:month---")
            format = new SimpleDateFormat("yyyy-MM")
            DATE_TYPE = Calendar.MONTH
        } else if (params.timeSpan == '3') {        ////按日的跨度
            log.debug("-----:day---")
            format = new SimpleDateFormat("yyyy-MM-dd")
            DATE_TYPE = Calendar.DAY_OF_YEAR
        } else {
            format = new SimpleDateFormat("yyyy")
        }

        //转化成对应格式的日期
        String startYearString = format.format(startTime)
        Date startYear = format.parse(startYearString)

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(startYear)
        calendar.add(DATE_TYPE, +1)
        Date nextYear = calendar.getTime()
        startYear = startTime

        def incomeList = []
        while (nextYear.getTime() < endTime.getTime()) {
            def incomeMap = [:]
            incomeMap['orderNumber'] = 0
            incomeMap['totalPrice'] = 0.0
            incomeMap['startTime'] = format.format(startYear)  //开始年份（月份、日）
            incomeMap['endTime'] = format.format(nextYear)      //结束年份（月份、日）

            def orderList = []
            orderList = OrderInfo.findAllByOrderTimeGreaterThanEqualsAndOrderTimeLessThan(startYear, nextYear)
            if (orderList.size() > 0) {
                incomeMap['orderNumber'] = orderList.size()
                orderList.each {
                    incomeMap['totalPrice'] = incomeMap['totalPrice'] + it.totalPrice
                }

                incomeList.add(incomeMap)
            }


            calendar.add(DATE_TYPE, +1)
            startYear = nextYear
            nextYear = calendar.getTime()

        }

        //-------------------将最后不到整年（月份、日）的计算一下----------
        if (endTime.getTime() > startYear.getTime()) {


            def incomeMap = [:]
            incomeMap['orderNumber'] = 0        //订单数
            incomeMap['totalPrice'] = 0.0         //订单总收入
            incomeMap['startTime'] = format.format(startYear)   //开始年份（月份、日）
            incomeMap['endTime'] = format.format(endTime)       //结束年份（月份、日）

            def orderList = []
            orderList = OrderInfo.findAllByOrderTimeGreaterThanEqualsAndOrderTimeLessThan(startYear, endTime)  //产生支付行为的订单
            if (orderList.size() > 0) {
                incomeMap['orderNumber'] = orderList.size()
                orderList.each {
                    incomeMap['totalPrice'] = incomeMap['totalPrice'] + it.totalPrice
                }

                incomeList.add(incomeMap)
            }
        }
        //------------------------------------------------

        def allOrderNumber = 0
        def allTotalPrice = 0.0
        incomeList.each {
            allOrderNumber = allOrderNumber + it.orderNumber
            allTotalPrice = allTotalPrice + it.totalPrice
        }
        log.debug("-----------" + allTotalPrice)

        [incomeList: incomeList, allOrderNumber: allOrderNumber, allTotalPrice: allTotalPrice]

    }

    def getOutcomeList(params) {

        Date startTime = new Date(Long.valueOf(params.startOrderTime))
        Date endTime = new Date(Long.valueOf(params.endOrderTime))
        SimpleDateFormat format
        def DATE_TYPE = Calendar.YEAR

        //timeSpan  1-年 2-月 3-日
        if (params.timeSpan == '1') {  //按年的跨度
            log.debug("-----:year---")
            format = new SimpleDateFormat("yyyy")
            DATE_TYPE = Calendar.YEAR
        } else if (params.timeSpan == '2') {    //按月的跨度
            log.debug("-----:month---")
            format = new SimpleDateFormat("yyyy-MM")
            DATE_TYPE = Calendar.MONTH
        } else if (params.timeSpan == '3') {        ////按日的跨度
            log.debug("-----:day---")
            format = new SimpleDateFormat("yyyy-MM-dd")
            DATE_TYPE = Calendar.DAY_OF_YEAR
        } else {
            format = new SimpleDateFormat("yyyy")
        }

        //转化成对应格式的日期
        String startYearString = format.format(startTime)
        Date startYear = format.parse(startYearString)

        Calendar calendar = Calendar.getInstance()
        calendar.setTime(startYear)
        calendar.add(DATE_TYPE, +1)
        Date nextYear = calendar.getTime()
        startYear = startTime

        def incomeList = []
        while (nextYear.getTime() < endTime.getTime()) {
            def incomeMap = [:]
            incomeMap['orderNumber'] = 0
            incomeMap['totalPrice'] = 0.0
            incomeMap['startTime'] = format.format(startYear)  //开始年份（月份、日）
            incomeMap['endTime'] = format.format(nextYear)      //结束年份（月份、日）

            def orderList = []
            orderList = PurchaseOrder.findAllByOrderTimeGreaterThanEqualsAndOrderTimeLessThan(startYear, nextYear)
            if (orderList.size() > 0) {
                incomeMap['orderNumber'] = orderList.size()
                orderList.each {
                    incomeMap['totalPrice'] = incomeMap['totalPrice'] + it.totalPrice
                }

                incomeList.add(incomeMap)
            }


            calendar.add(DATE_TYPE, +1)
            startYear = nextYear
            nextYear = calendar.getTime()

        }

        //-------------------将最后不到整年（月份、日）的计算一下----------
        if (endTime.getTime() > startYear.getTime()) {


            def incomeMap = [:]
            incomeMap['orderNumber'] = 0        //订单数
            incomeMap['totalPrice'] = 0.0         //订单总收入
            incomeMap['startTime'] = format.format(startYear)   //开始年份（月份、日）
            incomeMap['endTime'] = format.format(endTime)       //结束年份（月份、日）

            def orderList = []
            orderList = PurchaseOrder.findAllByOrderTimeGreaterThanEqualsAndOrderTimeLessThan(startYear, endTime)  //产生支付行为的订单
            if (orderList.size() > 0) {
                incomeMap['orderNumber'] = orderList.size()
                orderList.each {
                    incomeMap['totalPrice'] = incomeMap['totalPrice'] + it.totalPrice
                }

                incomeList.add(incomeMap)
            }
        }
        //------------------------------------------------

        def allOrderNumber = 0
        def allTotalPrice = 0.0
        incomeList.each {
            allOrderNumber = allOrderNumber + it.orderNumber
            allTotalPrice = allTotalPrice + it.totalPrice
        }
        log.debug("-----------" + allTotalPrice)

        [outcomeList: incomeList, allOrderNumber: allOrderNumber, allTotalPrice: allTotalPrice]

    }


}

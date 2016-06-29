package CarSale

import java.text.SimpleDateFormat

class FinanceController {

    static layout = "main"
    def financeService

    def loadPage() {
        Date nowDate = new Date()

        SimpleDateFormat format = new SimpleDateFormat('yyyy-MM-dd')
        Date initialDate = format.parse('2010-01-01')

        params.startOrderTime = initialDate.getTime()
        params.endOrderTime = nowDate.getTime()

        if (!params.timeSpan) {
            params.timeSpan = '3'   //缺省按日统计
        }
        def result = search(params)
        render(template: "/${controllerName}/income_table",
                model: result)
    }

    def loadOutcome() {
        Date nowDate = new Date()

        SimpleDateFormat format = new SimpleDateFormat('yyyy-MM-dd')
        Date initialDate = format.parse('2010-01-01')

        params.startOrderTime = initialDate.getTime()
        params.endOrderTime = nowDate.getTime()

        if (!params.timeSpan) {
            params.timeSpan = '3'   //缺省按日统计
        }
        def result = searchOutcome(params)
        render(template: "/${controllerName}/outcome_table",
                model: result)
    }

    /**
     * 收入管理页面
     */
    def index() {
        log.debug(params)

        Date nowDate = new Date()

        SimpleDateFormat format = new SimpleDateFormat('yyyy-MM-dd')
        Date initialDate = format.parse('2016-01-01')

        params.startOrderTime = initialDate.getTime()
        params.endOrderTime = nowDate.getTime()
        params.timeSpan = '3'   //缺省按日统计

        search(params)
    }

    def outcomeStatistic() {
        log.debug(params)

        Date nowDate = new Date()

        SimpleDateFormat format = new SimpleDateFormat('yyyy-MM-dd')
        Date initialDate = format.parse('2016-01-01')

        params.startOrderTime = initialDate.getTime()
        params.endOrderTime = nowDate.getTime()
        params.timeSpan = '3'   //缺省按日统计

        searchOutcome(params)
    }

    private def search(params) {
        if (params.startOrderTime && params.endOrderTime) {
            financeService.getIncomeList(params)
        }
    }

    private def searchOutcome(params) {
        if (params.startOrderTime && params.endOrderTime) {
            financeService.getOutcomeList(params)
        }
    }


}

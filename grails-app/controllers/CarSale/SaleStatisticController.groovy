package CarSale

import grails.converters.JSON

class SaleStatisticController {

    static layout = "main"

    def index() {

    }

    def purchaseCarStatistic() {}

    def getPurchaseData(){
        def carList = CarInfo.list()
        def labelList = []
        def numberList=[]
        def priceList=[]
        carList.each {
            labelList.add(it.carBrand.toString())
            def number = 0
            def price = 0
            PurchaseOrder.findByCarInfo(it).each {item->
                number+=item.carNumber
                price+=item.totalPrice
            }
            numberList.add(number)
            priceList.add(price)
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ['labelList': labelList,'numberList':numberList,'priceList':priceList]
            render result as JSON

        }
    }

    def saleCarStatistic() {}

    def getSaleData(){
        def carList = CarInfo.list()
        def labelList = []
        def numberList=[]
        def priceList=[]
        carList.each {
            labelList.add(it.carBrand.toString())
            def number = 0
            def price=0
            OrderInfo.list()?.each { ite ->
                ite.orderDetails?.each {item->
                    if(item.carInfo== it){
                        number+=item.number
                        price+=item.totalPrice
                    }
                }

            }
            numberList.add(number)
            priceList.add(price)
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ['labelList': labelList,'numberList':numberList,'priceList':priceList]
            render result as JSON

        }
    }

    def salesmanStatistic() {}

    def getSalesmanData(){
        def salesmanList = Salesman.list()
        def labelList = []
        def numberList=[]
        def priceList=[]
        salesmanList.each {
            labelList.add(it.realName)
            def number = 0
            def price = 0
            OrderInfo.findAllBySalesman(it)?.each {item->
                number+=item.saleNumber
                price += item.totalPrice
            }
            numberList.add(number)
            priceList.add(price)
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ['labelList': labelList,'numberList':numberList,priceList:priceList]
            render result as JSON

        }
    }


    def saleMonthStatistic() {}

    def getMonthData(){
        def dataList=[0,0,0,0,0,0,0,0,0,0,0,0]
        log.debug(new Date().getMonth())
        OrderInfo.list()?.each {
            dataList[it.orderTime?.getMonth()]+=it.totalPrice
        }
        log.debug(dataList)
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ['dataList':dataList ]
            render result as JSON

        }
    }


}

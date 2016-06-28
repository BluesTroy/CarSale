package CarSale

import grails.converters.JSON

class FinanceController {

    static layout = "main"

    def index() {

    }

    def purchaseCarStatistic() {}

    def getPurchaseData(){
        def carList = CarInfo.list()
        def labelList = []
        def valueList=[]
        carList.each {
            labelList.add(it.carBrand.toString())
            def number = 0
            PurchaseOrder.findByCarInfo(it).each {item->
                number+=item.carNumber
            }
            valueList.add(number)
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ['labelList': labelList,'valueList':valueList]
            render result as JSON

        }
    }

    def saleCarStatistic() {}

    def getSaleData(){
        def carList = CarInfo.list()
        def labelList = []
        def valueList=[]
        carList.each {
            labelList.add(it.carBrand.toString())
            def number = 0
            OrderInfo.list()?.each { ite ->
                ite.orderDetails?.each {item->
                    if(item.carInfo== it){
                        number+=item.number
                    }
                }
            }
            valueList.add(number)
        }
        render(contentType: "application/json", encoding: "UTF-8") {
            def result = ['labelList': labelList,'valueList':valueList]
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


}

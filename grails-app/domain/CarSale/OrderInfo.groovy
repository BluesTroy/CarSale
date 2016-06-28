package CarSale

class OrderInfo {

    String id
    Date dateCreated
    Date lastUpdate
    String createUser
    String updateUser

    String orderCode
    Date orderTime
    Date outTime
    Integer saleNumber
    Double totalPrice
//    short status
//    Date payTime
//    Date finishTime
    Salesman salesman
    Customer customer
    String memo

    static  hasMany = [orderDetails:OrderDetail]

    static constraints = {
        orderCode nullable: false, maxSize: 20
        orderTime nullable: true
        outTime nullable: true
        saleNumber nullable: false
        totalPrice nullable: true, scale: 2
//        status nullable: false
//        payTime nullable: true
//        finishTime nullable: true
        memo nullable: true, maxSize: 100

    }

    static mapping = {
        id generator: 'uuid.hex'
    }
}

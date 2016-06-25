package CarSale

class SystemMenu {
    String id
    Date dateCreated
    Date lastUpdated
    String createUser
    String updateUser

    String menuName
    Integer menuSort
    String menuIcon
    String menuUrl
    String parentMenu

    static constraints = {
        menuName nullable: false, maxSize: 20
        menuSort nullable: false
        menuIcon nullable: false, maxSize: 50
        menuUrl nullable: false, maxSize: 100
        parentMenu nullable: true, maxSize: 36
    }

    static mapping = {
        id generator: 'uuid.hex'
    }
}

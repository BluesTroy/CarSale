package CarSale

class SystemMenu {
    String id
    Date dateCreated
    Date lastUpdated
    String createUser
    String updateUser

    String menuName
    String menuIcon
    String menuUrl
    String parentMenu
    String rootPath

    static constraints = {
        menuName nullable: false, maxSize: 20
        menuIcon nullable: false, maxSize: 50
        menuUrl nullable: true, maxSize: 100
        parentMenu nullable: true, maxSize: 36
    }

    static mapping = {
        id generator: 'uuid.hex'
    }
}

package CarSale

class SystemRoleRight {
    String id
    Date dateCreated
    Date lastUpdated
    String createUser
    String updateUser



    static belongsTo = [systemRole: SystemRole,systemMenu:SystemMenu]

    static constraints = {

    }

    static mapping = {
        id generator: 'uuid.hex'
    }
}

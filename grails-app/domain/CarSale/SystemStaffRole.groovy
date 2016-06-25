package CarSale

class SystemStaffRole {
    String id
    Date dateCreated
    Date lastUpdated
    String createUser
    String updateUser



    static belongsTo = [staffInfo: StaffInfo,systemRole:SystemRole]

    static constraints = {

    }

    static mapping = {
        id generator: 'uuid.hex'
    }
}

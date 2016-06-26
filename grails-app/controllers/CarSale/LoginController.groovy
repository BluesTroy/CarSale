package CarSale

import grails.converters.JSON

class LoginController {

    def index() {

    }

    def authenticate() {
        log.error(params)
        def staff = StaffInfo.findByStaffCodeAndPassword(params.userName, params.password)
        if (staff) {
            session.staff = staff
            redirect(controller: "staffInfo", action: 'welcome')
        } else {
            flash.loginMessage = "用户名或密码错误."
            log.debug("user err....")
            redirect(controler: 'login', action: 'index')
        }
    }

    def logout(){
        session.staff = null
        render(contentType: "application/json") {
            def result = ["status": "success"]
            render result as JSON
        }
    }

}

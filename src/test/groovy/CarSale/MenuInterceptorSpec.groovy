package CarSale


import grails.test.mixin.TestFor
import interceptor.MenuInterceptor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(MenuInterceptor)
class MenuInterceptorSpec extends Specification {

    def setup() {
    }

    def cleanup() {

    }

    void "Test menu interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"menu")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}

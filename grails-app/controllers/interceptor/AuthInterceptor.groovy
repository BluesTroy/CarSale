package interceptor


class AuthInterceptor {
    int order = HIGHEST_PRECEDENCE
    AuthInterceptor(){
        matchAll().excludes(controller:"login")
    }

    boolean before() {
        if(!session.staff){
            forward(controller:"login", action: 'index')
            return false
        }

        true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}

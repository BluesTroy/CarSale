package interceptor


class MenuInterceptor {

    MenuInterceptor(){
        match(controller:'*',action: 'index')
    }


    boolean before() {
        session.menuUrl = '/'+controllerName+'/'+actionName

        true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}

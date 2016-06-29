package interceptor


class MenuInterceptor {

    MenuInterceptor(){
        match(controller:'*',action: 'index')
        match(controller:'saleStatistic',action:'*')
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

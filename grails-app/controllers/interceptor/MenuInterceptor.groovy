package interceptor


class MenuInterceptor {

    MenuInterceptor(){
        match(controller:'*',action: 'index')
        match(controller:'saleStatistic',action:'*')
        match(controller:'finance',action:'*')
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

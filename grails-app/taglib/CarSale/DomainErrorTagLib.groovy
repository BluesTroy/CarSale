package CarSale

class DomainErrorTagLib {
//    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    def domainError = { attrs, body ->
        out << "<br/><ul class=\"list-group\"><li class=\"list-group-item list-group-item-danger\">提交内容有错误</li>"
        attrs.model.errors.allErrors.each { e ->
            out << "<li class=\"list-group-item\">"
            out << g.message(['error':e])
            out << "</li>"
        }
        out << "</ul>"
    }
}

//默认实体约束
grails.gorm.default.constraints = {
    '*' (nullable: true, blank: true)
}

//默认映射
grails.gorm.default.mapping = {
   cache true
   sort 'dateCreated'
   order 'desc'
}
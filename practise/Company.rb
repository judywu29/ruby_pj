class Company

    attr_accessor :name, :service_tell
    def initialize name, service_tell
        @name = name
        @service_tell = service_tell
    end

    #如果是用def 来打开类的话， 外面的变量： product_name, company会访问不到， 所以用define_method会比较方便。 除非不涉及到外部变量
    # def release_new_product product_name

    #     product = Object.const_set(product_name.capitalize, Class.new) # 定义一个名为name且值为value的常数后返回value, return a class with the name
    #     puts self ##<Company:0x007fa99a052788>
    #     company = self
    #     product.class_eval do
    #         def initialize
    #             @name = 'OK'#product_name
    #             puts self ##<Iphone6:0x007fa99a050690>
    #             # @company = company

    #         end
    #         attr_reader :company, :name
    #     end
    # end

    #factory pattern: 
    def release_new_product product_name

        Product = Object.const_set(product_name.capitalize, Class.new) # 定义一个名为name且值为value的常数后返回value, return a class with the name
        puts self ##<Company:0x007fa99a052788>
        company = self
        Product.class_eval do
            define_method :initialize do
                @name = product_name
                puts self ##<Iphone6:0x007fa99a050690>
                 @company = company

            end
            attr_reader :company, :name
        end
    end
end


company = Company.new("Apple", "123456")
company.release_new_product("iphone6")
p = Iphone6.new
puts p.name
puts p.company.service_tell
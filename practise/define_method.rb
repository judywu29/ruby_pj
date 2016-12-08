class Project1
    def self.create_method # or class<<self; def create_method
        define_method :new_method do
            puts "this is an new method"
        end
    end
    # create_method
end
Project1.create_method#只是定义了这个方法，并没有执行， 可以放在类里面
Project1.new.new_method

# class Project1
#     def create_method
#         self.class.send :define_method, :new_method do
#             puts "this is an new method"
#         end
#     end
# end

# Project1.new.create_method #只是定义了这个方法，并没有执行
# Project1.new.new_method#另外还要执行

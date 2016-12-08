#raise error as the subclasses of StandardError: rescue MyProject::Error
# module MyProject
  # class Error < StandardError
  # end
#   
  # class NotFoundError < Error
  # end
#   
  # class PermissionError < Error
  # end
# end
# 
# module MyProject
  # Error = Class.new(StandardError) #StandardError as parent
  # NotFoundError = Class.new(Error)
  # PermissionError = Class.new(Error)
# end


#总是让其他的异常作为Error的子类， 方式include Error或者extend Error， 然后raise 具体的一场类，捕获是用Error来捕获子类异常
=begin
 让Error作为父类， 或者mixin： include Error（作为module）（可能这种方式更好）： 或者extend Error（作为eigenclass）， 其实都是一样的 
 ancestor chain: NotFoundError, Error, StandardError
=end
module MyProject
  Error = Module.new
  
  class NotFoundError < StandardError
    include Error
  end
  
  class PermissionError < StandardError
    include Error
  end
  
  #define our own errors: use Error to rescue
  # Error = Class.new(StandardError) #StandardError as parent
  # NotFoundError = Class.new(Error)
  # PermissionError = Class.new(Error)
  
  def get path
    # response = do_get(path)
    raise NotFoundError, "#{path} not found" #if response.code == "404"
    response.body
  # rescue SocketError => e
    # e.extend Error
    # raise e
  end
end

begin
  include MyProject
  get("/example")
rescue MyProject::Error => e #Error is their parent/base class
  p e  ##<MyProject::NotFoundError: /example not found>
end
require 'drb/drb'

# class MathService
  # def add a, b
    # a + b
  # end
# end
# 
# class TimeServer
  # def get_current_time
    # Time.now
  # end
# end
# # service = MathService.new
# service = TimeServer.new
# DRb.start_service("druby://localhost:3030", service)
# DRb.thread.join


#and run this script in one window, then the service is start.
#and then run the client file: drb_client.rb in another window, the result is 4

#distributed ruby package

URI = "druby://localhost:8787"
class Logger
  include DRb::DRbUndumped #reference, remote object
  
  def initialize(n, fname)
    @name = n
    @filename = fname
  end
  
  def log message
    File.open(@filename, "a") do |f|
      f.puts %Q{
        #{Time.now}: #{@name}: #{message}
      }
    end
  end
end

class LoggerFactory
  def initialize bdir
    @basedir = bdir
    @loggers = {}
  end
  
  def get_logger name
    if !@loggers.has_key? name
      fname = name.gsub(/[.\/]/, "_").untaint
      @loggers[name] = Logger.new(name, @basedir + "/" + fname)
    end
    @loggers[name]
  end
end

object = LoggerFactory.new("dlog")
DRb.start_service(URI, object)














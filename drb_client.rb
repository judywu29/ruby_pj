require 'drb/drb'
DRb.start_service
# service = DRbObject.new_with_uri("druby://localhost:3030")
# sum = math_service.add(2,2)
# p sum

# puts service.get_current_time #2015-08-17 18:17:30 +1000

service = DRbObject.new_with_uri("druby://localhost:8787")
["loga", "Logb", "Logc"].each do |logname|
  logger = service.get_logger logname
  logger.log("hello world")
  logger.log("Goodbye, world")
  logger.log("===EOT===")
end

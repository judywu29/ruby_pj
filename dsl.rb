# event("we're earning wads of money"){
  # recent_orders = 12
  # recent_orders > 10
# }
setup do
  puts "Setting up sky"
  @sky_height = 100
end

setup do
  puts "Setting up mountains"
  @moutains_height = 200
end

event "the skky is falling" do
  @sky_height != @moutains_height
end

event "it's getting closer" do
  @sky_heigh != @moutains_height
end



require 'rack'

class HelloRack
  def call env
    [200, {"Content-Type"=>"text/html"}, ["hello rack!"]]
  end
end

Rack::Handler::Mongrel.run(HelloRack.new, :port=>3000)
# Rack::Handler::WEBrick.run(HelloRack.new, :port=>3000)


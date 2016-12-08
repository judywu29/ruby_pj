#from JSON to Hash and from Hash to JSON: 

data = '{
"name": "Aaron Patterson", 
"screen_name": "tenderlove",
"location:": "Seattle, WA"
}'

require 'json'
profile = JSON.parse(data)
p profile
=begin
 {"name"=>"Aaron Patterson", "screen_name"=>"tenderlove", "location:"=>"Seattle, WA"} 
=end

json_data = profile.to_json
=begin
 "{\"name\":\"Aaron Patterson\",\"screen_name\":\"tenderlove\",\"location:\":\"Seattle, WA\"}" 
=end

profile_2 = JSON.parse(json_data)
p profile_2
=begin
 {"name"=>"Aaron Patterson", "screen_name"=>"tenderlove", "location:"=>"Seattle, WA"} 
=end

contacts = {
  'John' =>{
    name: 'John',
    email: 'john@doe.com'
  },
  'Friday' =>{
    name: 'Freddy',
    email: 'freddy@mercury.com'
  }
}

# contacts['Jane'][:email] = 'jane@doe.com' #??
p contacts['Jane']





























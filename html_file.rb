

array = [

['Metrics','Campaign ID','Final URL', 'Day'],
[1,10,3],
[2,12,9],
[3,14,7],

]

myfile = File.new("html_test.html", "w+") 
myfile.puts "<html>"
myfile.puts "<title>html Page</title>"
myfile.puts "<body>"

myfile.puts "<div id=\"main\">"
myfile.puts "<h1>#{value}</h1>"

myfile.puts "<table border=\"1\">"
array.each do |row|
    myfile.puts "<tr>"
    row.each do |cell|
        myfile.puts "<td> #{cell} </td>"
    end
    myfile.puts "<tr>"
end

myfile.puts "</div>"

myfile.puts "<div id=\"side\">"
myfile.puts "</div>"

myfile.puts "</body>"
myfile.puts "</html>"
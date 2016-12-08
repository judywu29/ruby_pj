

require 'csv'

lambda{
  
  class Array
    def division other_array
       self.zip(other_array).map{|x,y| y == 0 ? 0.0 : (x.to_f/y).round(1)}
    end
  end

   
   class Numeric
     def to_money
      sprintf("$%.2f", self.to_f/1000000)
     end 
      
     def to_percentage
        sprintf("%.1f\%", self)
     end    
   end

  Output_keys = ["Campaign ID", "Final URL", "Day"]
  Method = {"highest"=> :max, "lowest"=> :min}
  Method_regex = /^(Highest)|(Lowest)/i
  
  input_file_name = ""
  my_array = []
  my_hash = Hash.new{|hash, key| hash[key] = []}
  output_values = []
  matrixes = []

  define_method :load do |*args|
    input_file_name = args.first.to_s
    puts input_file_name
    return unless input_file_name =~ /csv$/
    full_path = File.join(File.dirname(__FILE__), input_file_name) # __FILE__: current source file
    puts full_path
    CSV.foreach(full_path, headers: true, skip_blanks: true, converters: :all) do |row|
      next unless row.field("Campaign ID").is_a? Numeric #filtering invalid rows
      my_array << row.to_h
      row.each{|key, value| my_hash[key] << value  }
    end

  end
  
  define_method :get do |*args|
    return if args.empty? || my_hash.empty?
    method, *matrix_names = args
    return unless method.to_s =~ Method_regex 
    method.gsub!(Method_regex){|match| Method[match.downcase] }
    p matrix_names
    p matrix_names.map!(&:capitalize)
    matrix_names.map!(&:capitalize).each do |name|
      next if my_hash.keys.include? name
      first, last = name.split("/")
      next if first.nil? or last.nil?
      array_a, array_b = my_hash.values_at(first.to_s.strip, last.to_s.strip)
      next if array_a.empty? || array_b.empty?
      name.replace (name+"_division")
      my_hash[name] = array_a.division(array_b)
    end
    
    matrixes |= matrix_names
    p matrixes
    my_hash.values_at(*matrix_names).inject(output_values) do |output, x| 
      next if x.empty?
      value = x.send method #max or min
      output << my_array[x.index(value)].values_at(*Output_keys).unshift(value)
      output
    end
  end


  define_method :output do |*args|
    format = args.first.to_s
    return unless format == "html" or output_values.empty?
    p output_values

    #display setting: cost: convert to money
    matrixes.each_with_index do |name,index|
      if name =~ /cost/i
        puts name
        value = output_values[index][0]
        puts value
        # output_values[index][0] = value.to_money
      end
    end
    
    Output_keys.unshift("Metrics")
    fileHtml = File.new(input_file_name.gsub("csv", format), "w+") 
    fileHtml.puts "<html>"
    fileHtml.puts "<title>html Page</title>"
    fileHtml.puts "<body'>"
    fileHtml.puts "<h1><center>Ad performance reporting in August</center></h1>"
    fileHtml.puts "<div id=\"main\">" 
    fileHtml.puts "<table align=\"center\" border=\"1\">"
    fileHtml.puts "<tr>"
      Output_keys.each do |header|
        fileHtml.puts "<th bgcolor=\"grey\"> #{header} </th>"
      end
    fileHtml.puts "</tr>"
    output_values.each do |row|
      fileHtml.puts "<tr>"
      row.each do |cell|
          fileHtml.puts "<td> #{cell} </td>"
      end
      fileHtml.puts "</tr>"
     end  
    fileHtml.puts "</table>"   
    fileHtml.puts "</div>"     
    fileHtml.puts "<div id=\"side\">"
    fileHtml.puts "</div>"
    fileHtml.puts "</body>"
    fileHtml.puts "</html>"
    fileHtml.close()
 
  end
  
  eval(File.read('sorting_cmds.txt'))
  # p my_hash

}.call



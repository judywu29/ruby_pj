# def perm str, i = 0
  # p str if i == str.length
  # (i..str.size-1).each do |j|
    # str[i], str[j] = str[j], str[i]
    # puts "before perm: #{str}, i: #{i}, j: #{j}"
    # perm str, i+1
    # puts "after perm: #{str}, i: #{i}, j: #{j}"
    # str[i], str[j] = str[j], str[i]
  # end
# end

#n*2
def perm(str)
  result = []
  str_dup = str
  (0...str.length).each do |i|
    (0...str.length).each do |j|
      str[i], str[j] = str[j], str[i]
      result << str.dup
      str = str_dup
    end
  end
  result.uniq
end
p perm 'ABC' 
=begin test 
"ABC"
"ACB"
"BAC"
"BCA"
"CBA"
"CAB"
=end
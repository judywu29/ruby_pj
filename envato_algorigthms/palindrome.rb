#from http://www.geeksforgeeks.org/dynamic-programming-set-28-minimum-insertions-to-form-a-palindrome/
def min_for_palindrome str, left=0, right=nil
  str_reverse = str.reverse
  result = []
  (0...str.length).each do |i|
    str[i] == str_reverse[i] ? result << str[i] : result << str[i] << str_reverse[i] 
  end
  result.join
end

p min_for_palindrome 'geek' #2 -> kgeegk
#Palindrome，是指从其正反两个方向看都一样，且不区分大小写。翻译成回文

p min_for_palindrome 'abc' #2 -> kgeegk
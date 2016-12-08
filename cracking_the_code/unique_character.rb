
# Implement an algorithm to determine if a string has all unique characters.What if you can not use additional data structures?
def is_unique?(str)
  # flag = []
  # str.each_byte do |i|
    # return false if flag[i] > 1
    # flag[i] += 1
  # end
  # return true
  
  flag = 0
  str.each_byte do |i|
    puts i
    return false if flag[i] == 1
    flag |= 1 << i
  end
  return true
end



p is_unique?("smart") #true
p is_unique?("banana") #false

#Write code to reverse a C-Style String. (C-String means that “abcd” is represented as five characters, including the null character.)
def reverse(str)
  len = str.length
  (0...len/2).each do |i|
    str[i], str[len-i-1] = str[len-i-1], str[i]
  end
  str
end

puts reverse("column")

#Design an algorithm and write code to remove the duplicate charactersin a string without using any additional buffer. 
#NOTE: One or two additional variables are fine. An extra copy of the array is not.
def remove_duplicates(str)
  (0...str.length).each do |i|
    (i+1...str.length).each do |j|
      str[j] = '0' if str[i] == str[j]
    end
  end
  str.split("").select{ |x| x != '0' }.join("")

end

p remove_duplicates("banana")

#O(N)
#Write a method to decide if two strings are anagr
def is_anagrams(str1, dst)
  flag = 0
  (0...str1.length).each do |i|
    flag |= 1<<str1[i].ord
  end
  (0...dst.length).each do |i|
    flag ^= 1<<dst[i].ord
  end
  
  return true if flag == 0
  return false
  
end



#do the sort first(NLogN)
def quick_sort(str_arr)
  return [] if str_arr.empty?
  first, *remaining = str_arr
  left, right = remaining.partition{|i| i < first }
  quick_sort(left) + [first] + quick_sort(right)
end

def is_anagrams2(str, dst)
  return false if str.empty? || dst.empty?
  sorted_str1 = quick_sort(str.split(""))
  sorted_dst = quick_sort(dst.split(""))
  return true if sorted_str1 == sorted_dst
  return false
end

puts is_anagrams2("smart", "trams")
puts is_anagrams2("abc", "abd")

#Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes, write a method to 
#rotate the image by 90 degrees.Can you do this in place?
def rotate(arr, height, width)
  (0...width).each do |j|
    (0...height/2).each do |i|
      arr[i][j], arr[height - i - 1][j] = arr[height - i - 1][j], arr[i][j]
   end
  end
  (0...height).each do |i|
    (i...height).each do |j|
        arr[i][j], arr[j][i] = arr[j][i], arr[i][j]
   end
  end
  arr
end

original_arr = [[1,2,3,4], 
                [5,6,7,8],
                [9,10,11,12],
                [13,14,15,16]]
                
p rotate(original_arr, 4, 4)

#Write an algorithm such that if an element in an M*N matrix is 0,its entire row and column is set to 0.
def set_zeros(arr, height, width)
  m = n = 0
  (0...height).each do |i|
    (0...width).each do |j|
      m = i && n = j if arr[i][j] == 0
    end
  end
  (0...height).each do |i|
    arr[i][n] = 0
  end
  (0...width).each do |j|
    arr[m][j] = 0
  end
  arr
end

arr = [[1,2,3,7],
       [2,0,4,8],
       [5,6,7,9]]
p set_zeros(arr, 3, 4)

#it's substring after rotating
#Assume you have a method isSubstring which checks if one word is a substring of another. 
#Given two strings, s1 and s2, write code to check if s2 is a rotation of s1 using only one call 
#to isSubstring (i.e., “waterbottle” is a rotation of “erbottlewat”).
def is_substring?(str1, str2)
  
end
def is_rotating?(str1, str2)
  return false if (str1.length == 0 && str2.length == 0) || str1.length != str2.length
  str = str1 + str1
  return is_substring?(str, str2)
  
end
#it's substring after rotating
def reverse_str(str, num)
  str_str = str + str
  str_str[num...str.length+num]
end
p reverse_str("abcdefg", 3)

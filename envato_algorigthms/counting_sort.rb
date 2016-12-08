#all numbers need to be positive
#need extra memory: O(n+k)
def counting_sort(arr)
  max = arr.max
  c = Array.new(max+1, 0)
  arr.each { |i| c[i] += 1 } #[2, 2, 3, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1]
  (0..max).inject([]) do |array, index|
    (0...c[index]).each {|i| array << index } if c[index] != 0 #when there's no duplicated num, then only n times repetition
    array
  end
  
end
p counting_sort [7,20,12,3,2,2,2,1,1,0,0] # => [0, 0, 1, 1, 2, 2, 2, 3, 7, 12, 20]
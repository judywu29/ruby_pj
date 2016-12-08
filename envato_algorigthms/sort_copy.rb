#stable, doesn't use extra memory: O(n**2)
def insert_sort(arr)
  (1...arr.size).each do |i|
    key = arr[i]
    j = i-1
    while key < arr[j] && j >= 0
      arr[j+1] = arr[j]
      j -= 1
    end
    arr[j+1] = key
  end
  arr
end

p insert_sort([4,3,6,1,2,7,8,5,9,0])

#stable, from O(logN) to O(n**2, when left is [], already sorted), recursive stack: O(N)

def quick_sort(arr)
  return [] if arr.empty?
  first, *remaining = arr
  left, right = remaining.partition{ |x| x < first }
  quick_sort(left) + [first] + quick_sort(right)
end
p quick_sort([4,3,6,1,2,7,8,5,9,0])

def binary_search(arr, key)
  return -1 if arr.empty?
  min, max = 0, arr.size-1
  while min <= max
    mid = min + (max - min) / 2
    return mid if arr[mid] == key
    arr[mid] > key ? max = mid - 1 : min = mid + 1
  end
  return -1
end
  
ar = [23, 45, 67, 89, 123, 568]
p binary_search(ar, 23) #0
p binary_search(ar, 123) #4
p binary_search(ar, 120) #-1

#swap all the time
def bubble_sort(arr)
  for i in (arr.size-1).downto 0 do
    (0...i).each do |j|
      if arr[j] > arr[j+1]
        arr[j], arr[j+1] = arr[j+1], arr[j]
      end
    end
  end
  arr
end
p bubble_sort([4,3,6,1,2,7,8,5,9,0])

#also selection sort: O(n**2),
def cocktail_sort(arr)
  (0...arr.size/2).each do |f|
    (f...arr.size-f-1).each do |j|
      if arr[j] > arr[j+1]
        arr[j], arr[j+1] = arr[j+1], arr[j]
      end
      for i in (arr.size-f-1).downto(1) do
        arr[i], arr[i-1] = arr[i-1], arr[i] if arr[i] < arr[i-1]
      end
      
    end
  end
  arr
end

p cocktail_sort([4,3,6,1,2,7,8,5,9,0])

#stable, O(N**2), need extra memeory
def counting_sort(arr)
  work_list = Array.new(arr.max+1, 0)
  arr.each { |i| work_list[i] += 1 }
  result = []
  work_list.each_with_index do |i, index|
    i.times {|j| result << index } if i != 0
  end
  result
end

p counting_sort([7,20,12,3,2,2,2,1,1,0,0]) #[0, 0, 1, 1, 2, 2, 2, 3, 7, 12, 20]

#need extra memeory: sorted, O(NlogN), stable
def merge_sort(arr)
  return arr if arr.size == 1 #the last element, return array itself to end the recursion
  mid = arr.size / 2
  left_arr = arr[0...mid]
  right_arr = arr[mid..-1]
  merge(merge_sort(left_arr), merge_sort(right_arr))
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    sorted << (left.first <= right.first ? left.shift : right.shift)
  end
  sorted + left + right
end

p merge_sort([4,3,6,1,2,7,8,5,9,0])

# def shell_sort(arr)
  # size = arr.size
  # while (size = (size / 2)) >= 1
    # puts size
    # (0...arr.size).each do |i|
      # break if i+size == arr.size
      # puts arr[i]
      # puts arr[i+size]
      # arr[i], arr[i+size] = arr[i+size], arr[i] if arr[i] > arr[i + size]
    # end
    # p arr
  # end
  # arr
# end
# 
# p shell_sort([4,3,6,1,2,7,8,5,9,0])
#find the max and min: use max heap or min heap, sort: NLogN
def brackets(pairs, output='', open=0, close=0, arr = [])
  arr << output if open == pairs && close == pairs
  brackets(pairs, output + '(', open+1, close, arr) if open < pairs
  brackets(pairs, output + ')', open, close+1, arr) if close < open
  arr
end
p brackets(3) #["((()))", "(()())", "(())()", "()(())", "()()()"]

def maximum_sub_array2(arr)
  current = []
  max_sum = cur_sum = 0
  max = (0...arr.size).inject([]) do |max, i|
    current << arr[i]
    cur_sum += arr[i]
    if cur_sum > max_sum
      max << i
      max_sum = cur_sum
    end
    max
  end
  arr[max[0]..max[-1]]
end

puts maximum_sub_array2([-1, 2, 5, -1, 3, -2, 1]).join(",") #2,5,-1,3
puts maximum_sub_array2([3, 1, -2, 5, 4, 5, 0, -3, 0, 3, 5, -3, -4, -3, 5]).join(",") #3,1,-2,5,4,5,0,-3,0,3,5

#use fisher yates shuffle agorithm
def my_shuffle(arr)
  random_index = (0...arr.size).to_a.shuffle
  (0...arr.size).each do |i|
    index = random_index.pop
    arr[i], arr[index] = arr[index], arr[i]
  end
  arr
end

p my_shuffle([0,1,2,3,4,5,6,7,8,9])#[3, 5, 1, 4, 0, 2, 7, 8, 6, 9]


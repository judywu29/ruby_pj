# def insert_sort(arr)
  # (0...arr.length).each do |i|
    # key = arr[i]
    # j = i - 1
    # while(j >= 0 && arr[j] > key) #comparing each element with key, if they are all bigger than key, keeping swapping, or else insert
      # arr[j+1] = arr[j] #compare the front and back elements
      # j = j - 1
    # end
    # arr[j + 1] = key
  # end
  # arr
# end
# 
# p insert_sort([4,3,6,1,2,7,8,5,9,0])
# 
# def quick_sort(arr)
  # return [] if arr.empty?
  # first, *remaining = arr
  # left, right = remaining.partition{|x| x < first}
  # quick_sort(left) + [first] + quick_sort(right)
# end
# 
# p quick_sort([4,3,6,1,2,7,8,5,9,0])
# 
# #every time it makes the smallest element go up, if it has i+1, be careful about the bound
# def bubble_sort(arr)
  # (1...arr.length).each do |i|
    # (0...arr.length-i).each do |j|   #==============>it's different here, the toppest element are ordered
      # arr[j], arr[j+1] = arr[j+1], arr[j] if arr[j] > arr[j+1]
    # end
  # end
  # arr
# end
# 
# def bubble_sort2(arr)
  # (0...arr.size).each do |i|
    # for j in (arr.size-1).downto(i+1) do
      # arr[j], arr[j-1] = arr[j-1], arr[j] if arr[j] < arr[j-1]
    # end
  # end
# end
# p bubble_sort([4,3,6,1,2,7,8,5,9,0])
# p bubble_sort2([4,3,6,1,2,7,8,5,9,0])
# #divide and conque: merge_sort divide the arr into half until it cannot split, and then do merge from bottome
def merge_sort(arr)
  p arr
  return arr if arr.size <= 1 #don't divide anymore, just return itself
  half_size = arr.size / 2
  left = arr[0...half_size]
  right = arr[half_size..-1]
  puts "left: #{left}, right: #{right}"
  merge(merge_sort(left), merge_sort(right) )
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    sorted << (left.first <= right.first ? left.shift : right.shift)
  end
  p "sorted: #{sorted  + left + right}"
  sorted + left + right
end
p merge_sort([4,3,6,1,2,7,8,5,9,0])
# =begin
# left: [4, 3, 6, 1, 2], right: [7, 8, 5, 9, 0]
# left: [4, 3], right: [6, 1, 2]
# left: [4], right: [3]
# left: [6], right: [1, 2]
# left: [1], right: [2]
# left: [7, 8], right: [5, 9, 0]
# left: [7], right: [8]
# left: [5], right: [9, 0]
# left: [9], right: [0]
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] 
# =end
# 
# #push the biggest to the top, and push the smallest to the bottome at the same loop
# def cocktail_sort(arr)
  # f = 0
  # size = arr.size
  # while f < size / 2
    # (f...size-f-1).each do |i|
      # arr[i], arr[i+1] = arr[i+1], arr[i] if arr[i] > arr[i+1]
    # end
    # for j in (size-f-1).downto(f+1) do  #from biggest to smalleast, can only use this way, not(9..1).each, doesn't work
      # arr[j],arr[j-1] = arr[j-1], arr[j] if arr[j] < arr[j-1]
    # end
    # f += 1
  # end
  # arr
# end
# 
# p cocktail_sort([4,3,6,1,2,7,8,5,9,0])

def shell_sort(arr)
  gap = arr.size / 2
  until gap >= 1
    (0...gap).each do |i|
      j = i
      while j < arr.size
        arr[j], arr[j+gap] = arr[j+gap], arr[j] if arr[j] > arr[j+gap]
        j = j + gap
      end
    end
    gap, mod = gap.divmod(2)
    gap = mod == 0 ? gap + 1 : gap
  end
  arr
end

# p shell_sort([4,3,6,1,2,7,8,5,9,0])
Price = [6, 3, 5, 4, 6]
Weight = [2, 2, 6, 5, 4]

def bag_problem(i, sum)
  return (sum < Weight[5]) ? 0 : Price[5] if i == 5
  return bag_problem(i+1, sum) if sum < Weight[i]
  return [bag_problem(i+1, sum), bag_problem(i+1, sum-Weight[i])+Price[i]].max
end

p bag_problem(0, 10)

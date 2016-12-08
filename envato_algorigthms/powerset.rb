#powerset - subset of set
def powerset arr
  subset = (0...arr.size).inject([]) do |subset, i|
    subset << arr[0..i] << [arr[i]] << arr[i+1..-1]
    subset
  end.uniq!
end

p powerset [1,2,3,4] #[[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
#[[1], [2, 3, 4], [1, 2], [2], [3, 4], [1, 2, 3], [3], [4], [1, 2, 3, 4], []]
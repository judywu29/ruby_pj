#find a bigger number than num with the same digits
def bigger_with_same_digits(num)
  num_dup = num.to_s.split("").map(&:to_i).reverse
  (0...num_dup.size-1).each do |i|
    (i+1...num_dup.size).each do |j|
      if num_dup[i] > num_dup[j]
        num_dup[i], num_dup[j] = num_dup[j], num_dup[i]
        return num_dup.reverse.join.to_i
      end
    end
  end
end

p bigger_with_same_digits(38627) #38672
p bigger_with_same_digits(38621) #68321
=begin
 def bigger_with_sam_digits(num)
  num = num.to_s.chars.map(&:to_i) #convert int to array of ints
  return num.join.to_i if num.size < 2
  for left in (num.size-2).downto(0) do
    for right in (num.size-1).downto(left+1) do
      if num[right]>num[left]
        num[left],num[right] = num[right],num[left]
        return (num[0..left] + num[left+1..num.size-1].sort).join.to_i
      end
    end
  end
  return num.join.to_i
end 
=end
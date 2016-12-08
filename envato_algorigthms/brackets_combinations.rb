def brackets(pairs, output='', open=0, close=0, arr = [])
  arr << output if open == pairs and close == pairs    
  puts "before open: #{output}"  
  brackets pairs, output+'(', open+1, close, arr if open<pairs
  puts "before close: #{output}"
  brackets pairs, output+')', open, close+1, arr if close<open
  arr
end

p brackets(3) #["((()))", "(()())", "(())()", "()(())", "()()()"]
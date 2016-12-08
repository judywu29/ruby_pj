# def balanced_parentheses?(str)
  # return false if str.empty?
  # stack = []
  # str.split("").each do |letter|
    # case letter
    # when '('
      # stack << letter
    # when ')'
      # return false if stack.pop != '('
    # end
  # end
  # stack.empty?
# end
def balanced_parentheses?(str)
  return balanced?(str, [])
end
def balanced?(str, stack)
  return true if stack.empty? && str.empty?
  return false if str.empty? && !stack.empty?
  first, *remaining = str
  if first == "("
    stack << first
  elsif first  == ")" && stack.pop != "("
    return false
  end
  balanced?(remaining, stack)
end

p balanced_parentheses? '( () ( () ) () )'
p balanced_parentheses? '( () ( () ) ()' 
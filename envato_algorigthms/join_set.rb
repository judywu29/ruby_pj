def join_sets(set)
  first, *remaining = set
  p remaining #[["C", "D"], ["E"]]
  p *remaining #["C", "D"], ["E"]
  first.product(*remaining).map(&:join)
end

p join_sets([ ['A','B'] , ['C','D'], ['E'] ])

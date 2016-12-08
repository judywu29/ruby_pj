def n_times(thing)
	return lambda{|n| puts thing*n}
end

	proc = n_times(23)
	proc.call(3)
	p2 = n_times("OK")
	p2.call(4)
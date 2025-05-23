extends Node

func map(value, input_min, input_max, output_min, output_max):
	var x = value - input_min
	x = x * (output_max - output_min) / (input_max - input_min)
	x = x + output_min
	return x

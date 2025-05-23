class_name Trail
extends Line2D

@export var max_points: int

@onready var curve := Curve2D.new()

func _process(_delta):
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > max_points:
		curve.remove_point(0)
	points = curve.get_baked_points()

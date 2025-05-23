extends Node2D

@onready var paddle_spawn_point = $"Paddle Spawn Point".global_position
@onready var ball_spawn_point = $"Ball Spawn Point".global_position

var paddle = preload("res://scenes/player/paddle.tscn")
var ball = preload("res://scenes/player/ball.tscn")

func _ready():
	var new_paddle = paddle.instantiate()
	add_child(new_paddle)
	new_paddle.global_position = paddle_spawn_point
	
	var new_ball = ball.instantiate()
	add_child(new_ball)
	new_ball.global_position = ball_spawn_point
	new_ball.ball_out.connect(_on_ball_out)

func _on_ball_out():
	var new_ball = ball.instantiate()
	add_child(new_ball)
	new_ball.global_position = ball_spawn_point
	new_ball.ball_out.connect(_on_ball_out)

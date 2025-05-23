extends StaticBody2D

@export_category("Properties")
@export var speed: int

@export_category("Controls")
@export_enum("Keys", "Follow") var control_scheme: int
@export var dead_zone: int
@export var click_to_move: bool

@onready var sprite = $Paddle
@onready var paddle_center = $PaddleCenter

var target_position: Vector2

func _ready():
	await get_tree().process_frame
	target_position = Vector2(self.position.x, self.position.y)

func _process(delta):
	var direction = 0
	if control_scheme == 0:
		if Input.is_action_pressed("left"):
			direction = -1
		if Input.is_action_pressed("right"):
			direction = 1
	else:
		var mouse_pos = get_viewport().get_mouse_position().x
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or not click_to_move:
			if mouse_pos < paddle_center.global_position.x - dead_zone:
				direction = -1
			if mouse_pos > paddle_center.global_position.x + dead_zone:
				direction = 1
	target_position[0] += direction * speed * delta
	target_position[0] = clamp(target_position[0], 0, get_viewport().get_visible_rect().size.x - sprite.scale.x)
	self.position = self.position.lerp(target_position, 0.1)

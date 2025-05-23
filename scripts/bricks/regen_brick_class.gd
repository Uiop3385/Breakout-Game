class_name RegenBrick
extends Brick

@export_group("Configuration")
@export_enum("Constant", "Varying") var regen_mode: int = 0

@export_group("Properties")
@export_range(1, 5) var regen_amount: int = 1
@export_range(5, 30, 5, "suffix:sec") var base_regen_rate: int = 15
@export_range(2, 30, 2, "suffix:sec") var regen_started_rate: int = 5

@export_group("SFX")
@export var regen_sound: AudioStream

@onready var regen_timer = $RegenTimer
@onready var regen_started_timer = $RegenStartedTimer
@onready var regen_sfx = $RegenSFX

var regen_effect = preload("res://scenes/bricks/effects/brick_regen_effect.tscn")

func _ready():
	super()
	regen_timer.wait_time = base_regen_rate
	regen_timer.start()
	if regen_mode:
		regen_started_timer.wait_time = regen_started_rate
	regen_sfx.stream = regen_sound

func _process(_delta):
	super(_delta)

func _on_brick_hit():
	super()
	regen_timer.start()
	if regen_mode:
		regen_started_timer.stop()

func _on_brick_destroyed():
	super()

func _on_regen_timer_timeout():
	if health < base_health:
		var new_regen_effect = regen_effect.instantiate()
		health += regen_amount
		health = clamp(health, 0, base_health)
		add_sibling(new_regen_effect)
		new_regen_effect.position = self.global_position - Vector2(8, 8)
		print(self.global_position, "\n", new_regen_effect.global_position)
		regen_sfx.play()
		if regen_mode:
			regen_started_timer.start()
			regen_timer.stop()
		print(self, " has regenerated! it is now at ", health, "hp.")
		await new_regen_effect.animation_finished
		new_regen_effect.queue_free()
	print(self, " is already at max health, so it hasn't regenerated.")

func _on_regen_started_timer_timeout():
	if health < base_health:
		var new_regen_effect = regen_effect.instantiate()
		health += regen_amount
		health = clamp(health, 0, base_health)
		add_sibling(new_regen_effect)
		new_regen_effect.position = self.global_position - Vector2(8, 8)
		regen_sfx.play()
		await new_regen_effect.animation_finished
		new_regen_effect.queue_free()

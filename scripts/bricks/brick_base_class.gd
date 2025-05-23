@icon("res://game_assets/textures/bricks/brick_icon.png")
class_name Brick
extends StaticBody2D

signal brick_hit
signal brick_destroyed

@export_group("Properties")
@export_range(1, 5) var base_health: int = 1

@export_group("Graphics")
@export_subgroup("Textures")
@export var base_texture: Texture2D
@export_subgroup("Colors")
@export var health_colors: Array[Color]

@export_group("SFX")
@export var break_sound: AudioStream
@export var hit_sound: AudioStream

@onready var brick_sprite = $Brick
@onready var break_sfx = $BreakSFX
@onready var hit_sfx = $HitSFX

var health
var destroyed_effect = preload("res://scenes/bricks/effects/brick_destroyed_effect.tscn")

func _ready():
	health = base_health
	brick_sprite.texture = base_texture
	break_sfx.stream = break_sound
	hit_sfx.stream = hit_sound
	self.brick_hit.connect(_on_brick_hit)

func _process(_delta):
	update_sprite()

func update_sprite():
	brick_sprite.modulate = health_colors[health]

func _on_brick_hit():
	health -= 1
	print("brick ", self, " damaged! now at ", health, "hp.")
	if health <= 0:
		brick_destroyed.emit()
		return
	hit_sfx.play()

func _on_brick_destroyed():
	print("brick ", self, " destroyed!")
	var new_destroyed_effect = destroyed_effect.instantiate()
	add_sibling(new_destroyed_effect)
	new_destroyed_effect.position = self.global_position
	print(new_destroyed_effect.position)
	break_sfx.play()
	self.position.y = -INF
	await new_destroyed_effect.animation_finished
	new_destroyed_effect.queue_free()
	self.queue_free()

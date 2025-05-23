extends CharacterBody2D

signal ball_out

@export_category("Properties")
@export var speed: float = 200.0
@export var bounce_factor: float = 1.0
@export var sprite_size: int = 16

@onready var sprite = $Ball
@onready var ball_center = $BallCenter
@onready var bounce_sfx = $BounceSFX
@onready var death_sfx = $DeathSFX
@onready var trail = $Trail

var hit_effect = preload("res://scenes/bricks/effects/brick_hit_effect.tscn")
var cooldown = false

func _ready():
	velocity = Vector2(randf() * 2 - 1, 1).normalized() * speed

func _physics_process(delta):
	var motion = velocity * delta
	var collision = move_and_collide(motion)
	if collision:
		#velocity = velocity.bounce(collision.get_normal()) * bounce_factor
		var collider = collision.get_collider()
		print("collision detected with ", collider)
		if not collider.is_in_group("bricks"):
			if not cooldown:
				cooldown = true

				var paddle_center = collider.get_node("PaddleCenter").global_position
				# when switching to actual texture, replace .scale with .texture.get_width()
				var paddle_scale = collider.get_node("Paddle").scale

				var offset = ball_center.global_position.x - paddle_center.x

				if offset > 64 or offset < -64:
					position.y = paddle_center.y - (paddle_scale.y / 2) - sprite_size
					offset = clamp(offset, -64, 64)

				var mapped_offset = Utils.map(offset, -paddle_scale.x / 2, paddle_scale.x / 2, -1, 1)

				var direction = Vector2(mapped_offset, -1).normalized()
				velocity = direction * speed
				if ball_center.global_position.y > paddle_center.y:
					position.y = paddle_center.y - (paddle_scale.y / 2) - sprite_size
				bounce_sfx.play()

				await get_tree().create_timer(0.1).timeout
				cooldown = false
			else:
				print("collision above ignored; on cooldown")
		else:
			var normal = collision.get_normal()
			var impact_angle = normal.angle()
			var new_hit_effect = hit_effect.instantiate()
			add_sibling(new_hit_effect)
			new_hit_effect.position = collision.get_position() + normal * new_hit_effect.position.x
			new_hit_effect.rotation += impact_angle
			collider.brick_hit.emit()
			velocity = velocity.bounce(collision.get_normal()) * bounce_factor
			await new_hit_effect.animation_finished
			new_hit_effect.queue_free()

	var screen_size = Vector2(get_viewport().get_visible_rect().size.x - sprite_size, get_viewport().get_visible_rect().size.y - sprite_size)

	if position.x <= 0:
		position.x = 0
		velocity.x = abs(velocity.x)
		bounce_sfx.play()
	elif position.x >= screen_size.x:
		position.x = screen_size.x
		velocity.x = -abs(velocity.x)
		bounce_sfx.play()

	if position.y <= 0:
		position.y = 0
		velocity.y = abs(velocity.y)
		bounce_sfx.play()
	elif position.y >= screen_size.y + sprite_size:
		ball_out.emit()
		death_sfx.play()
		position.y = -INF
		await death_sfx.finished
		self.queue_free()

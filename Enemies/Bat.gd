extends KinematicBody2D

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
const BatDeathEffect = preload("res://Effects/BatDeathEffect.tscn")

export var acceleration = 300
export var max_speed = 50
export var friction = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

onready var stats = $Stats
onready var detection_zone = $PlayerDetectionZone
onready var soft_collisions = $SoftCollision

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			velocity = Vector2.ZERO
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = detection_zone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized() # global_position.direction_to(player.global_position) would also work
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
			else:
				state = IDLE

	if soft_collisions.is_colliding():
		velocity += soft_collisions.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)		


func seek_player():
	if detection_zone.can_see_player():
		state = CHASE

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	print(stats.health)
	knockback = area.knockback_vector * 120

func _on_Stats_no_health():	
	queue_free()
	var death_effect = BatDeathEffect.instance()
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position

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
onready var sprite = $AnimatedSprite
onready var detection_zone = $PlayerDetectionZone
onready var soft_collisions = $SoftCollision
onready var wander_controller = $WanderController

func _ready():
	state = pick_random_state()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			velocity = Vector2.ZERO
			seek_player()
			
			if wander_controller.get_time_left() == 0:
				state = pick_random_state()
				wander_controller.start_timer(rand_range(1, 3))
		WANDER:
			seek_player()
			
			if wander_controller.get_time_left() == 0:
				state = pick_random_state()
				wander_controller.start_timer(rand_range(1, 3))
			
			var direction = global_position.direction_to(wander_controller.target_position)
			var distance = global_position.distance_to(wander_controller.target_position)
			velocity = velocity.move_toward(direction * max_speed, distance * delta)
			sprite.flip_h = velocity.x < 0
			
		CHASE:
			var player = detection_zone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0

	if soft_collisions.is_colliding():
		velocity += soft_collisions.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)		


func seek_player():
	if detection_zone.can_see_player():
		state = CHASE

func pick_random_state():
	return [IDLE, WANDER].shuffle().pop_front()

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	print(stats.health)
	knockback = area.knockback_vector * 120

func _on_Stats_no_health():	
	queue_free()
	var death_effect = BatDeathEffect.instance()
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position


func _on_Timer_timeout():
	wander_controller.update_position()

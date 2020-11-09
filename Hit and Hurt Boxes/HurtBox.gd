extends Area2D

var invincible = false setget set_invincible

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

signal invincible_started
signal invincible_ended

func set_invincible(value):
	invincible = value
	if invincible:
		emit_signal("invincible_started")
	else:
		emit_signal("invincible_ended")
		
func start_invicibility(duration):
	self.invincible = true
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false

func _on_HurtBox_invincible_started():
	collisionShape.set_deferred("disabled", true)

func _on_HurtBox_invincible_ended():
	collisionShape.set_deferred("disabled", false)

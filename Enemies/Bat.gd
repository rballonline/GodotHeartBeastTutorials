extends KinematicBody2D

var knockback = Vector2.ZERO
const BatDeathEffect = preload("res://Effects/BatDeathEffect.tscn")

onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	print(stats.health)
	knockback = area.knockback_vector * 120

func _on_Stats_no_health():	
	queue_free()
	var death_effect = BatDeathEffect.instance()
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position

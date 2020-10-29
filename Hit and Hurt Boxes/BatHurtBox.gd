extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

func _on_HurtBox_area_entered(area):
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position - Vector2(0, 12)

extends Node2D

onready var tween = $Tween
onready var sprite = $CanvasLayer/AnimatedSprite
onready var audio = $AudioStreamPlayer

func play(position):
	PlayerStats.add_money(1)
	print("Coin play()")
	sprite.set_global_position(position)
	audio.play()
	tween.interpolate_property(sprite, "modulate:a", 0.0, 1.0, 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
#	tween.interpolate_property(sprite, "scale", sprite.scale, Vector2(1.0, 1.0), 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
#	tween.interpolate_property(sprite, "modulate:a", 1.0, 0.0, 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.interpolate_property(sprite, "position", sprite.position, Vector2(288, 8), 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()

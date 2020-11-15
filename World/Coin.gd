extends Node2D

onready var tween = $Tween
onready var layer = $CanvasLayer
onready var sprite = $CanvasLayer/AnimatedSprite

func play(global_position):
	print("Show coin!")
	var ending_location = Vector2(310, 10)
	
	
	#sprite.set_global_position(global_position)
	
#	print(get_global_transform().affine_inverse().xform(ending_location))
#	print(get_global_transform().xform(ending_location))
	
	#ending_location = transform.xform(ending_location)
	print(get_global_transform().get_origin())
	print(global_position)
	var local_position = layer.transform.xform_inv(global_position)
	print(local_position)
	print(Vector2(sprite.position.x, sprite.position.y))
	
	tween.interpolate_property(sprite, "modulate:a", 0, 1, 1, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(sprite, "position:x", local_position.x, ending_location.x, 1, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.interpolate_property(sprite, "position:y", local_position.y, ending_location.y, 1, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
	#queue_free()

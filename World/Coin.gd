extends Node2D

onready var tween = $Tween
onready var collection = $CanvasLayer/CoinCollection
onready var coin = $CoinAnchor
onready var audio = $AudioStreamPlayer

export(int) var amount = 1

func play(position, global_position):
	print("Coin play()")
	coin.position = position
	collection.set_global_position(global_position)
	audio.play()
	tween.interpolate_property(collection, "modulate:a", 0.0, 1.0, 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
	coin.visible = false
	collection.visible = true
	tween.interpolate_property(collection, "position", collection.position, Vector2(288, 8), 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()
	PlayerStats.add_money(amount)

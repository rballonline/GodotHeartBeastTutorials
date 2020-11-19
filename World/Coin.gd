extends Node2D

onready var tween = $Tween
onready var coin = $CanvasLayer/AnimatedCoin
onready var audio = $AudioStreamPlayer

export(int) var amount = 1

func play(position):
	print("Coin play()")
	coin.set_global_position(position)
	tween.interpolate_property(coin, "position", coin.position, Vector2(288, 8), 0.5, Tween.EASE_IN, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()
	PlayerStats.add_money(amount)

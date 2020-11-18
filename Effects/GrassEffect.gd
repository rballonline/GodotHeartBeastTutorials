extends "res://Effects/Effect.gd"

var Coin = preload("res://World/Coin.tscn")

func reveal():
	var number = rand_range(1, 3)
	print(str(number))
#	if number <= 2:
	var coin = Coin.instance()
	get_parent().add_child(coin)
	coin.play(position + Vector2(8, 8), get_global_transform_with_canvas().get_origin() + Vector2(8, 8))

extends Node2D

onready var text = $RichTextLabel
onready var coin_drop_sound = $CoinDropSound

var _current_money = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(PlayerStats.connect("money_changed", self, "money_changed") == OK)
	
func money_changed(value):
	text.text = str(value).pad_zeros(4)
	if _current_money < value:
		coin_drop_sound.play()

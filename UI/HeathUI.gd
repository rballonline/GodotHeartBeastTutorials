extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var full = $HealthUIFull
onready var empty = $HeathUIEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	full.rect_size.x = hearts * 15
	
func set_max_hearts(value):
	max_hearts = value
	if empty != null:
		empty.rect_size.x = max_hearts * 15
	
func _ready():
	self.hearts = PlayerStats.health
	self.max_hearts = PlayerStats.max_health
	PlayerStats.connect("health_changed", self, "set_hearts")

extends Node2D

export(int) var wander_range = 32

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func _ready():
	update_position()

func update_position():
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func start_timer(duration):
	timer.start(duration)

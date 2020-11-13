extends Node

export(int) var max_health := 1
onready var health = max_health setget set_health
onready var money := 0

signal no_health
signal health_changed(value)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func add_money(value: int):
	money += value

func subtract_money(value: int):
	money -= value

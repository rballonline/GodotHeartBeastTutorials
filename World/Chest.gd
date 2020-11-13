extends StaticBody2D

enum { CLOSED, OPENED }

onready var animation = $Animation

export var state = CLOSED

func _on_HurtBox_area_entered(area):
	animation.play()

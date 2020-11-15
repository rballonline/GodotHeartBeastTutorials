class_name NPC
extends Node2D

#signal start_talking()
signal end_talking(Node)

func _ready():
	add_to_group("NPC")


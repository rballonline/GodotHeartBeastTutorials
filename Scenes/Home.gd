extends Node2D

func _ready():
	randomize()
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		SceneChanger.change_scene("res://Scenes/Menu.tscn")

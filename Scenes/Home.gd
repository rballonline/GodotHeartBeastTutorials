extends Node2D

onready var menu = $CanvasLayer/Menu

func _ready():
	randomize()
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		menu.visible = !menu.visible

extends Node2D

onready var dialog_box = $CanvasLayer/DialogBox

var current_player = null

func _on_NoAttackZone_body_entered(player : Player):
	player.set_can_attack(false)
	current_player = player

func _on_NoAttackZone_body_exited(player):
	player.set_can_attack(true)
	player = null

func _on_HurtBox_area_entered(area):
	dialog_box.visible = true
	dialog_box.start()
	current_player.set_state(3)

func _on_DialogBox_done_talking():
	current_player.set_state(Player.MOVE)

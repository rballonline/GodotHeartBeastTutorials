extends Node2D

func _on_NoAttackZone_body_entered(player : Player):
	player.set_can_attack(false)


func _on_NoAttackZone_body_exited(player):
	player.set_can_attack(true)


func _on_HurtBox_area_entered(area):
	pass # Replace with function body.

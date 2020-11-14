extends NPC

onready var dialog_box = $CanvasLayer/DialogBox
onready var hurt_box = $HurtBox

func on_talk():	
	hurt_box.set_invincible(true)
	dialog_box.start()

func _on_NoAttackZone_body_entered(player : Player):
	player.set_can_attack(false)

func _on_NoAttackZone_body_exited(player):
	player.set_can_attack(true)

func _on_DialogBox_done_talking():
	emit_signal("end_talking", self)
	hurt_box.start_invicibility(0.5)

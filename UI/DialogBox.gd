extends Node2D

onready var label: RichTextLabel = $ColorRect/RichTextLabel
onready var timer: Timer = $Timer

signal done_talking

var dialog := ["Yo bitch. I'm Santa Claus. I wanna FIGHT!", "Fighting is great. Keeps me fit!"]
var page := 0

func start():
	visible = true
	label.set_visible_characters(0)
	label.set_bbcode(dialog[page])
	timer.start()
	
func _input(event):
	if visible and event.is_action_pressed("attack"):
		if label.get_visible_characters() < label.get_total_character_count():
			label.set_visible_characters(label.get_total_character_count())
		else:
			if page < dialog.size() - 1:
				page += 1
				start()
			else:
				visible = false
				emit_signal("done_talking")

	

func _on_Timer_timeout():
	label.set_visible_characters(label.get_visible_characters() + 1)
	if label.get_visible_characters() == label.get_total_character_count():
		timer.stop()


extends Node2D

onready var label: RichTextLabel = $ColorRect/RichTextLabel
onready var timer: Timer = $Timer

signal done_talking

var dialog := ["Yo bitch. I'm Santa Claus. I wanna FIGHT!", "Fighting is great. Keeps me fit!"]
var page := 0
var started = false

func start():	
	print("Starting text")
	visible = true
	label.set_visible_characters(0)
	label.set_bbcode(dialog[page])
	timer.start()
	
func _physics_process(_delta):
	if visible and Input.is_action_just_pressed("attack"):
		if label.get_visible_characters() < label.get_total_character_count():
			label.set_visible_characters(label.get_total_character_count())
			print("Reveal all text")
		else:
			if page < dialog.size() - 1:
				page += 1
				start()
				print("Next page")
			else:
				visible = false
				page = 0
				print("Done talking")
				emit_signal("done_talking")

	

func _on_Timer_timeout():
	label.set_visible_characters(label.get_visible_characters() + 1)
	if label.get_visible_characters() == label.get_total_character_count():
		timer.stop()


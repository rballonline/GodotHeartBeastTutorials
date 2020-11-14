extends RichTextLabel

var dialog = ["Yo bitch. I'm Santa Claus. I wanna FIGHT!", "Fighting is great. Keeps me fit!"]
var page := 0
onready var timer: Timer = $Timer

func start():
	set_visible_characters(0)
	visible = true
	set_bbcode(dialog[page])
	timer.start()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if get_visible_characters() < get_total_character_count():
			set_visible_characters(get_total_character_count())
			pass
		if page < dialog.len():
			page += 1
			start()
		else:
			visible = false

	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if get_visible_characters() == get_total_character_count():
		timer.stop()

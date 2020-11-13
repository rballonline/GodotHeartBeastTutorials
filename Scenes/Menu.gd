extends TextureRect

func _ready():
	pass # Replace with function body.

func _on_Back_pressed():
	visible = false

func _on_Quit_pressed():
	get_tree().quit()

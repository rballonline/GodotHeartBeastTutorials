extends TextureRect

func _on_Quit_pressed():
	print("Quit")
	get_tree().quit()

func _on_Start_pressed():
	print("Start")
	SceneChanger.change_scene("res://Scenes/Home.tscn")

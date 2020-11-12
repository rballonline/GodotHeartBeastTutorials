extends TextureRect

func _ready():
	SceneChanger.fade($BackgroundMusic, 0.5)

func _on_Quit_pressed():
	print("Quit")
	get_tree().quit()

func _on_Start_pressed():
	print("Start")
	get_node("/root/SceneChanger").change_scene("res://Maps/Home.tscn")

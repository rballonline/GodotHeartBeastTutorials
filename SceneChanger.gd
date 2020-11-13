extends CanvasLayer

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var control = $Control
onready var tween = $Tween

func change_scene(path, delay = 0.0):
	var current_background_music: AudioStreamPlayer = get_tree().get_current_scene().find_node("BackgroundMusic")
	if current_background_music != null:
		tween.interpolate_property(current_background_music, "volume_db", 0, -80, 0.2, Tween.TRANS_SINE, Tween.EASE_IN, delay)
		tween.start()
		yield(tween, "tween_completed")
		current_background_music.stop()
		
	control.visible = true
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	control.visible = false

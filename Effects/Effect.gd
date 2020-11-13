extends AnimatedSprite


func _ready():
	playing = true
	frame = 0
	play()
	var f = connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished():
	queue_free()

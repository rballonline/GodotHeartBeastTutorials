extends AnimatedSprite


func _ready():
	playing = true
	frame = 0
	play()
	assert(connect("animation_finished", self, "_on_animation_finished") == OK)

func _on_animation_finished():
	queue_free()

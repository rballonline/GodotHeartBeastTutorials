extends CanvasLayer

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var control = $Control

var _tracks = []
var _volume = 1.0


func change_scene(path, delay = 0.5):
	var current_scene = get_tree().get_current_scene()
	var gbp = current_scene.get_node("BackgroundPlayer")
		
	control.visible = true
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	control.visible = false

class Track:
	var player = null
	var fade_speed = null
	var fade_value = 0.0
	var wait_time = null
	var play_offset = 0
	
	func is_active():
		return player.is_playing() or (wait_time != null)
	
	func stop():
		player.stop()
		fade_speed = null
		wait_time = null
		fade_value = 0.0

func fade(stream, prev_duration, next_duration=null, next_delay=0.0, offset=0):
	if typeof(stream) == TYPE_STRING:
		stream = load(stream)
	var next_track = null
	if stream != null:
		# Fade in next track
		next_track = _get_free_track(stream)
		fade_in(next_track, next_duration, next_delay, stream, offset)
	# Fade out whatever was playing before
	for other_track in _tracks:
		if other_track != next_track and other_track.is_active():
			fade_out(other_track, prev_duration)

func fade_in(track, duration, delay, stream, offset=0):
	if stream != null:
		track.player.set_stream(stream)
	
	track.wait_time = delay
	if delay == null:
		track.player.play(offset)
	else:
		track.play_offset = offset
	
	if duration == null or duration < 0.001:
		track.fade_speed = null
		track.fade_value = 1.0
		track.player.set_volume(_volume)
	else:
		track.fade_speed = 1.0 / duration
		track.player.set_volume(track.fade_value)


func fade_out(track, duration):
	if track.wait_time != null:
		track.stop()
	else:
		if duration == null or duration < 0.001:
			track.fade_speed = null
			track.fade_value = 0.0
			track.player.set_volume(0.0)
		else:
			track.fade_speed = -1.0 / duration
			track.player.set_volume(track.fade_value)
			
func _get_free_track(stream):
	if stream != null:
		# First find a track that plays our song already
		for track in _tracks:
			if track.player.get_stream() == stream:
				return track
	# Otherwise, find a free track
	for track in _tracks:
		if track.is_active() == false:
			return track
	# If all else fails, create a new track
	var track = Track.new()
	track.player = AudioStreamPlayer.new()
	add_child(track.player)
	_tracks.append(track)
	return track

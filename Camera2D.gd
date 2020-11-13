extends Camera2D

onready var top_left = $Limits/TopLeft
onready var bottom_right = $Limits/BottomRight
onready var top_barrier: CollisionShape2D = $Barriers/TopBarrier/CollisionShape2D
onready var bottom_barrier: CollisionShape2D = $Barriers/BottomBarrier/CollisionShape2D
onready var left_barrier: CollisionShape2D = $Barriers/LeftBarrier/CollisionShape2D
onready var right_barrier: CollisionShape2D = $Barriers/RightBarrier/CollisionShape2D

const extents_size := 8 # I didn't want to calculate this so just set the sizes of the CollisionShape2D's to 8x8

func _ready():
	limit_top = top_left.position.y
	limit_left = top_left.position.x
	limit_bottom = bottom_right.position.y
	limit_right = bottom_right.position.x
	
	var screen_size := get_viewport_rect().size
	
	# Player's bounding box that interacts with world is towards feet so this affects
	# the barrier's positions. Positions reflect keeping the player within the 
	# camera bounds
	
	var vertical_extents = Vector2((bottom_right.position.x - top_left.position.x) / 2, extents_size)
	var vertical_x_pos = screen_size.x / 2
	
	top_barrier.position.x = vertical_x_pos
	top_barrier.position.y = top_left.position.y + 10
	top_barrier.get_shape().set_extents(vertical_extents)
	
	bottom_barrier.position.x = vertical_x_pos
	bottom_barrier.position.y = bottom_right.position.y + 9
	bottom_barrier.get_shape().set_extents(vertical_extents)
		
	var horizontal_extents = Vector2(extents_size, ((bottom_right.position.y - top_left.position.y) / 2) + extents_size)
	var horizontal_y_pos = (screen_size.y / 2)  + extents_size
	
	left_barrier.position.x = top_left.position.x + 3
	left_barrier.position.y = horizontal_y_pos
	left_barrier.get_shape().set_extents(horizontal_extents)
	
	right_barrier.position.x = bottom_right.position.x + 5
	right_barrier.position.y = horizontal_y_pos
	right_barrier.get_shape().set_extents(horizontal_extents)

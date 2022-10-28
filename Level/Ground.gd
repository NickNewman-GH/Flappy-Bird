extends StaticBody2D

var velocity = Vector2(-1, 0)
var speed = 150
var screen_size
var size
var travelled_distance = 0

func reset_position():
	position.x = size.x * 5

func _ready():
	screen_size = get_viewport().size
	print($CollisionShape2D.shape.extents)
	size = $CollisionShape2D.shape.extents
	#position.y = screen_size.y
	#reset_position()

func _process(delta):
	position += velocity * speed * delta
#	travelled_distance -= velocity.x * speed * delta
#	print(travelled_distance)
#	if travelled_distance >= 150:
#		position.x += travelled_distance
#		travelled_distance = 0

func stop():
	speed = 0

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	reset_position()

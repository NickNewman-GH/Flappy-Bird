extends StaticBody2D

var velocity = Vector2(-1, 0)
var speed = 150
var screen_size
var travelled_distance = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	position.y = screen_size.y

func _process(delta):
	position += velocity * speed * delta
	travelled_distance -= velocity.x * speed * delta
	print(travelled_distance)
	if travelled_distance >= 150:
		position.x += travelled_distance
		travelled_distance = 0

func stop():
	speed = 0

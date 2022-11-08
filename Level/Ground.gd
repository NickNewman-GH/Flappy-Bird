extends StaticBody2D

var velocity = Vector2(-1, 0)
var speed = 150
var screen_size
var size
var isLeft = true

func reset_position(posx):
	position.x = posx

func _ready():
	screen_size = get_viewport().size
	size = $CollisionShape2D.shape.extents

func _process(delta):
	position += velocity * speed * delta

func stop():
	speed = 0
	
func start():
	speed = 150

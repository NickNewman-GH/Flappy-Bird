extends Node2D

var velocity = Vector2(-1, 0)
var speed = 150

var pipes = ["res://assets/sprites/pipe-green.png", "res://assets/sprites/pipe-red.png"]

func _process(delta):
	position += velocity * speed * delta

func stop():
	speed = 0
	
func start():
	speed = 150
	
func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func disable_collision_shapes():
	$LowerWall/CollisionShape2D.disabled = true
	$UpperWall/CollisionShape2D.disabled = true
	$ScoreArea/CollisionShape2D.disabled = true

extends KinematicBody2D

signal game_over

var gravity = 0
var flapStrength = 0
const maxFallingSpeed = 600
var velocity = Vector2.ZERO
var animations = ["Blue fly", "Yellow fly", "Red fly"]

func random_animation():
	$AnimatedSprite.animation = animations[randi() % 3]

func _ready():
	$AnimatedSprite.play()

func start():
	gravity = 1600
	flapStrength = 400
	flap()
	
func reset(pos):
	position = pos
	gravity = 0
	velocity.y = 0
	rotation_degrees = 0
	$AnimatedSprite.play()
	$AnimatedSprite.speed_scale = 1
	
func flap():
	if flapStrength != 0: velocity.y = -flapStrength
	
func rotateUP(delta):
	rotation_degrees -= 720 * 2 * delta
	if rotation_degrees < -15: 
		rotation_degrees = -15
		
func flyAnimation():
	$AnimatedSprite.play()
	$AnimatedSprite.speed_scale = 2
	
func stopFlyAnimation():
	$AnimatedSprite.frame = 1
	$AnimatedSprite.stop()
	
func changeVelocity(delta):
	velocity.y += gravity * delta
	if velocity.y > maxFallingSpeed:
		velocity.y = maxFallingSpeed
		
func rotateDown(delta):
	rotation_degrees += velocity.y * delta
	if rotation_degrees > 90:
		rotation_degrees = 90
	
func _physics_process(delta):
	if gravity == 0:
		position.y += cos(OS.get_ticks_msec() / 100)
	changeVelocity(delta)

	if velocity.y > 0:
		rotateDown(delta)
		if rotation_degrees > -5 and $AnimatedSprite.frame == 1:
			stopFlyAnimation()
	if Input.is_action_just_pressed("click"):
		flap()
	if velocity.y < 0:
		rotateUP(delta)
		flyAnimation()
		
	var object = move_and_collide(velocity * delta)
	if object: emit_signal("game_over")

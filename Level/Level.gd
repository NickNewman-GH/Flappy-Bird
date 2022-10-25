extends Node
export(PackedScene) var obstacle_scene

var screen_size
var isGameStarted = false
var score = 0

func _ready():
	randomize()
	screen_size = get_viewport().size
	$Player.position = Vector2(screen_size.x/2 - 75, screen_size.y/2)
	#spawnObstacle()

func _process(delta):
	if not isGameStarted and Input.is_action_just_pressed("click"):
		start_game()
		isGameStarted = true
		
func start_game():
	score = 0
	#$Player.position = Vector2(screen_size.x/2 - 75, screen_size.y/2)
	$Player.start()
	$StartTimer.start()

func spawn_obstacle():
	var obstacle = obstacle_scene.instance()
	obstacle.get_node("ScoreArea").connect("body_entered", self, "_on_obstacle_score_changed")
	obstacle.position = Vector2(screen_size.x + 50, rand_range(75, screen_size.y - 75))
	add_child(obstacle)

func _on_SpawnDelayTimer_timeout():
	spawn_obstacle()

func _on_StartTimer_timeout():
	$SpawnDelayTimer.start()

func game_over():
	get_tree().call_group('ObstacleGroup', 'stop')
	get_tree().call_group('ObstacleGroup', 'disable_collision_shapes')
	$SpawnDelayTimer.stop()
	$Player.flapStrength = 0

func _on_obstacle_score_changed(body):
	score += 1
	print(score)

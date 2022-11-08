extends Node
export(PackedScene) var green_obstacle_scene
export(PackedScene) var red_obstacle_scene

var screen_size
var isGameStarted = false
var score = 0
var isGameOver = false
var backgrounds = ["res://assets/sprites/background-day.png", "res://assets/sprites/background-night.png"]
var obstacle_scene
var change_timer_once = false

func random_background():
	$Background.texture = load(backgrounds[randi() % 2])
	
func random_pipe():
	obstacle_scene = [green_obstacle_scene, red_obstacle_scene][randi() % 2]
	
func randomize_sprites():
	random_background()
	random_pipe()
	$Player.random_animation()

func _ready():
	randomize()
	$HUD.show_startgame()
	screen_size = get_viewport().size
	$Player.position = Vector2(screen_size.x/2 - 75, screen_size.y/2)
	randomize_sprites()

func _process(delta):
	if not isGameOver and not isGameStarted and Input.is_action_just_pressed("click"):
		start_game()
		isGameStarted = true
	if $Ground.position.x < -168:
		$Ground.position.x = $Ground.size.x
		$Ground2.position.x = $Ground.size.x * 3
	if isGameOver and Input.is_action_just_pressed("click"):
		restart_game()
	if not isGameOver and isGameStarted:
		if not change_timer_once and score > 10:
			$SpawnDelayTimer.wait_time -= 0.5
			change_timer_once = true
		if score > 25:
			$SpawnDelayTimer.wait_time = rand_range(1, 1.5)
		
func start_game():
	$HUD.hide_startgame()
	$Player.start()
	$StartTimer.start()
	
func restart_game():
	$HUD.show_restart_effect()
	$RestartTimer.start()

func spawn_obstacle():
	var obstacle = obstacle_scene.instance()
	obstacle.get_node("ScoreArea").connect("body_entered", self, "_on_obstacle_score_changed")
	obstacle.position = Vector2(screen_size.x + 50, rand_range(75, screen_size.y - 175))
	add_child(obstacle)

func _on_SpawnDelayTimer_timeout():
	spawn_obstacle()

func _on_StartTimer_timeout():
	$SpawnDelayTimer.start()

func game_over():
	if not isGameOver:
		$DieSound.play()
		$HitSound.play()
		$HUD.show_hit_effect()
		$HUD.show_gameover()
	get_tree().call_group('ObstacleGroup', 'stop')
	get_tree().call_group('ObstacleGroup', 'disable_collision_shapes')
	get_tree().call_group('GroundGroup', 'stop')
	$Player.stopFlyAnimation()
	isGameOver = true
	$SpawnDelayTimer.stop()
	$Player.flapStrength = 0

func _on_obstacle_score_changed(body):
	score += 1
	$PointSound.play()
	$HUD.change_score(str(score))

func _on_RestartTimer_timeout():
	score = 0
	$HUD.change_score(str(score))
	isGameStarted = false
	isGameOver = false
	$HUD.show_startgame()
	$HUD.show_score()
	$HUD.hide_gameover()
	$Player.reset(Vector2(screen_size.x/2 - 75, screen_size.y/2))
	get_tree().call_group('ObstacleGroup', 'start')
	get_tree().call_group('GroundGroup', 'start')
	get_tree().call_group('ObstacleGroup', 'destroy')
	randomize_sprites()
	$StartTimer.wait_time = 2
	$StartTimer.stop()

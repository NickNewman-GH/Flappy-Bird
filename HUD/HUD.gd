extends CanvasLayer

func show_startgame():
	$StartGame.visible = true
	$StartGame/AnimationPlayer.play("Show")

func show_gameover():
	$GameOverTimer.start()
	
func hide_startgame():
	$StartGame/AnimationPlayer.play("Hide")

func hide_gameover():
	$GameOver.visible = false

func change_score(text):
	$Score.text = text

func hide_score():
	$Score.visible = false

func show_score():
	$Score.visible = true
	
func show_hit_effect():
	$HitEffect.play("Hit")
	
func show_restart_effect():
	$GameOverTimer.stop()
	$RestartEffect.play("Restart")

func _on_GameOverTimer_timeout():
	hide_score()
	$GameOver/AnimationPlayer.play("Show Game Over")
	$GameOverSound.play()
	$GameOver.visible = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hide":
		$StartGame.visible = false

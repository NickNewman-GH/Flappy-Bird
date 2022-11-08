extends CanvasLayer

func show_startgame():
	$StartGame.visible = true

func show_gameover():
	$GameOver.visible = true
	
func hide_startgame():
	$StartGame.visible = false

func hide_gameover():
	$GameOver.visible = false

func change_score(text):
	$Score.text = text

func hide_score():
	$Score.visible = false

func show_score():
	$Score.visible = false

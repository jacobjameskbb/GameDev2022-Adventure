extends Control

func _on_StartButton_pressed():
	$FadeToBlack.show()
	$FadeToBlack.fadeToBlack()


func _on_FadeToBlack_fade_finished():
	get_tree().change_scene("res://Scenes/Intro.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("F11"):
		OS.window_fullscreen = !OS.window_fullscreen

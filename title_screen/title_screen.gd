extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	
	
	#F11 Puts it in fullscreen
func _process(delta):
	if Input.is_action_just_pressed("F11"):
		OS.window_fullscreen = !OS.window_fullscreen

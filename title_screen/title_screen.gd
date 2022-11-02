extends Control

func _on_StartButton_pressed():
	$FadeToBlack.show()
	$FadeToBlack.fadeToBlack()


func _on_FadeToBlack_fade_finished():
	get_tree().change_scene("res://Scenes/Intro.tscn")

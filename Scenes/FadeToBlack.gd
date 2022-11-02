extends ColorRect

signal fade_finished

func fadeToBlack():
	$AnimationPlayer.play("FadeToBlack")

func _on_AnimationPlayer_animation_finished(FadeToBlack):
	emit_signal("fade_finished")

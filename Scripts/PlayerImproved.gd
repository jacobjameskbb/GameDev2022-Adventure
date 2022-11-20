extends KinematicBody2D

export var speed := 150.0
var facing

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	var move_direction := input_vector.normalized()
	move_and_slide(speed*move_direction)
	print(move_direction)
	if move_direction==Vector2(0,0):
		$AnimatedSprite.stop()
		if facing=="d":
			$AnimatedSprite.animation = "idle_down"
		if facing=="u":
			$AnimatedSprite.animation = "idle_up"
		if facing=="r":
			$AnimatedSprite.animation = "idle_right"
		if facing=="l":
			$AnimatedSprite.animation = "idle_left"
	if move_direction==Vector2(0,1):
		$AnimatedSprite.animation = "walk_down"
		facing="d"
	if move_direction==Vector2(0,-1):
		$AnimatedSprite.animation = "walk_up"
		facing="u"
	if move_direction==Vector2(1,0):
		$AnimatedSprite.animation = "walk_right"
		facing="r"
	if move_direction==Vector2(-1,0):
		$AnimatedSprite.animation = "walk_left"
		facing="l"
	print(facing)
	$AnimatedSprite.play()

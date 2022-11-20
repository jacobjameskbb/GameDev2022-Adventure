extends KinematicBody2D
export var speed := 150.0
var facing
var isAttacking = false
#movement
func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	var move_direction := input_vector.normalized()
	move_and_slide(speed*move_direction)
	#movement animations
	if move_direction==Vector2(0,0):
		$AnimatedSprite.stop()
		if facing=="d":
			$AnimatedSprite.play("idle_down")
		if facing=="u":
			$AnimatedSprite.play("idle_up")
		if facing=="r":
			$AnimatedSprite.play("idle_right")
		if facing=="l":
			$AnimatedSprite.play("idle_left")
	if move_direction==Vector2(0,1):
		$AnimatedSprite.play("walk_down")
		facing="d"
	if move_direction==Vector2(0,-1):
		$AnimatedSprite.play("walk_up")
		facing="u"
	if move_direction==Vector2(1,0):
		$AnimatedSprite.play("walk_right")
		facing="r"
	if move_direction==Vector2(-1,0):
		$AnimatedSprite.play("walk_left")
		facing="l"
	#attacking
	if Input.is_action_just_pressed("attack"):
		isAttacking=true
		move_direction=Vector2(0,0)
		$AnimatedSprite.play("punch_down_lv.3")
	print(move_direction,facing,isAttacking)
	
	
	
	
	
	
	
	
	
	
	
	
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "punch_down_lv.3":
		isAttacking=false;

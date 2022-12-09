extends KinematicBody2D
export var speed := 150.0
var facing = "d"
var isAttacking = false
var savedAni= "idle_down"
#movement

var player_health = 30

	
		
func _ready():
	var tilemap_rect = get_parent().get_node("GroundTileMap").get_used_rect()
	var tilemap_cell_size = get_parent().get_node("GroundTileMap").cell_size
	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell_size.x
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell_size.y
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y
	pass

func _physics_process(_delta: float) -> void:
	
	if player_health <= 0:
		get_tree().change_scene("res://title_screen/TitleScreen.tscn")
	
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	var move_direction := input_vector.normalized()
	if isAttacking==false:
		# warning-ignore:return_value_discarded
		move_and_slide(speed*move_direction)
	#movement animations
	if isAttacking==false:
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
		savedAni=$AnimatedSprite.animation
	#attacking
	if Input.is_action_just_pressed("attack"):
		if facing=="d":
			$AnimatedSprite.play("punch_down_lv.3")
			isAttacking=true
			$AttackAreaDown/CollisionShape2D.disabled=false
		if facing=="u":
			$AnimatedSprite.play("punch_up_lv.3")
			isAttacking=true
			$AttackAreaUp/CollisionShape2D.disabled=false
		if facing=="l":
			$AnimatedSprite.play("punch_left_lv.3")
			isAttacking=true
			$AttackAreaLeft/CollisionShape2D.disabled=false
		if facing=="r":
			$AnimatedSprite.play("punch_right_lv.3")
			isAttacking=true
			$AttackAreaRight/CollisionShape2D.disabled=false
		
	#print(move_direction,facing,isAttacking)
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "punch_down_lv.3":
		$AttackAreaDown/CollisionShape2D.disabled=true
		$AnimatedSprite.play(savedAni)
		isAttacking=false
	if $AnimatedSprite.animation == "punch_up_lv.3":
		$AttackAreaUp/CollisionShape2D.disabled=true
		$AnimatedSprite.play(savedAni)
		isAttacking=false
	if $AnimatedSprite.animation == "punch_left_lv.3":
		$AttackAreaLeft/CollisionShape2D.disabled=true
		$AnimatedSprite.play(savedAni)
		isAttacking=false
	if $AnimatedSprite.animation == "punch_right_lv.3":
		$AttackAreaRight/CollisionShape2D.disabled=true
		$AnimatedSprite.play(savedAni)
		isAttacking=false


func _on_AttackAreaDown_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= 10


func _on_AttackAreaUp_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= 10


func _on_AttackAreaLeft_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= 10


func _on_AttackAreaRight_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= 10

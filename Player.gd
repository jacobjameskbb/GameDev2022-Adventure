extends KinematicBody2D
var velocity = Vector2()
var speed = 200
func _ready():
	pass
func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("down"):
		velocity.y += 1
		$PlayerSprite.animation = "move_down"
	elif Input.is_action_just_released("down"):
		$PlayerSprite.animation = "down_standing"
	elif Input.is_action_pressed("right"):
		$PlayerSprite.animation = "move_right"
		velocity.x += 1
	elif Input.is_action_just_released("right"):
		$PlayerSprite.animation = "right_standing"
	elif Input.is_action_pressed("left"):
		$PlayerSprite.animation = "move_left"
		velocity.x -= 1
	elif Input.is_action_just_released("left"):
		$PlayerSprite.animation = "left_standing"
	elif Input.is_action_pressed("up"):
		velocity.y -= 1
		$PlayerSprite.animation = "move_up"
	elif Input.is_action_just_released("up"):
		$PlayerSprite.animation = "up_standing"
	if Input.is_action_just_pressed("sprint_shift"):
		speed += 200
	if Input.is_action_just_released("sprint_shift"):
		speed -= 200
	velocity = velocity.normalized() * speed
	if velocity.length() > 0:
		$PlayerSprite.play()
	else:
		$PlayerSprite.stop()
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

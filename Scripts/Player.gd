extends KinematicBody2D
var velocity = Vector2()
var speed = 150
var is_sprinting = false
var health = 10
var enemyInRange = []
var facing = "down"
var attackCharge = 0
var crash = NAN

onready var fist = preload("res://Scenes/worm.tscn")

func _ready():
	var tilemap_rect = get_parent().get_node("GroundTileMap").get_used_rect()
	var tilemap_cell_size = get_parent().get_node("GroundTileMap").cell_size
	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell_size.x
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell_size.y
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y
	pass
func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("down"):
		facing = "down"
		velocity.y += 1
		
		if is_sprinting:
			$PlayerSprite.animation = "down_run"
		
		else: 
			$PlayerSprite.animation = "move_down"
	
	elif Input.is_action_just_released("down"):
		$PlayerSprite.animation = "down_standing"
	
	elif Input.is_action_pressed("right"):
		facing = "right"
		if is_sprinting:
			$PlayerSprite.animation = "move_right"
		
		else:
			$PlayerSprite.animation = "move_right"
		velocity.x += 1
	
	if Input.is_action_just_released("right"):
		$PlayerSprite.animation = "right_standing"
	
	if Input.is_action_pressed("left"):
		facing = "left"
		$PlayerSprite.animation = "move_left"
		velocity.x -= 1
	
	if Input.is_action_just_released("left"):
	
		$PlayerSprite.animation = "left_standing"
	
	if Input.is_action_pressed("up"):
		facing = "up"
		velocity.y -= 1
		$PlayerSprite.animation = "move_up"
	
	if Input.is_action_just_released("up"):
		$PlayerSprite.animation = "up_standing"
		
	if Input.is_action_just_pressed("sprint_shift"):
		speed = 200
		is_sprinting = true
	
	if Input.is_action_just_released("sprint_shift"):
		speed = 150
		is_sprinting = false
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed("ctrl"):
		
		var current_fist = fist.instance()
		add_child(current_fist)
		current_fist.position = position + Vector2(50,0)
		
		$PlayerSprite.animation = ("charge_"+facing)
	if Input.is_action_pressed("ctrl"):
		attackCharge += 1
	if Input.is_action_just_released("ctrl"):
		if attackCharge < 100:
			$PlayerSprite.animation = ("down_attack1")
		if attackCharge >= 100:
			$PlayerSprite.animation = ("down_attack2")
		attackCharge = 0
	if velocity.length() > 0:
		$PlayerSprite.play()
	else:
		$PlayerSprite.stop()
	if Input.is_action_pressed("crash_button"):
		print("crash"+crash)
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func _on_EnemyDetector_body_entered(body):
	if body.is_in_group("Enemy"):
		enemyInRange.append(body)
		
func _process(delta):
	for enemy in enemyInRange:
		if enemy.canAttack and enemy.hasAttacked == false:
			health -= 1
			print("Health = ",health)
			enemy.hasAttacked = true

func _on_EnemyDetector_body_exited(body):
	if body in enemyInRange:
		enemyInRange.erase(body)

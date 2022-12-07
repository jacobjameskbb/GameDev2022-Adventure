extends KinematicBody2D


const moveSpeed = 50
var velocity = Vector2()
onready var target = self
export var health = 50

var attacking = false

var direction = Vector2.ZERO
var facing = ''

# Define the different modes the enemy can be in
var states = {
	"idle":0,
	"chase":1,
	"attack":2,
	"flee":3
}

# Defines the current state the enemy is in
var current_state = 0

# Sets each direction to an attack box for ease
onready var attack_boxes = {
	"up":$AttackUp,
	"down":$AttackDown,
	"left":$AttackLeft,
	"right":$AttackRight
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		self.queue_free()
	
	if health <= 10:
		current_state = states["flee"]
		
	$HealthBar/Health.rect_size.x = 18 *(health/50.0)
		
func _physics_process(delta):

	if abs(direction.x) >= abs(direction.y):
		if direction.x >= 0:
			facing = 'right'
		elif direction.x <= 0:
			facing = 'left'
			
	elif abs(direction.x) <= abs(direction.y):
		if direction.y >= 0:
			facing = 'down'
		elif direction.y <= 0:
			facing = 'up'

	# If the enemy is idle, 
	if current_state == states["idle"]:
		stop_attacking()
		
	# If the enemy is chasing
	if current_state == states["chase"]:
		stop_attacking()
		direction = (target.position - position).normalized()
		move_and_slide(direction * moveSpeed)
	
	# If the enemy is attacking
	if current_state == states["attack"]:
		if !attacking:
			attacking = true
			$attackDelayTimer.start()
		direction = (target.position - position).normalized()
		
		
	# If the enemy is fleeing
	if current_state == states["flee"]:
		stop_attacking()
		var direction = -(target.position - position).normalized()
		move_and_slide(direction * moveSpeed)
	
	#if attackWait >= 80 and hasAttacked == false:
	#	var direction = (target - 6position).normalized()
	#	move_and_slide(direction * moveSpeed)

func stop_attacking():
	attacking = false
	$attackDelayTimer.stop()
	$attacktimer.stop()

func _on_PlayerDetectChase_body_entered(body):
	if body.is_in_group("Player") and current_state != states["flee"]:
		target = body
		current_state = states["chase"]


func _on_PlayerDetectChase_body_exited(body):
	if body.is_in_group("Player") and current_state != states["flee"]:
		target = self
		current_state = states["idle"]


func _on_PlayerDetectAttack_body_entered(body):
	if body.is_in_group("Player") and current_state != states["flee"]:
		current_state = states["attack"]
	


func _on_PlayerDetectAttack_body_exited(body):
	if body.is_in_group("Player") and current_state != states["flee"]:
		current_state = states["chase"]


func _on_attacktimer_timeout():
	$AttackDown/shape.disabled = true
	$AttackUp/shape.disabled = true
	$AttackLeft/shape.disabled = true
	$AttackRight/shape.disabled = true
	$attackDelayTimer.start()

func _on_attackDelayTimer_timeout():
	if attack_boxes[facing].get_node("shape").disabled == true:
		attack_boxes[facing].get_node("shape").disabled = false
		$attacktimer.start()


func _on_AttackUp_body_entered(body):
	if body.is_in_group("Player"):
		body.player_health -= 10
		print(body.player_health)


func _on_AttackLeft_body_entered(body):
	if body.is_in_group("Player"):
		body.player_health -= 10
		print(body.player_health)


func _on_AttackDown_body_entered(body):
	if body.is_in_group("Player"):
		body.player_health -= 10
		print(body.player_health)


func _on_AttackRight_body_entered(body):
	if body.is_in_group("Player"):
		body.player_health -= 10
		print(body.player_health)

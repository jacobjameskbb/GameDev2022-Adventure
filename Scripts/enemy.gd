extends KinematicBody2D


const moveSpeed = 50
var velocity = Vector2()
onready var target = self
export var health = 100

var attackWait = 80
var hasAttacked = false
var attackStun = 40
var canAttack = false

# Define the different modes the enemy can be in
var states = {
	"idle":0,
	"chase":1,
	"attack":2,
	"flee":3
}

# Defines the current state the enemy is in
var current_state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 20:
		current_state = states["flee"]
		
	$HealthBar/Health.rect_size.x = 18 - 18*float((1 - (health/100)))
		
func _physics_process(delta):

	# If the enemy is idle, 
	if current_state == states["idle"]:
		pass
		
	# If the enemy is chasing
	if current_state == states["chase"]:
		var direction = (target.position - position).normalized()
		move_and_slide(direction * moveSpeed)
	
	# If the enemy is attacking
	if current_state == states["attack"]:
		pass
		
	# If the enemy is fleeing
	if current_state == states["flee"]:
		var direction = -(target.position - position).normalized()
		move_and_slide(direction * moveSpeed)
	
	#if attackWait >= 80 and hasAttacked == false:
	#	var direction = (target - 6position).normalized()
	#	move_and_slide(direction * moveSpeed)




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

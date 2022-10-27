extends KinematicBody2D

const moveSpeed = 250
var velocity = Vector2()
var attackWait = 80
onready var player = get_node("/root/Main/WorldManager/Player")
var hasAttacked = false
var attackStun = 40
var canAttack = false
func _ready():
	pass
func _process(delta):
	if attackWait == 0:
		attackWait = 80
	if attackWait == 1:
		canAttack = true
	if attackWait <= 79:
		attackWait -= 1
	if attackWait == 80:
		canAttack = false
	if hasAttacked == true and attackStun >= 0:
		attackStun -= 1
	if attackStun == 0:
		attackStun = 40
		hasAttacked = false
		attackWait -= 1
func _physics_process(delta):
	if attackWait >= 80 and hasAttacked == false:
		var direction = (player.position - position).normalized()
		move_and_slide(direction * moveSpeed)
		

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		attackWait -= 1

extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target = self.position
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2((target.x - self.position.x)/abs(target.x - self.position.x), (target.y - self.position.y)/abs(target.y - self.position.y))
	velocity = velocity.normalized() * 300
	position +=  (velocity)*delta

extends Node2D

### World Manager ###

# World manager should control everything that happens in-game
# World manager should contain things such as the player, the environment, the enemies, etc.

var current_gummy_worms = 0

func _ready():
	$BlackSplitLeft.show()
	$BlackSplitRight.show()
	$BlackSplitLeft/AnimationPlayer.play("BlackSplitLeft")
	$BlackSplitRight/AnimationPlayer.play("BlackSplitRight")
	
func _process(_delta):
	for node in self.get_children():
		if node.is_in_group('enemy'):
			node.target = $Player.position
			
	if Input.is_action_just_pressed("F11"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	current_gummy_worms = 0
	for child in self.get_children():
		if child.is_in_group("Enemy"):
			current_gummy_worms += 1
			
	if current_gummy_worms == 0:
		print('YOU WIN')

func _on_AnimationPlayer_animation_finished(_anim_name):
	$BlackSplitLeft.hide()
	$BlackSplitRight.hide()
	var player = load("res://Player.tscn").instance()
	player.position = $PlayerStartPosition.position
	add_child(player)

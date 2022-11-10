extends Node2D

### World Manager ###

# World manager should control everything that happens in-game
# World manager should contain things such as the player, the environment, the enemies, etc.

func _ready():
	$BlackSplitLeft.show()
	$BlackSplitRight.show()
	$BlackSplitLeft/AnimationPlayer.play("BlackSplitLeft")
	$BlackSplitRight/AnimationPlayer.play("BlackSplitRight")
	$BlackSplitLeft.hide()
	$BlackSplitRight.hide()

func _process(_delta):
	for node in self.get_children():
		if node.is_in_group('enemy'):
			node.target = $Player.position

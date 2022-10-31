extends Control

func _ready():
	$Buttons/StartButton.connect("pressed",self,"_on_Button_pressed",[$Buttons/StartButton.scene_to_load])

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)

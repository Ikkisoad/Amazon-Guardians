extends Node

enum TrapType {WOOD}

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")

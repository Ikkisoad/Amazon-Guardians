extends Node

enum TrapType {WOOD, BEAR, HOLE, UPSIDEDOWN}
enum ResourceType {TREE, CAVE}
enum PlayerResourceType {LEAVES, STONES}
enum EnemyType {WOODWORKER, MINER, HUNTER}

signal onPlayerAttack(damage : int)

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

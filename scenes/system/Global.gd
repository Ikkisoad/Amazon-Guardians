extends Node

enum TrapType {WOOD, BEAR, HOLE, UPSIDEDOWN}
enum ResourceType {TREE, CAVE}
enum PlayerResourceType {LEAVES, STONES}
enum EnemyType {WOODWORKER, MINER, HUNTER}

const MENU_SCENE = preload("res://scenes/main_menu/main_menu.tscn")
signal onPlayerHit()
signal OnGameOver()
signal OnEnemyKilled()
signal OnStageWin()

var currentStage = 0
var gameClears = 1

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

func nextStage():
	match currentStage:
		0:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		1:
			get_tree().change_scene_to_file("res://scenes/stage_1/stage_1.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/stage_2/stage_2.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		4:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		5:
			currentStage = 0
			gameClears += 1
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		_:
			get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

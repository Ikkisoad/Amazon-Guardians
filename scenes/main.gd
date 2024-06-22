extends Node2D

@export var tilemap:TileMap
@export var playerMangader:Node2D
@onready var background_music = $backgroundMusic

var killsRequired = 0

func _ready():
	playerMangader.setCameraLimits(returnCameraLimits())
	Global.connect("OnEnemyKilled", enemyKilled)
	setKillGoal()

func returnCameraLimits():
	#return
	var map_limits = tilemap.get_used_rect()
	var map_cellsize = tilemap.tile_set.tile_size
	return [map_limits.position.x * map_cellsize.x + global_position.x,
	map_limits.end.x * map_cellsize.x + global_position.x,
	map_limits.position.y * map_cellsize.y + global_position.y,
	map_limits.end.y * map_cellsize.y + global_position.y]
	#playerCamera.limit_left = map_limits.position.x * map_cellsize.x + globalPosition.x
	#playerCamera.limit_right = map_limits.end.x * map_cellsize.x + globalPosition.x
	#playerCamera.limit_top = map_limits.position.y * map_cellsize.y + globalPosition.y
	#playerCamera.limit_bottom = map_limits.end.y * map_cellsize.y + globalPosition.y

func enemyKilled():
	killsRequired -= 1
	if killsRequired <= 0:
		nextStageSequence()

func nextStageSequence():
	Global.OnStageWin.emit()

func _on_background_music_finished():
	background_music.play()

func setKillGoal():
	for c in get_children():
		if c.is_in_group("spawner"):
			killsRequired += c.spawnLimit
	killsRequired -= Global.gameClears

extends Node2D

@export var tilemap:TileMap
@export var playerMangader:Node2D
@onready var background_music = $backgroundMusic

func _ready():
	playerMangader.setCameraLimits(returnCameraLimits())

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


func _on_background_music_finished():
	background_music.play()

extends Node2D

@export var health = 500000
@export var enemyType = Global.EnemyType.WOODWORKER
@export var minSpawnRate = 1
@export var maxSpawnRate = 5
@onready var tmr_spawn = $tmrSpawn
@export var spawnLimit = 5
@export var facing = 1

var enemyScene
var spawnedCount = 0

#var woodWorkerScene = preload("res://scenes/enemy/woodworker/cb_woodworker.tscn")
#var minerScene = preload("res://scenes/enemy/Miner/cb_miner_enemy.tscn")
#var enemyTypes: Array = [woodWorkerScene, minerScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	setEnemySpawnType()
	startSpawnTimer()

func setEnemySpawnType():
	#enemyScene = enemyTypes[randi_range(0, enemyTypes.size())]
	match enemyType:
		Global.EnemyType.WOODWORKER:
			enemyScene = preload("res://scenes/enemy/woodworker/cb_woodworker.tscn")
		Global.EnemyType.MINER:
			enemyScene = preload("res://scenes/enemy/Miner/cb_miner_enemy.tscn")

func startSpawnTimer():
	tmr_spawn.start(randi_range(minSpawnRate, maxSpawnRate))

func _on_tmr_spawn_timeout():
	spawnedCount += 1
	var newEnemy = enemyScene.instantiate()
	newEnemy.global_position = global_position
	newEnemy.global_position.x += 250 * facing
	if facing == -1:
		newEnemy.facing = -1
	add_sibling(newEnemy)
	if spawnedCount < spawnLimit: startSpawnTimer()


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		body.returnToBase()

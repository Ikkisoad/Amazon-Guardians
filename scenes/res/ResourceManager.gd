extends Node2D
@onready var progress_bar = $CanvasLayer/ProgressBar

@export var maxNewXPos = 350
@export var minNewXPos = 150

@export var maxTrees = 5
@export var maxCaves = 5
var treeCount = 0
var caveCount = 0

var treeYPos = -500
var caveYPos = -250

var treeRes = preload("res://scenes/res/tree_res/tree_res.tscn")
var caveRes = preload("res://scenes/res/cave_res/cave_resource.tscn")

func _ready():
	countResources()
	setOverallHealthValues()

func setOverallHealthValues():
	var maxHealth = 0
	var currentHealth = 0
	for c in get_children():
		if c.is_in_group("resource"): maxHealth += c.health
	progress_bar.max_value = maxHealth
	progress_bar.value = maxHealth

func setCurrentHealth(value):
	progress_bar.value += value
	if progress_bar.value <= 0:
		GameOverSequence()

#we can set everything that happens here as soon as the player lose, like text, pauses and menus
func GameOverSequence() -> void:
	Global.OnGameOver.emit()

func spawnTree(globalPos, facing = 1):
	if treeCount > maxTrees: return
	var newTree = treeRes.instantiate()
	add_child(newTree)
	var newResPos = Vector2(120 * facing, 15)
	newTree.global_position = globalPos + newResPos
	newTree.global_position.y += treeYPos
	treeCount += 1

func spawnCave(globalPos, facing = 1):
	if caveCount > maxCaves: return
	var newCave = caveRes.instantiate()
	add_child(newCave)
	var newResPos = Vector2(120 * facing, 15)
	newCave.global_position = globalPos + newResPos
	newCave.global_position.y += caveYPos
	caveCount += 1

func countResource(group):
	var count = 0
	for c in get_children():
		if c.is_in_group(group):
			count += 1
	return count

func countResources():
	treeCount = countResource("tree")
	caveCount = countResource("cave")
	
func removeResource(resType):
	match resType:
		Global.ResourceType.TREE:
			treeCount -= 1
		Global.ResourceType.CAVE:
			caveCount -= 1

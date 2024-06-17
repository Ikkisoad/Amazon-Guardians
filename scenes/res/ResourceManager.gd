extends Node2D

@export var maxNewXPos = 350
@export var minNewXPos = 150

@export var maxTrees = 5
@export var maxCaves = 5
var treeCount = 0
var caveCount = 0

@export var treeYPos = 0

var treeRes = preload("res://scenes/res/tree_res/tree_res.tscn")
var caveRes = preload("res://scenes/res/cave_res/cave_resource.tscn")

func _ready():
	countResources()

func spawnTree(globalPos):
	if treeCount > maxTrees: return
	var facing = randi_range(0,1)
	if facing == 0: facing = -1
	var newTree = treeRes.instantiate()
	add_child(newTree)
	newTree.global_position = Vector2(globalPos.x + randi_range(minNewXPos, maxNewXPos) * facing, treeYPos)
	treeCount += 1

func spawnCave(globalPos):
	if caveCount > maxCaves: return
	var facing = randi_range(0,1)
	if facing == 0: facing = -1
	var newCave = caveRes.instantiate()
	add_child(newCave)
	newCave.global_position = Vector2(globalPos.x + randi_range(minNewXPos, maxNewXPos) * facing, treeYPos)
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

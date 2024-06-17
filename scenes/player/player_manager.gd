extends Node2D

@onready var cb_player = $cbPlayer
@onready var cb_player_2 = $cbPlayer2
@onready var cam_player = $camPlayer
@onready var player_ui = $PlayerUI

@export var resourceManager:Node2D
@export var leafAmount = 0
@export var stoneAmount = 0
var trapTypeSelected = Global.TrapType.WOOD
var resourceTypeSelected = Global.ResourceType.TREE

# Called when the node enters the scene tree for the first time.
func _ready():
	cb_player.setRemoteTransformPath(cam_player.get_path())
	updateHUD()

func updateHUD():
	player_ui.updateHUD(cb_player.health, cb_player_2.health, leafAmount, stoneAmount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("swap"):
		var swap = cb_player.locked
		cb_player_2.lock(swap, cam_player.get_path())
		cb_player.lock(!swap, cam_player.get_path())

func collectResource(resType = Global.PlayerResourceType.LEAVES, amount = 1):
	match resType:
		Global.PlayerResourceType.LEAVES:
			leafAmount += amount
			Log.print(str("Leaf collected ", amount))
		Global.PlayerResourceType.STONES:
			stoneAmount += amount
			Log.print(str("Stone collected ", amount))
	updateHUD()

func spawnResource(globalPos):
	match resourceTypeSelected:
		Global.ResourceType.TREE:
			resourceManager.spawnTree(globalPos)

func changeSelectedResource():
	if resourceTypeSelected == Global.ResourceType.TREE:
		resourceTypeSelected = Global.ResourceType.CAVE
	else:
		resourceTypeSelected = Global.ResourceType.TREE
	player_ui.changeSelectedResource(resourceTypeSelected)

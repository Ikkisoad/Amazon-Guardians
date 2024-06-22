extends Node2D

@onready var cam_player = $camPlayer
@onready var player_ui = $PlayerUI
@onready var cb_player_2 = $caipora
@onready var cb_player = $curupira

@export var resourceManager:Node2D
@export var leafAmount = 0
@export var stoneAmount = 0
var trapTypeSelected = Global.TrapType.WOOD
var resourceTypeSelected = Global.ResourceType.TREE

var caveTeleportTo = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	cb_player.setRemoteTransformPath(cam_player.get_path())
	Global.onPlayerHit.connect(OnPlayerDamaged)
	updateHUD()

func setCameraLimits(limits):
	cam_player.limit_left = limits[0]
	cam_player.limit_right = limits[1]
	cam_player.limit_top = limits[2]
	cam_player.limit_bottom = limits[3]

func caveTeleport(playerBody):
	var caveArray = []
	for i in resourceManager.get_children():
		if i.is_in_group("cave"):
			caveArray.push_back(i)
	if caveTeleportTo >= caveArray.size():
		caveTeleportTo = 0
	if !caveArray.is_empty():
		playerBody.global_position = caveArray[caveTeleportTo].global_position
		playerBody.global_position.y += 500
		caveTeleportTo += 1

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

func spawnResource(globalPos, facing):
	match resourceTypeSelected:
		Global.ResourceType.TREE:
			resourceManager.spawnTree(globalPos, facing)
		Global.ResourceType.CAVE:
			resourceManager.spawnCave(globalPos, facing)

func changeSelectedResource():
	if resourceTypeSelected == Global.ResourceType.TREE:
		resourceTypeSelected = Global.ResourceType.CAVE
	else:
		resourceTypeSelected = Global.ResourceType.TREE
	player_ui.changeSelectedResource(resourceTypeSelected)

func changeSelectedTrap():
	if trapTypeSelected == Global.TrapType.WOOD:
		trapTypeSelected = Global.TrapType.BEAR
	else:
		trapTypeSelected = Global.TrapType.WOOD
	player_ui.changeSelectedTrap(trapTypeSelected)

func OnPlayerDamaged() -> void:
	updateHUD()

extends Node2D

@export var health = 100
@onready var tmr_resource = $tmrResource
@export var resourceType:Global.ResourceType = Global.ResourceType.TREE
@onready var pb_resource = $pbResource
@onready var tmr_health_regen = $tmrHealthRegen

var playerResourceScene
var playerResource

@export var tmrResourceMin = 100
@export var tmrResourceMax = 500
@export var tmrMinHealthRegen = 5
@export var tmrMaxHealthRegen = 10
@export var minHealthRegen = 1
@export var maxHealthRegen = 5

func _ready():
	startHealthRegenTimer()
	updateHUD()
	startPlayerResourceTimer()
	setPlayerResource()

func _on_body_entered(body):
	#Log.print(str("Body entered: ", body))
	pass


func _on_tmr_resource_timeout():
	var newResource = playerResourceScene.instantiate()
	newResource.playerResourceType = playerResource
	add_child(newResource)
	newResource.global_position.x += randi_range(-15, 15)
	startPlayerResourceTimer()

func startPlayerResourceTimer():
	tmr_resource.start(randi_range(tmrResourceMin, tmrResourceMax))

func startHealthRegenTimer():
	tmr_health_regen.start(randi_range(tmrMinHealthRegen, tmrMaxHealthRegen))
func setPlayerResource():
	match resourceType:
		Global.ResourceType.TREE:
			playerResourceScene = preload("res://scenes/player_resource/leaves/leaves.tscn")
			playerResource = Global.PlayerResourceType.LEAVES


func _on_tmr_health_regen_timeout():
	health += randi_range(minHealthRegen, maxHealthRegen)
	startHealthRegenTimer()
	updateHUD()

func updateHUD():
	pb_resource.value = health

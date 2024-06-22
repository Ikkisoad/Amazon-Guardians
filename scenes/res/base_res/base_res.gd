extends Node2D

@export var health = 100
@export var maxHealth = 100
@onready var tmr_resource = $tmrResource
@export var resourceType:Global.ResourceType = Global.ResourceType.TREE
@onready var pb_resource = $pbResource
@onready var tmr_health_regen = $tmrHealthRegen

var playerResourceScene
var playerResource

@export var tmrResourceMin = 25
@export var tmrResourceMax = 100
@export var tmrMinHealthRegen = 5
@export var tmrMaxHealthRegen = 10
@export var minHealthRegen = 1
@export var maxHealthRegen = 5

func _ready():
	startHealthRegenTimer()
	updateHUD()
	startPlayerResourceTimer()
	setPlayerResource()

func _on_body_entered(_body):
	#Log.print(str("Body entered: ", body))
	pass


func _on_tmr_resource_timeout():
	var newResource = playerResourceScene.instantiate()
	newResource.playerResourceType = playerResource
	add_sibling(newResource)
	newResource.global_position = global_position + Vector2(randi_range(-15, 15),0)
	startPlayerResourceTimer()

func startPlayerResourceTimer():
	tmr_resource.start(randi_range(tmrResourceMin, tmrResourceMax))

func startHealthRegenTimer():
	tmr_health_regen.start(randi_range(tmrMinHealthRegen, tmrMaxHealthRegen))
func setPlayerResource():
	match resourceType:
		Global.ResourceType.TREE:
			playerResourceScene = preload("res://scenes/player_res/leaves/leaves.tscn")
			playerResource = Global.PlayerResourceType.LEAVES
		Global.ResourceType.CAVE:
			playerResourceScene = preload("res://scenes/player_res/stones/stone.tscn")
			playerResource = Global.PlayerResourceType.STONES


func _on_tmr_health_regen_timeout():
	if health < maxHealth:
		var heal = randi_range(minHealthRegen, maxHealthRegen)
		if health + heal > maxHealth:
			heal = maxHealth - health
		health += heal
		get_parent().setCurrentHealth(heal)
		startHealthRegenTimer()
		updateHUD()

func updateHUD():
	pb_resource.value = health

func getHit(damage):
	health -= damage
	get_parent().setCurrentHealth(-damage)
	updateHUD()
	if health <= 0:
		get_parent().removeResource(resourceType)
		queue_free()
		return true

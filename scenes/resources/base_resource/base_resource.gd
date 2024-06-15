extends Node2D

@export var health = 100
@onready var tmr_resource = $tmrResource
@export var resourceType:Global.ResourceType = Global.ResourceType.TREE

var playerResource

@export var tmrResourceMin = 100
@export var tmrResourceMax = 500

func _ready():
	startPlayerResourceTimer()
	setPlayerResource()

func _on_body_entered(body):
	Log.print(str("Body entered: ", body))


func _on_tmr_resource_timeout():
	Log.print("Spawn player resource")
	var newResource = playerResource.instantiate()
	add_child(newResource)
	startPlayerResourceTimer()

func startPlayerResourceTimer():
	tmr_resource.start(randi_range(tmrResourceMin, tmrResourceMax))

func setPlayerResource():
	match resourceType:
		Global.ResourceType.TREE:
			playerResource = preload("res://scenes/player_resource/leaves/leaves.tscn")

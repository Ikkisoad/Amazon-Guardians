extends CharacterBody2D
@onready var tmr_base_player_resource = $tmrBasePlayerResource

@export var tmrDespawnMin = 50
@export var tmrDespawnMax = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	startDespawnTimer()

func _physics_process(delta):
	velocity.y += gravity * delta

func _on_tmr_base_player_resource_timeout():
	Log.print("Despawned")
	queue_free()

func startDespawnTimer():
	tmr_base_player_resource.start(randi_range(tmrDespawnMin, tmrDespawnMax))


func _on_a_2d_base_player_resource_body_entered(body):
	Log.print("Body detected")

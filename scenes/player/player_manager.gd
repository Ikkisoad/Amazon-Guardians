extends Node2D

@onready var cb_player = $cbPlayer
@onready var cb_player_2 = $cbPlayer2
@onready var cam_player = $camPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	cb_player.setRemoteTransformPath(cam_player.get_path())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("swap"):
		var swap = cb_player.locked
		cb_player_2.lock(swap, cam_player.get_path())
		cb_player.lock(!swap, cam_player.get_path())

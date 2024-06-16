extends BaseTrap


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	trapType = Global.TrapType.WOOD
	global_position.y = 461

extends BaseTrap


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#super()


func _on_trap_timer_timeout() -> void:
	#reset the frame back to 0
	animated_sprite_2d.frame = DEFAULT_FRAME
	#if health <= 0:
		#queue_free()

func _on_area_entered(area: Area2D) -> void:
	if health > 0: hitBodyArea(area)
	
func _on_body_entered(body):
	if health > 0: 
		hitBodyArea(body)
	elif body.is_in_group("player"):
		health = 100
		updateHUD()

func getHit(dmg):
	health = 0
	updateHUD()

extends Area2D
class_name BaseTrap

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var trap_timer: Timer = $TrapTimer
@export var damage = 500
@export var trapType = Global.TrapType.WOOD
@export var health = 100
@onready var progress_bar = $ProgressBar
@onready var as_hit = $asHit

const DEFAULT_FRAME = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateHUD()
	if trapType == Global.TrapType.BEAR:
		animated_sprite_2d.play("bearTrap")

func _on_area_entered(area: Area2D) -> void:
	hitBodyArea(area)

func _on_trap_timer_timeout() -> void:
	#reset the frame back to 0
	animated_sprite_2d.frame = DEFAULT_FRAME
	if health <= 0:
		queue_free()

func _on_body_entered(body):
	hitBodyArea(body)

func hitBodyArea(area):
	if trap_timer.is_stopped() && area.is_in_group("enemy"):
		animated_sprite_2d.play()
		if area.has_method("getHit"):
			as_hit.play()
			area.getHit(damage)
			getHit(damage / 10)
		trap_timer.start()

func getHit(dmg):
	health -= dmg
	updateHUD()

func updateHUD():
	progress_bar.value = health

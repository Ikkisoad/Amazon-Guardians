extends Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var trap_timer: Timer = $TrapTimer
@export var damage = 500

const DEFAULT_FRAME = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if trap_timer.is_stopped() && area.get_parent().is_in_group("enemy"):
		animated_sprite_2d.play()
		if area.get_parent().has_method("getHit"):
			area.get_parent().getHit(damage)
		trap_timer.start()

func _on_trap_timer_timeout() -> void:
	#reset the frame back to 0
	animated_sprite_2d.frame = DEFAULT_FRAME

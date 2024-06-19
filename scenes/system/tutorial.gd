extends Node
@onready var spr_caipora = $CanvasLayer/Control/sprCaipora
@onready var spr_curupira = $CanvasLayer/Control/sprCurupira
@onready var tmr_test = $tmrTest

func _ready():
	print(spr_caipora.modulate)
	spr_caipora.modulate = Color(1,1,1,0.2)
	get_tree().paused = true
	tmr_test.start(2)



func _on_tmr_test_timeout():
	get_tree().paused = false
	queue_free()

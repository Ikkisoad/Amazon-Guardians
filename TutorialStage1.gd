extends Node
@onready var spr_caipora = $CanvasLayer/Control/sprCaipora
@onready var spr_curupira = $CanvasLayer/Control/sprCurupira
@onready var tmr_test = $tmrTest
@onready var label = $CanvasLayer/Control/MC/Label

var step = 0

func _ready():
	modulateProfile(spr_curupira, 0.8)
	get_tree().paused = true
	#tmr_test.start(2)

func _on_tmr_test_timeout():
	get_tree().paused = false
	queue_free()

func _input(event):
	if event.is_action_pressed("jump"):
		step += 1
		updateHUD()

func updateHUD():
	match step:
		1:
			label.text = "Curupira: We can press 'Up' to move around our caves on the map"
			modulateProfile(spr_curupira, 1)
			modulateProfile(spr_caipora, 0.8)
		#2:
			#label.text = "We should gather some resources, and using 'space' we can jump around"
		#3:
			#label.text = "By pressing 'X' and having enough resources I can setup traps"
		#4:
			#label.text = "The amount of resources we collected is shown on the top right"
		#5:
			#label.text = "And with 'E' I can change which type of trap I can place"
		#6:
			#label.text = "While you setup those traps, let me take care of them personally"
			#modulateProfile(spr_curupira, 0.8)
			#modulateProfile(spr_caipora, 1)
		#7:
			#label.text = "With 'X' I can let them know who they are dealing with"
		#8:
			#label.text = "And 'V' allows me to dash and headbutt them graciously"
		#9:
			#label.text = "I can also place structures using 'V'"
			#modulateProfile(spr_curupira, 1)
			#modulateProfile(spr_caipora, 0.8)
		#10:
			#label.text = "Just like with traps, pressing 'Q' I can choose what kind of structure I place on the field"
		_:
			get_tree().paused = false
			queue_free()

func modulateProfile(profile, alpha = 0.2):
	profile.modulate = Color(1,1,1,alpha)

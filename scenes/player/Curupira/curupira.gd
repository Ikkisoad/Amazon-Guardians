extends PlayerClass
@onready var tmr_trap = $tmrTrap

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("falling")
		velocity.y += gravity * delta

	if !locked: 
		handleInputs()
		handleAbilities()
	else:
		walkStop()
	if !tmr_trap.is_stopped():
		animated_sprite_2d.play("settingTrap")
	move_and_slide()

func handleAbilities():
	if is_on_floor():
		if !spawnLocked:
			if Input.is_action_just_pressed("trap"):
				animated_sprite_2d.play("settingTrap")
				tmr_trap.start(0.3)
				spawnTrap()
			if Input.is_action_just_pressed("setResource"):
				spawnResource()
	if Input.is_action_just_pressed("changeSelectedResource"):
		get_parent().changeSelectedResource()
	if Input.is_action_just_pressed("changeSelectedTrap"):
		get_parent().changeSelectedTrap()

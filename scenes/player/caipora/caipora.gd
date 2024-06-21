extends PlayerClass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if !locked: 
		handleInputs()
		handleAbilities()
	else:
		walkStop()
	move_and_slide()

func handleAbilities():
	if is_on_floor():
		if Input.is_action_just_pressed("trap"):
			#attack
			spawnTrap()
		if Input.is_action_just_pressed("setResource"):
			#dash
			spawnResource()
	if Input.is_action_just_pressed("changeSelectedResource"):
		get_parent().changeSelectedResource()
	if Input.is_action_just_pressed("changeSelectedTrap"):
		get_parent().changeSelectedTrap()

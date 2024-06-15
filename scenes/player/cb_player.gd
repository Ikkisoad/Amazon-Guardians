extends CharacterBody2D

const WOOD_TRAP = preload("res://scenes/traps/wood_trap.tscn")
const SPEED = 650.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var tmr_jump_buffer = $tmrJumpBuffer
@onready var rt_player = $rtPlayer
@export var locked = false
@onready var animated_sprite_2d = $AnimatedSprite2D

var selectedTrapType = Global.TrapType.WOOD
var facing = 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if !locked: 
		handleInputs()
	else:
		walkStop()
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY

func handleInputs():
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		else:
			tmr_jump_buffer.start(0.1)
	elif !tmr_jump_buffer.is_stopped():
		if is_on_floor(): 
			jump()
			tmr_jump_buffer.stop()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if facing != direction:
			flip(direction)
		velocity.x = direction * SPEED
		animated_sprite_2d.play("walk")
	else:
		walkStop()
	if Input.is_action_just_pressed("trap"):
		spawnHoldTrap()

func flip(dir):
	scale.x = -1
	facing = dir

func spawnHoldTrap():
	var newTrap
	var newTrapPos
	if selectedTrapType == Global.TrapType.WOOD:
		newTrap = WOOD_TRAP.instantiate()
		newTrapPos = Vector2(120,0)
	get_parent().add_child(newTrap)
	newTrap.global_position = global_position + newTrapPos * facing

func walkStop():
	velocity.x = move_toward(velocity.x, 0, SPEED)
	animated_sprite_2d.play("default")

#if necessary for debugging, it makes it easier to get inputs while frame advancing
#func virtualController():
func setRemoteTransformPath(v):
	rt_player.remote_path = v

func lock(value, cameraPath):
	if value:
		cameraPath = ""
	setRemoteTransformPath(cameraPath)
	locked = value

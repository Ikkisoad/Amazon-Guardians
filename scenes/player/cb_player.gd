extends CharacterBody2D
class_name PlayerClass

const WOOD_TRAP = preload("res://scenes/traps/wood_trap.tscn")
const BEAR_TRAP = preload("res://scenes/traps/bear_trap.tscn")
@export var SPEED = 650.0
const JUMP_VELOCITY = -800.0
@onready var tmr_heal = $tmrHeal

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var tmr_jump_buffer = $tmrJumpBuffer
@onready var rt_player = $rtPlayer
@export var locked = false
@export var health = 1000
@export var maxHealth = 1000
@onready var as_place_trap = $asPlaceTrap
@onready var tmr_teleport = $tmrTeleport

@export var woodTrapCost = 3
@export var bearTrapCost = 25

@onready var animated_sprite_2d = $AnimatedSprite2D

var selectedTrapType = Global.TrapType.WOOD
@export var facing = 1
var isDead = false
var spawnLocked = false

func _ready():
	if facing != 1: flip(-1)

func _process(delta: float) -> void:
	#just to explain here i'm using only using _process to check UI stuffs and player stats
	#, so it does not get mixed with the physics
	CheckPlayerStatus()

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
		if is_on_floor(): animated_sprite_2d.play("walk")
	else:
		walkStop()
	if is_on_floor():
		var yDirection = Input.get_axis("down", "up")
		if yDirection == -1:
			global_position.y += 1
		elif yDirection == 1 && tmr_teleport.is_stopped():
			tmr_teleport.start(1)
			get_parent().caveTeleport(self)

func flip(dir):
	scale.x = -1
	facing = dir

func spawnResource():
	get_parent().spawnResource(global_position, facing)

func spawnTrap():
	match get_parent().trapTypeSelected:
		Global.TrapType.WOOD:
			spawnHoldTrap()
		Global.TrapType.BEAR:
			spawnBearTrap()

func spawnHoldTrap():
	if woodTrapCost <= get_parent().leafAmount:
		var newTrap
		var newTrapPos
		newTrap = WOOD_TRAP.instantiate()
		newTrapPos = Vector2(120 * facing, -25)
		get_parent().add_child(newTrap)
		newTrap.global_position = global_position + newTrapPos
		get_parent().leafAmount -= woodTrapCost
		get_parent().updateHUD()
		as_place_trap.play()

func spawnBearTrap():
	if bearTrapCost <= get_parent().stoneAmount:
		var newTrap
		var newTrapPos
		newTrap = BEAR_TRAP.instantiate()
		newTrapPos = Vector2(120 * facing, -25)
		get_parent().add_child(newTrap)
		newTrap.global_position = global_position + newTrapPos
		get_parent().stoneAmount -= bearTrapCost
		get_parent().updateHUD()
		as_place_trap.play()

func walkStop():
	velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor(): animated_sprite_2d.play("default")

#if necessary for debugging, it makes it easier to get inputs while frame advancing
#func virtualController():
func setRemoteTransformPath(v):
	rt_player.remote_path = v

func lock(value, cameraPath):
	if value:
		cameraPath = ""
	setRemoteTransformPath(cameraPath)
	locked = value

func collect(resType = Global.PlayerResourceType.LEAVES, amount = 1):
	get_parent().collectResource(resType, amount)

func DamagePlayer(damageTaken : int) -> void:
	if health > 0:
		health -= damageTaken
		tmr_heal.start(1)
		isDead = false
		
	Global.onPlayerHit.emit()

func CheckPlayerStatus() -> void:
	if health < 0:
		isDead = true
		hide()
		queue_free()
		GameOverSequence()

#we can set everything that happens here as soon as the player lose, like text, pauses and menus
func GameOverSequence() -> void:
	Global.OnGameOver.emit()

func _on_tmr_heal_timeout():
	health += 5
	get_parent().updateHUD()
	if health >= maxHealth:
		health = maxHealth
	else:
		tmr_heal.start(1)

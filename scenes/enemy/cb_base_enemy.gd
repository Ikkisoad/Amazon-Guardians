extends CharacterBody2D


@export var SPEED = 150.0
const JUMP_VELOCITY = -400.0

@export var facing = 1
var stop = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = facing
	if direction && !stop:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_a_2_enemy_detector_body_entered(body):
	if body.is_in_group("resource"):
		Log.print("Resource detected")
		stop = true


func _on_a_2_enemy_detector_area_entered(area):
	Log.print(area)
	if area.get_parent().is_in_group("resource"):
		Log.print("Resource detected")
		stop = true

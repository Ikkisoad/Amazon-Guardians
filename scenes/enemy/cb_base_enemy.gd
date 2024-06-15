extends CharacterBody2D


@export var SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var tmr_attack = $tmrAttack

@export var facing = 1
var stop = false
var attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var cs_attack = $a2EnemyAttack/csAttack


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
	if area.get_parent().is_in_group("resource"):
		stop = true
		startAttacking()

func startAttacking():
	attacking = true
	startAttackTimer()

func startAttackTimer():
	tmr_attack.start(randi_range(1,5))

func _on_tmr_attack_timeout():
	if attacking:
		startAttackTimer()
		cs_attack.set_deferred("disabled", false)

func _on_a_2_enemy_attack_area_entered(area):
	cs_attack.set_deferred("disabled", true)
	if area.get_parent().is_in_group("resource"):
		if area.get_parent().has_method("getHit"):
			if area.get_parent().getHit(50):
				facing = facing * -1
				scale.x = -1
				attacking = false
				stop = false

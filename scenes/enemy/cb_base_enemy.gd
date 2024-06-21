extends CharacterBody2D

enum animStates {STOP, WALK, ATTACK}

@export var SPEED = 150.0
@export var enemyType = Global.EnemyType.MINER
@export var health = 1000
const JUMP_VELOCITY = -400.0
@onready var tmr_attack = $tmrAttack
@onready var pb_enemy = $pbEnemy
@onready var cb_base_enemy: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var facing = 1
var stop = false
var attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var cs_attack = $a2EnemyAttack/csAttack
var resource


func _ready():
	updateHUD()
	if facing == -1:
		scale.x = -1
	match enemyType:
		Global.EnemyType.WOODWORKER:
			resource = "tree"
		Global.EnemyType.MINER:
			resource = "cave"
		Global.EnemyType.HUNTER:
			resource = "animal"
		_:
			resource = "tree"
			

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = facing
	if direction && !stop:
		velocity.x = direction * SPEED
		PlayAnimationBasedOnEnemyType(enemyType, animStates.WALK)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

func _on_a_2_enemy_detector_body_entered(body):
	if body.is_in_group("resource"):
		Log.print("Resource detected")
		stop = true

func _on_a_2_enemy_detector_area_entered(area):
	if area.get_parent().is_in_group("resource") || area.get_parent().is_in_group("player"):
		stop = true
		PlayAnimationBasedOnEnemyType(enemyType, animStates.STOP)
		startAttacking()


func startAttacking():
	attacking = true
	startAttackTimer()

func startAttackTimer():
	tmr_attack.start(randi_range(1,5))

func _on_tmr_attack_timeout():
	if attacking:
		if !cs_attack.disabled:
			returnToBase()
		startAttackTimer()
		cs_attack.set_deferred("disabled", false)
		PlayAnimationBasedOnEnemyType(enemyType, animStates.ATTACK)

func _on_a_2_enemy_attack_area_entered(area):
	cs_attack.set_deferred("disabled", true)
	if area.get_parent().is_in_group("resource"):
		if area.get_parent().has_method("getHit"):
			if area.get_parent().getHit(randi_range(10,25)):
				returnToBase()		
	
	if area.get_parent().is_in_group("player"):
		if area.get_parent().has_method("DamagePlayer"):
			area.get_parent().DamagePlayer(600)
			
	
func returnToBase():
	cs_attack.set_deferred("disabled", true)
	facing = facing * -1
	scale.x = -1
	attacking = false
	stop = false

func _on_a_2_enemy_detector_area_exited(area):
	if area.get_parent().is_in_group("resource"):
		returnToBase()

func updateHUD():
	pb_enemy.value = health

func getHit(dmg):
	health -= dmg
	updateHUD()
	if health <= 0:
		queue_free()

func PlayAnimationBasedOnEnemyType(enemyType : Global.EnemyType, enemyState : animStates) -> void:
	if enemyType == Global.EnemyType.WOODWORKER:
		match enemyState:
			animStates.STOP:
				animated_sprite_2d.play("lenhadorStopped")
			animStates.WALK:
				animated_sprite_2d.play("lenhadorWalk")
			animStates.ATTACK:
				animated_sprite_2d.play("lenhadorAttack")
	if enemyType == Global.EnemyType.MINER:
		match enemyState:
			animStates.STOP:
				animated_sprite_2d.play("mineiroStopped")
			animStates.WALK:
				animated_sprite_2d.play("mineiroWalk")
			animStates.ATTACK:
				animated_sprite_2d.play("mineiroAttack")

extends PlayerClass
@onready var collision_shape_2d = $attackHitbox/CollisionShape2D
@onready var tmr_attacking = $tmrAttacking
@onready var tmr_dash_cooldown = $tmrDashCooldown

@export var damage = 350

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if tmr_attacking.is_stopped():
		if !locked: 
			handleInputs()
			handleAbilities()
		else:
			walkStop()
	move_and_slide()

func handleAbilities():
	#if is_on_floor():
	if Input.is_action_just_pressed("trap"):
		#attack
		attack()
	if Input.is_action_just_pressed("setResource") && tmr_dash_cooldown.is_stopped():
		#dash attack
		dashAttack()
	if Input.is_action_just_pressed("changeSelectedResource"):
		get_parent().changeSelectedResource()
	if Input.is_action_just_pressed("changeSelectedTrap"):
		get_parent().changeSelectedTrap()

func dashAttack():
	collision_shape_2d.set_deferred("disabled", false)
	tmr_attacking.start(0.2)
	velocity.x = 1500 * facing
	tmr_dash_cooldown.start(2)

func attack():
	walkStop()
	collision_shape_2d.set_deferred("disabled", false)
	animated_sprite_2d.play("attack")
	tmr_attacking.start(1)


func _on_tmr_attacking_timeout():
	collision_shape_2d.set_deferred("disabled", true)


func _on_attack_hitbox_body_entered(body):
	if body.is_in_group("enemy"):
		body.getHit(damage)

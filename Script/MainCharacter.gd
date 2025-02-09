extends CharacterBody2D

var Speed = 75
var Jump = -170
var Gravity = 3
var Jump_permission = true
var Protoction = false
var Shoot_Delay = false
var Falling = false
var Shooting = false
var Bullet_scene = preload("res://Scene/Bullet.tscn")
var Charge_bullet_scene = preload("res://Scene/ChargeShot.tscn")


func _physics_process(delta):
	Gravity_process()
	Player_Abilities()


	if is_on_floor():
		velocity.y = 0
		Jump_permission = true
		Falling = false

	if Input.is_action_pressed("MoveLeft"):
		velocity.x = -Speed
	
	elif Input.is_action_pressed("MoveRight"):
		velocity.x = Speed
	 
	else: 
		velocity.x = 0 
	
	if Input.is_action_just_pressed("Jump") and Jump_permission:
		velocity.y = Jump
	
	if Input.is_action_just_released("Jump") and !is_on_floor() and velocity.y < -30:
		velocity.y = -15
	
		
	if Shooting:
		$AnimatedSprite2D.animation = "Shooting"
	
	elif !is_on_floor():
		$AnimatedSprite2D.animation = "Jump"
	
	elif !velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.animation = "Walk"
		
	elif velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.animation = "Idle"
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if velocity.y >= 0 and !is_on_floor() and !Falling:
		Falling = true
		Jump_Delay()
	elif !is_on_floor() and !Falling:
		Jump_permission = false


	move_and_slide()

func Gravity_process():
	velocity.y += Gravity
	
	if velocity.y > 0 :
		await get_tree().create_timer(0.1).timeout
		Gravity += 1
	if Gravity > 10: 
		Gravity = 10
	if velocity.y > 175:
		velocity.y = 175

func Player_Abilities():
	$"/root/GlobalVar".HP
	$"/root/GlobalVar".Bullet
	$"/root/GlobalVar".Coin
	$"/root/GlobalVar".Pureness

	
	if Input.is_action_just_pressed("Heal") and $"/root/GlobalVar".HP < 10 and $"/root/GlobalVar".Pureness >= 35:
		$HealParticles.emitting = true
		$"/root/GlobalVar".Pureness -= 35
		$"/root/GlobalVar".HP += 2
	
	if Input.is_action_just_pressed("Shoot") and $"/root/GlobalVar".Bullet >= 1 and !Shooting:
		Shooting = true
		$AnimatedSprite2D.animation = "Shooting"
		if $AnimatedSprite2D.flip_h == true:
			$AnimationPlayer.current_animation = "ShootCam"
			var Bullet_object = Bullet_scene.instantiate()
			get_parent().add_child(Bullet_object)
			Bullet_object.global_position = $ShootSpotRight.global_position
			Bullet_object.Speed = -200
			$"/root/GlobalVar".Bullet -= 1
		else:
			$AnimationPlayer.current_animation = "ShootCam"
			var Bullet_object = Bullet_scene.instantiate()
			get_parent().add_child(Bullet_object)
			Bullet_object.global_position = $ShootSpotRight.global_position
			Bullet_object.Speed = 200
			$"/root/GlobalVar".Bullet -= 1
		await get_tree().create_timer(0.15).timeout
		Shooting = false
	if Input.is_action_just_pressed("ChargeShot") and $"/root/GlobalVar".Pureness >= 25 and !Shooting:
		if !$AnimatedSprite2D.flip_h:
			velocity.x = -80
			move_and_slide()
		else:
			velocity.x = 80
			move_and_slide()
		Shooting = true
		$AnimatedSprite2D.animation = "Shooting"
		if $AnimatedSprite2D.flip_h == true:
			$AnimationPlayer.current_animation = "ShootCam"
			var Charge_bullet_object = Charge_bullet_scene.instantiate()
			get_parent().add_child(Charge_bullet_object)
			Charge_bullet_object.global_position = $ShootSpotRight.global_position
			Charge_bullet_object.Speed = -190
			$"/root/GlobalVar".Pureness -= 28
		else:
			$AnimationPlayer.current_animation = "ShootCam"
			var Charge_bullet_object = Charge_bullet_scene.instantiate()
			get_parent().add_child(Charge_bullet_object)
			Charge_bullet_object.global_position = $ShootSpotRight.global_position
			Charge_bullet_object.Speed = 190
			$"/root/GlobalVar".Pureness -= 28
		await get_tree().create_timer(0.3).timeout
		Shooting = false

func Hurt():
	Protoction = true
	velocity.y = -130
	move_and_slide()
	set_modulate(Color(1.2,0,0,1))
	get_node("/root/World").process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	await get_tree().create_timer(0.1).timeout
	get_node("/root/World").process_mode = Node.PROCESS_MODE_INHERIT
	Protoction = false
	set_modulate(Color(1,1,1,1))

func Jump_Delay():
	await get_tree().create_timer(0.1).timeout
	if !is_on_floor():
		Jump_permission = false

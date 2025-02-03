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
@onready var HP = $"/root/GlobalVar".HP
@onready var Bullet = $"/root/GlobalVar".Bullet
@onready var Coin = $"/root/GlobalVar".Coin
@onready var Pureness = $"/root/GlobalVar".Pureness

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
	HP = $"/root/GlobalVar".HP
	Bullet = $"/root/GlobalVar".Bullet
	Coin = $"/root/GlobalVar".Coin
	Pureness = $"/root/GlobalVar".Pureness
	
	if Input.is_action_just_pressed("Heal") and HP < 10 and Pureness >= 35:
		$HealParticles.emitting = true
		Pureness -= 35
		HP += 2
		$"/root/GlobalVar".HP = HP
		$"/root/GlobalVar".Pureness = Pureness
	
	if Input.is_action_just_pressed("Shoot") and !Shooting:
		Shooting = true
		$AnimatedSprite2D.animation = "Shooting"
		if $AnimatedSprite2D.flip_h == true:
			$AnimationPlayer.current_animation = "ShootCam"
			var Bullet_object = Bullet_scene.instantiate()
			get_parent().add_child(Bullet_object)
			Bullet_object.global_position = $ShootSpotRight.global_position
			Bullet_object.Speed = -200
			Bullet -= 1
			print(Bullet)
			$"/root/GlobalVar".Bullet = Bullet
		else:
			$AnimationPlayer.current_animation = "ShootCam"
			var Bullet_object = Bullet_scene.instantiate()
			get_parent().add_child(Bullet_object)
			Bullet_object.global_position = $ShootSpotRight.global_position
			Bullet_object.Speed = 200
			Bullet -= 1
			print(Bullet)
			$"/root/GlobalVar".Bullet = Bullet
		await get_tree().create_timer(0.15).timeout
		Shooting = false
	if Input.is_action_just_pressed("ChargeShot"):
		pass #left work here
		
	$"/root/GlobalVar".Coin = Coin
	

func Hurt():
	Protoction = true
	velocity.y = -130
	move_and_slide()
	set_modulate(Color(1.2,0,0,1))
	get_node("/root/World").process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	await get_tree().create_timer(0.15).timeout
	get_node("/root/World").process_mode = Node.PROCESS_MODE_INHERIT
	Protoction = false
	set_modulate(Color(1,1,1,1))

func Jump_Delay():
	await get_tree().create_timer(0.1).timeout
	if !is_on_floor():
		Jump_permission = false

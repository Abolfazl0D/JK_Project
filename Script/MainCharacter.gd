extends CharacterBody2D

var Speed = 80
var Jump = -180
var Gravity = 3
var Jump_permission = true
var Protoction = false
var Shoot_Delay = false


func _physics_process(delta):
	
	#print(velocity.y)
	
	Gravity_process()
	
	if is_on_floor():
		velocity.y = 0
		Jump_permission = true

	if Input.is_action_pressed("MoveLeft"):
		velocity.x = -Speed
	
	elif Input.is_action_pressed("MoveRight"):
		velocity.x = Speed
	 
	else: 
		velocity.x = 0 
	
	if Input.is_action_just_pressed("Jump") and Jump_permission:
		velocity.y = Jump
	
	if Input.is_action_just_released("Jump") and !is_on_floor() and velocity.y < -60:
		velocity.y = 5
	
	if !is_on_floor():
		$AnimatedSprite2D.animation = "jump"
	
	if !velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.animation = "walk"
		
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.animation = "idle"
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if velocity.y >= 0 and !is_on_floor_only():
		Jump_Delay()
		#print("Delay Jump_permission = false")
	elif !is_on_floor():
		#print("Jump_Permission = false")
		Jump_permission = false
	


	move_and_slide()

func Gravity_process():
	velocity.y += Gravity
	
	if velocity.y > 0 :
		await get_tree().create_timer(0.1).timeout
		Gravity += 1
	if Gravity > 11: 
		Gravity = 11
	if velocity.y > 180:
		velocity.y = 180

func Jump_Delay():
	if velocity.y >= 0 and !is_on_floor_only():
		await get_tree().create_timer(1).timeout
		if velocity.y >= 0 and !is_on_floor_only():
			Jump_permission = false

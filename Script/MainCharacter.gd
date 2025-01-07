extends CharacterBody2D

var Speed = 80
var Jump = -180
var Gravity = 3
var Jump_permission = true
var Protoction = false
var Shoot_Delay = false


func _physics_process(delta):
	
	print (velocity.y)
	
	Gravity_process()
	
	if is_on_floor():
		velocity.y = 0
	
	
	if Input.is_action_pressed("MoveLeft"):
		velocity.x = -Speed
	
	elif Input.is_action_pressed("MoveRight"):
		velocity.x = Speed
	 
	else: 
		velocity.x = 0 
	
	if is_on_floor():
		Jump_permission = true
	else: 
		Jump_permission = false
		
	if Input.is_action_just_pressed("Jump") and Jump_permission == true:
		velocity.y = Jump
	


	
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

	move_and_slide()

func Gravity_process():
	velocity.y += Gravity
	
	if velocity.y > 0:
		await get_tree().create_timer(0.1).timeout
		Gravity += 1
	if Gravity > 11: 
		Gravity = 11
	if velocity.y > 170:
		velocity.y = 170


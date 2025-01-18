extends CharacterBody2D

var Speed = 75
var Jump = -170
var Gravity = 3
var Jump_permission = true
var Protoction = false
var Shoot_Delay = false
var Falling = false
@onready var HP = $"/root/GlobalVar".HP
@onready var Bullet = $"/root/GlobalVar".Bullet
@onready var Coin = $"/root/GlobalVar".Coin
@onready var Pureness = $"/root/GlobalVar".Pureness

func _physics_process(delta):
	
	#print(velocity.y)
	
	Gravity_process()
	
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
	
	if Input.is_action_just_released("Jump") and !is_on_floor() and velocity.y < -60:
		velocity.y = -20
	
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

func Jump_Delay():
	await get_tree().create_timer(0.1).timeout
	if !is_on_floor():
		Jump_permission = false

func Hurt():
	set_modulate(Color(1,0,0,1))

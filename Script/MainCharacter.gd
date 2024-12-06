extends CharacterBody2D

var Speed = 105
var Jump = -200
var Gravity = 3
var Jump_count = 0
var Protoction = false
var Shoot_Delay = false


func _physics_process(delta):
	
	Gravity_process()
	print(velocity)
	
	if !is_on_floor() :
		$AnimatedSprite2D.animation == "jump"
	
	if velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite2D.animation == "walk"
	
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.animation == "idle"
		

	move_and_slide()



func Gravity_process():
	velocity.y += Gravity
	

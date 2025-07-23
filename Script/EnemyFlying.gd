extends CharacterBody2D

@export var Player = Node2D
var HP = 3
var Damage = 2
var PlayerObserved = false
var Speed = 55
var Gravity = 3
var FloorcheckRight = true
var FloorcheckLeft = true
var Death_Check = false

var move_speed = 10
var Movement_func = false

func _physics_process(delta):

	if HP <= 0:
		velocity.x = 0
		velocity.y = 0
		Death()
		$AnimatedSprite2D.animation = "Death"

	elif !velocity.x == 0:
		$AnimatedSprite2D.animation = "Walking"
	elif velocity.x == 0:
		$AnimatedSprite2D.animation = "Idle"

		
	if PlayerObserved and HP > 0:
		var dir = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = Speed * dir
	
	if !PlayerObserved and HP > 0 and Movement_func == false:
		move_up_and_down()

	move_and_slide()

func _on_hit_box_body_entered(body):
	if body.name == "MainCharacter" and !body.Protoction:
		if $"/root/GlobalVar".HP > 0:
			get_node("/root/GlobalVar").HP -= Damage
			body.Hurt()

	if body.name == "Bullet":
		HP -= 1

func _on_player_observer_body_entered(body):
	PlayerObserved = true

func _on_player_observer_body_exited(body):
	PlayerObserved = false


func _on_timer_timeout():
	$NavigationAgent2D.target_position = Player.global_position


func Hurt():
	#work to do
	velocity.y = -60
	move_and_slide()
	set_modulate(Color(1.2,0,0,1))
	await get_tree().create_timer(0.15).timeout
	set_modulate(Color(1,1,1,1))
	HP -= 1

func Death():
	if !Death_Check:
		Death_Check = true 
		$"/root/GlobalVar".Pureness += 5
		$AnimatedSprite2D.animation = "Death"
		$CollisionPolygon2D.disabled = true
		$HitBox/CollisionShape2D.disabled = true
		$PlayerObserver/CollisionShape2D.disabled = true
		await get_tree().create_timer(10).timeout
		queue_free()

func move_up_and_down():
	velocity = Vector2(0,0)
	move_and_slide()
	Movement_func = true
	velocity.y = 10
	move_and_slide()
	await get_tree().create_timer(1.2).timeout
	velocity.y = 0
	move_and_slide()
	await get_tree().create_timer(1.2).timeout
	velocity.y = -10
	move_and_slide()
	await get_tree().create_timer(1.2).timeout
	velocity.y = 0
	await get_tree().create_timer(1.2).timeout
	move_and_slide()
	Movement_func = false

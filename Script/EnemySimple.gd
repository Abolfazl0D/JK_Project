extends CharacterBody2D


@export var Player = Node2D
var HP = 3
var Damage = 2
var PlayerObserved = false
var Speed = 60
var Gravity = 3

func _physics_process(delta):
	Gravity_process()
	if PlayerObserved:
		var dir = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity.x = Speed * dir.x

	if !PlayerObserved:
		velocity.x = 0

	
	move_and_slide()

func _on_hit_box_body_entered(body):
	if body.name == "MainCharacter" and !body.Protoction:
		get_node("/root/GlobalVar").HP -= Damage
		body.Hurt()

	if body.name == "Bullet":
		HP -= 1


func _on_player_observer_body_entered(body):
	$AnimatedSprite2D.animation = "Walking"
	PlayerObserved = true


func _on_player_observer_body_exited(body):
	$AnimatedSprite2D.animation = "Idle"
	PlayerObserved = false


func _on_timer_timeout():
	$NavigationAgent2D.target_position = Player.global_position

func Gravity_process():
	velocity.y += Gravity
	if velocity.y > 0 :
		await get_tree().create_timer(0.1).timeout
		Gravity += 1
	if Gravity > 10: 
		Gravity = 10
	if velocity.y > 175:
		velocity.y = 175


func _on_navigation_agent_2d_target_reached():
	pass

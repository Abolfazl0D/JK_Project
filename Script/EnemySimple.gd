extends CharacterBody2D

@export var Player = Node2D
var HP = 3
var Damage = 2
var PlayerObserved = false
var Speed = 60
var Gravity = 3
var FloorcheckRight = true
var FloorcheckLeft = true
var Death_Check = false

func _physics_process(delta):
	if HP >= 0:
		Gravity_process()
	
	
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
		if FloorcheckRight and FloorcheckLeft:
			velocity.x = Speed * dir.x
		elif !FloorcheckLeft:
			if dir.x > 0.1:
				FloorcheckLeft = true
			else:
				velocity.x = 0
		elif !FloorcheckRight:
			if dir.x < -0.1:
				FloorcheckRight = true
			else:
				velocity.x = 0
	
	if !PlayerObserved and HP > 0:
		velocity.x = 0

	move_and_slide()

func _on_hit_box_body_entered(body):
	if body.name == "MainCharacter" and !body.Protoction:
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

func Gravity_process():
	velocity.y += Gravity
	if velocity.y > 0 :
		await get_tree().create_timer(0.1).timeout
		Gravity += 1
	if Gravity > 10: 
		Gravity = 10
	if velocity.y > 175:
		velocity.y = 175


func _on_floorcheck_left_body_exited(body):
	if PlayerObserved and body.name == "TileMap":
		FloorcheckLeft = false

func _on_floorcheck_right_body_exited(body):
	if PlayerObserved and body.name == "TileMap":
		FloorcheckRight = false


func _on_floorcheck_left_body_entered(body):
	if body.name == "TileMap":
		FloorcheckLeft = true

func _on_floorcheck_right_body_entered(body):
	if body.name == "TileMap":
		FloorcheckRight = true


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
		$FloorcheckLeft/CollisionShape2D.disabled = true
		$FloorcheckRight/CollisionShape2D.disabled = true
		await get_tree().create_timer(10).timeout
		queue_free()


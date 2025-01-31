extends RigidBody2D

var Speed = 190
var Gravity = 1
var Strike = false




func _physics_process(delta):
	if !Strike:
		Gravity_process()
		linear_velocity.x = Speed
	else:
		linear_velocity = Vector2(0,0)
	
	rotation += 0.12
	


func Gravity_process():
	linear_velocity.y += Gravity
	
	if linear_velocity.y > 0 :
		await get_tree().create_timer(0.1).timeout
		Gravity += 0.7
	if Gravity > 3.5: 
		Gravity = 3.5


func _on_area_2d_body_entered(body):
	if body.name == "TileMap":
		Strike = true
		$AnimatedSprite2D.animation = "Strike"
		await get_tree().create_timer(0.01).timeout
		queue_free()
	elif body.collision_layer == 2 or body.collision_layer == 3 or body.collision_layer == 4 or body.collision_layer == 5:
		body.Hurt()
		Strike = true
		$AnimatedSprite2D.animation = "Strike"
		await get_tree().create_timer(0.01).timeout
		queue_free()
		

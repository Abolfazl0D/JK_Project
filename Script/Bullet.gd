extends RigidBody2D

var Speed = 200
var Gravity = 0.1
var Strike = false




func _physics_process(delta):
	if !Strike:
		Gravity_process()
		linear_velocity.x = Speed
	else:
		linear_velocity = Vector2(0,0)
	
	rotation += 0.18
	


func Gravity_process():
	linear_velocity.y += Gravity
	
	if linear_velocity.y > 0 :
		await get_tree().create_timer(0.05).timeout
		Gravity += 0.1
	if Gravity > 3.5: 
		Gravity = 5


func _on_area_2d_body_entered(body):
	if body.name == "TileMap":
		Strike = true
		queue_free()
	elif body.collision_layer == 2 or body.collision_layer == 3 or body.collision_layer == 4 or body.collision_layer == 5:
		body.Hurt()
		Strike = true
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

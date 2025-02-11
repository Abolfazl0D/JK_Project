extends RigidBody2D

var Speed = 190
var Strike = false


func _physics_process(delta):
	if !Strike:
		linear_velocity.x = Speed
	else:
		$CollisionPolygon2D.disabled = true
		$Area2D/CollisionPolygon2D.disabled = true
		$AnimatedSprite2D.visible = false
		$CPUParticles2D2.visible = false
		linear_velocity = Vector2(0,0)
	
	

func _on_area_2d_body_entered(body):
	if body.name == "TileMap":
		Strike = true
		await get_tree().create_timer(1).timeout
		queue_free()
	elif body.collision_layer == 2 or body.collision_layer == 3 or body.collision_layer == 4 or body.collision_layer == 5:
		body.HP = 0
		Strike = true
		await get_tree().create_timer(1).timeout
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

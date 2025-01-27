extends RigidBody2D

var Speed = 180
var Gravity = 2



func _physics_process(delta):
	Gravity_process()
	linear_velocity.x = Speed
	
	


func Gravity_process():
	linear_velocity.y += Gravity
	
	if linear_velocity.y > 0 :
		await get_tree().create_timer(0.1).timeout
		Gravity += 0.7
	if Gravity > 4: 
		Gravity = 4


func _on_area_2d_body_entered(body):
	if body.name == "TileMap":
		queue_free()

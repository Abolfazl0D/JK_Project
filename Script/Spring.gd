extends Area2D



func _on_body_entered(body):
	if body.name == "MainCharacter":
		body.Spring_Pushed()
		$AnimatedSprite2D.play()

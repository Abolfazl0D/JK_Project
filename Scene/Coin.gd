extends Area2D




func _on_body_entered(body):
	if body.name == "MainCharacter":
		get_node("/root/GlobalVar").Coin += 1
		queue_free()

extends Node2D

var Opened = false
var Player = false

func _process(delta):
	if Input.is_action_just_pressed("RefillBullet") and !Opened and Player:
		if get_node("/root/GlobalVar").Coin >= 50 and get_node("/root/GlobalVar").Bullet < 50:
			get_node("/root/GlobalVar").Coin -= 50
			get_node("/root/GlobalVar").Bullet = 50
			Opened = true
			$CanvasLayer/Label.visible = false
			$Coin.visible = false
			$Bullet.visible = false
			$OpenedChest.visible = true
			$ClosedChest.visible = false
	if Player:
		$CanvasLayer/Label.visible = true
	elif !Player:
		$CanvasLayer/Label.visible = false


func _on_area_2d_body_entered(body):
	if body.name == "MainCharacter":
		Player = true


func _on_area_2d_body_exited(body):
	if body.name == "MainCharacter":
		Player = false

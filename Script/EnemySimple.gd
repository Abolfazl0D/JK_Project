extends CharacterBody2D

@export var Player = Node2D
var HP = 3
var Damage = 3

func _ready():
	pass


func _physics_process(delta):
	pass



func _on_hit_box_body_entered(body):
	if body.name == "MainCharacter":
		$"/root/GlobalVar".HP -= Damage
		body.Hurt()
	if body.name == "Bullet":
		HP -= 1

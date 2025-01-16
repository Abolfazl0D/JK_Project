extends Node2D

@onready var Pureness = $"/root/GlobalVar".Pureness
@onready var PurenessBar = $AnimatedSprite2D

func _process(delta):
	if Pureness == 0:
		PurenessBar.frame = 0
	if 5 >= Pureness > 0:
		PurenessBar.frame = 1
	if 10 >= Pureness > 5:
		PurenessBar.frame = 2

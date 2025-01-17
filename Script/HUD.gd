extends Node2D

@onready var Pureness = get_node("/root/GlobalVar").Pureness
@onready var PurenessBar = $CanvasLayer/Purenessbar

func _process(delta):
	PurenessBarRefresh()

func PurenessBarRefresh():
	if 5 > Pureness or Pureness == 0:
		PurenessBar.frame = 0
	elif 10 > Pureness and Pureness >= 5:
		PurenessBar.frame = 1
	elif 15 > Pureness and Pureness >= 10:
		PurenessBar.frame = 2
	elif 20 > Pureness and Pureness >= 15:
		PurenessBar.frame = 3
	elif 25 > Pureness and Pureness >= 20:
		PurenessBar.frame = 4
	elif 30 > Pureness and Pureness >= 25:
		PurenessBar.frame = 5
	elif 35 > Pureness and Pureness >= 30:
		PurenessBar.frame = 6
	elif 40 > Pureness and Pureness >= 35:
		PurenessBar.frame = 7
	elif 45 > Pureness and Pureness >= 40:
		PurenessBar.frame = 8
	elif 50 > Pureness and Pureness >= 45:
		PurenessBar.frame = 9
	elif 55 > Pureness and Pureness >= 50:
		PurenessBar.frame = 10
	elif 60 > Pureness and Pureness >= 55:
		PurenessBar.frame = 11
	elif 65 > Pureness and Pureness >= 60:
		PurenessBar.frame = 12
	elif 70 > Pureness and Pureness >= 65:
		PurenessBar.frame = 13
	elif 75 > Pureness and Pureness >= 70:
		PurenessBar.frame = 14
	elif 80 > Pureness and Pureness >= 75:
		PurenessBar.frame = 15
	elif 85 > Pureness and Pureness >= 80:
		PurenessBar.frame = 16
	elif 90 > Pureness and Pureness >= 85:
		PurenessBar.frame = 17
	elif 95 > Pureness and Pureness >= 90:
		PurenessBar.frame = 18
	elif 100 > Pureness and Pureness >= 95:
		PurenessBar.frame = 19
	elif Pureness == 100:
		PurenessBar.frame = 20
	elif Pureness >= 100:
		Pureness = 100
		PurenessBar.frame = 20
	elif Pureness < 0:
		Pureness = 0
		PurenessBar.frame = 0

func HPBarRefresh():
	pass

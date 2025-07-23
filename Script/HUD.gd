extends Node2D

@onready var Pureness = get_node("/root/GlobalVar").Pureness
@onready var PurenessBar = $CanvasLayer/Purenessbar
@onready var HP = get_node("/root/GlobalVar").HP
@onready var Heart = $CanvasLayer/Heart
@onready var Bullet = get_node("/root/GlobalVar").Bullet
@onready var Bullet_count = $CanvasLayer/Label
@onready var Coin = get_node("/root/GlobalVar").Coin
@onready var Coin_count = $CanvasLayer/Label2


func _process(delta):
	HP = get_node("/root/GlobalVar").HP
	Pureness = get_node("/root/GlobalVar").Pureness
	Bullet = get_node("/root/GlobalVar").Bullet
	Coin = get_node("/root/GlobalVar").Coin
	PurenessBarRefresh()
	HPBarRefresh()
	BulletRefresh()
	CoinRefresh()

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
	
	if HP == 0:
		Heart.frame = 0
	elif HP < 0:
		get_node("/root/GlobalVar").HP = 0
		Heart.frame = 0
	elif HP == 1:
		Heart.frame = 1
	elif HP == 2:
		Heart.frame = 2
	elif HP == 3:
		Heart.frame = 3
	elif HP == 4:
		Heart.frame = 4
	elif HP == 5:
		Heart.frame = 5
	elif HP == 6:
		Heart.frame = 6
	elif HP == 7:
		Heart.frame = 7
	elif HP == 8:
		Heart.frame = 8
	elif HP == 9:
		Heart.frame = 9
	elif HP == 10:
		Heart.frame = 10
	elif HP > 10:
		get_node("/root/GlobalVar").HP = 10
		Heart.frame = 10

func BulletRefresh():
	var Bullet_str = str(Bullet)
	$CanvasLayer/Label.text = Bullet_str

func CoinRefresh():
	var Coin_str = str(Coin)
	$CanvasLayer/Label2.text = Coin_str

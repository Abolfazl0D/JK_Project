extends StaticBody2D

var Path = "user://DATA.dat"
var Path_2 = "user://DATA_2.dat" 
var Path_3 = "user://DATA_3.dat" 


func _ready():
	load_Level()
	load_Coin()
	load_Bullet()

func _on_area_2d_body_entered(body):
	$AnimatedSprite2D.frame = 1
	get_node("/root/GlobalVar").Level += 1
	Save_Level()
	Save_Coin()
	Save_Bullet()
	await get_tree().create_timer(0.5).timeout
	var Level = str(get_node("/root/GlobalVar").Level)
	get_tree().change_scene_to_file("res://Scene/Levels/Level"+Level+".tscn")
	

func Save_Level():
	var file = FileAccess.open(Path, FileAccess.WRITE)
	file.store_var(get_node("/root/GlobalVar").Level)

func load_Level():
	var file = FileAccess.open(Path, FileAccess.READ)
	if file == null:
		get_node("/root/GlobalVar").Level = 1
	elif file:
		get_node("/root/GlobalVar").Level = file.get_var()
func Save_Coin():
	var file = FileAccess.open(Path_2, FileAccess.WRITE)
	file.store_var(get_node("/root/GlobalVar").Coin)

func load_Coin():
	var file = FileAccess.open(Path_2, FileAccess.READ)
	if file == null:
		get_node("/root/GlobalVar").Coin = 1
	elif file:
		get_node("/root/GlobalVar").Coin = file.get_var()

func Save_Bullet():
	var file = FileAccess.open(Path_3, FileAccess.WRITE)
	file.store_var(get_node("/root/GlobalVar").Bullet)

func load_Bullet():
	var file = FileAccess.open(Path_3, FileAccess.READ)
	if file == null:
		Save_Bullet()
	elif file:
		get_node("/root/GlobalVar").Bullet = file.get_var()



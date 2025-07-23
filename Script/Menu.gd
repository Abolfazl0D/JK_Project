extends Node2D

var Path = "user://DATA.dat"

func _ready():
	load_Level()

func load_Level():
	var file = FileAccess.open(Path, FileAccess.READ)
	if file == null:
		get_node("/root/GlobalVar").Level = 1
	elif file:
		get_node("/root/GlobalVar").Level = file.get_var()


func _on_exit_pressed():
	get_tree().quit()


func _on_tips_pressed():
	get_tree().change_scene_to_file("res://Scene/Tips.tscn")


func _on_start_pressed():
	var Level = str(get_node("/root/GlobalVar").Level)
	get_tree().change_scene_to_file("res://Scene/Levels/Level"+Level+".tscn")

extends Node2D

var Paused = false

func _process(delta):
	if Paused == false and Input.is_action_just_pressed("Pause"):
		$CanvasLayer.visible = true
		Paused = true
		get_node("/root").process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	elif Paused == true and Input.is_action_just_pressed("Pause"):
		$CanvasLayer.visible = false
		Paused = false
		get_node("/root").process_mode = Node.PROCESS_MODE_ALWAYS

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")


func _on_resume_pressed():
	if Paused == true:
		$CanvasLayer.visible = false
		Paused = false
		get_node("/root").process_mode = Node.PROCESS_MODE_ALWAYS

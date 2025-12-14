extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Pause"):
		if get_tree().paused == true:
			get_tree().paused = false
		else:
			get_tree().paused = true
	
	if Input.is_action_just_pressed("Select") and get_tree().paused == true:
		visible = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/pieces/menu.tscn")

func _process(delta: float) -> void:
	if get_tree().paused == true:
		visible = true
	else:
		visible = false

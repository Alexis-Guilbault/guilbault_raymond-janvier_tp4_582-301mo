extends Node2D

func _input(input) -> void:
	if Input.is_action_just_pressed("Select") or Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://scenes/pieces/menu.tscn")

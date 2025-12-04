extends Node2D

func _input(input) -> void:
	if input == "select" or input == "pause":
		get_tree().change_scene_to_file("res://scenes/pieces/menu.tscn")

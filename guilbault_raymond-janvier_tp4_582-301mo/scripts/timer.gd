extends Node2D

var difficulty = Config.difficulty
var minutes = difficulty * 4
var secondes = 60
var frames = 99

func _process(delta: float) -> void:
	if $"../../Jeu".game_ready == true:
		frames -= 1
	
	if frames == 0:
		frames = 100
		secondes -= 1
	
	if secondes == 0:
		secondes = 60
		minutes -= 1
	
	if minutes == 0:
		get_tree().change_scene_to_file("res://scenes/pieces/game_over.tscn")
	
	$"./Label".text = str(minutes -1) + ":" + str(secondes -1) + ":" + str(frames -1)

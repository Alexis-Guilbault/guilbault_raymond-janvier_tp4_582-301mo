extends Node2D

var difficulty = Config.difficulty
var minutes = (difficulty * 4 + difficulty) *2
var secondes = 60
var frames = 99

func _process(_delta: float) -> void:
	if $"../../Jeu".game_ready == true:
		frames -= 1
	
	if frames == 0:
		if minutes == 1 and secondes <= 10:
			$"./AudioStreamPlayer2".play()
		frames = 100
		secondes -= 1
	
	if secondes == 0:
		$"./AudioStreamPlayer2".play()
		secondes = 60
		minutes -= 1
	
	if minutes == 0:
		$"./AudioStreamPlayer".play()
		get_tree().change_scene_to_file("res://scenes/pieces/game_over.tscn")
	
	$"./Label".text = str(minutes -1) + ":" + str(secondes -1) + ":" + str(frames -1)

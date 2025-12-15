extends Node2D

var game_ready = true

func _ready() -> void:
	if Config.music_choice == 1:
		$"./AudioStreamPlayer".play()
	else:
		$"./AudioStreamPlayer2".play()

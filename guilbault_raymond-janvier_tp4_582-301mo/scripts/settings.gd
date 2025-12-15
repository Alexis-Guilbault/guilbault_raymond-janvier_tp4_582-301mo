extends Node2D

var choice = 1
## Choices
# 1 = difficulté
# 2 = image puzzle
# 3 = image fond
# 4 = musique

var difficulty = 1
## Difficulty Settings
# 1 = 4x4, 4 minutes
# 2 = 8x8, 8 minutes
# 3 = 12x12, 12 minutes
# 4 = 16x16, 16 minutes
# 5 = 20x20, 20 minutes
var difficulty_setting = [1, 2, 3, 4, 5]

var puzzle_image = 1
## Puzzle Image Settings
# 1 = ???
# 2 = ???
# 3 = ???
var puzzle_image_setting = [1]

var background_image = 1
## Background Image Settings
# 1 = ???
# 2 = ???
# 3 = ???
var background_image_setting = [1]

var music_choice = 1
## Background Music Settings
# 1 = Type A
# 2 = Type B
var music_setting = [1, 2]

@onready var labels = [$"./difficulte/Label", $"./casse-tete/Label2", $"./fond/Label3", $"./musique/Label4"]
@onready var difficulty_bars = [$"./difficulte/difficulte1", $"./difficulte/difficulte2", $"./difficulte/difficulte3", $"./difficulte/difficulte4", $"./difficulte/difficulte5"]
@onready var puzzle_bars = [$"./casse-tete/puzzle1"]
@onready var background_bars = [$"./fond/fond1"]
@onready var music_bars = [$"./musique/musique1", $"./musique/musique2"]

func _input(_event) -> void:
	if Input.is_action_just_pressed("Select"):
		Config.difficulty = difficulty
		Config.puzzle_image = puzzle_image
		Config.background_image = background_image
		Config.music_choice = music_choice
		$"./AudioStreamPlayer3".play()
		get_tree().change_scene_to_file("res://scenes/pieces/jeu_puzzle.tscn")
		
	
	if Input.is_action_just_pressed("Pause"):
		$"./AudioStreamPlayer2".play()
		get_tree().change_scene_to_file("res://scenes/pieces/menu.tscn")
	
	if Input.is_action_just_pressed("Up"):
		choice -= 1
		if choice < 1:
			choice = 4
		$"./AudioStreamPlayer".play()
	
	if Input.is_action_just_pressed("Down"):
		choice += 1
		if choice > 4:
			choice = 1
		$"./AudioStreamPlayer".play()
	
	if Input.is_action_just_pressed("Left"):
		match choice:
			1: 
				if difficulty > 1:
					difficulty -= 1
			2:
				if puzzle_image > 1:
					puzzle_image -= 1
			3:
				if background_image > 1:
					background_image -= 1
			4:
				if music_choice > 1:
					music_choice -= 1
		$"./AudioStreamPlayer3".play()
	
	if Input.is_action_just_pressed("Right"):
		match choice:
			1: 
				if difficulty < difficulty_setting.size():
					difficulty += 1
			2:
				if puzzle_image < puzzle_image_setting.size():
					puzzle_image += 1
			3:
				if background_image < background_image_setting.size():
					background_image += 1
			4:
				if music_choice < music_setting.size():
					music_choice += 1
		$"./AudioStreamPlayer3".play()

func _process(_delta: float) -> void:
	for label_index in labels:
		if labels.find(label_index) + 1 == choice:
			label_index.label_settings.font_color = Color.RED
		else:
			label_index.label_settings.font_color = Color.WHITE
	
	for dif_bars in difficulty_bars:
		if difficulty_bars.find(dif_bars) + 1 == difficulty:
			dif_bars.default_color = Color.RED
		else:
			dif_bars.default_color = Color.WHITE
	
	for puz_bars in puzzle_bars:
		if puzzle_bars.find(puz_bars) + 1 == puzzle_image:
			puz_bars.default_color = Color.RED
		else:
			puz_bars.default_color = Color.WHITE
	
	for back_bars in background_bars:
		if background_bars.find(back_bars) + 1 == background_image:
			back_bars.default_color = Color.RED
		else:
			back_bars.default_color = Color.WHITE
	
	for mus_bars in music_bars:
		if music_bars.find(mus_bars) + 1 == music_choice:
			mus_bars.default_color = Color.RED
		else:
			mus_bars.default_color = Color.WHITE

extends Node2D

var puzzle_image = Config.puzzle_image
var difficulty = Config.difficulty

@onready var difficulties = [$"./4x4", $"./8x8", $"./12x12", $"./16x16", $"./20x20"]
@onready var hovers = [$"./4x4/hover", $"./8x8/hover", $"./12x12/hover", $"./16x16/hover", $"./20x20/hover"]
@onready var hooks = [$"./4x4/hook", $"./8x8/hook", $"./12x12/hook", $"./16x16/hook", $"./20x20/hook"]

var result = []
var shuffle_number = []
var puzzle_pieces = []
var puzzle = 0

var hover = 0
var hook = 0

var hovered_piece = 0
var selected_pieces = []

func _ready() -> void:
	for puzzles in difficulties:
		if difficulties.find(puzzles) + 1 == difficulty:
			puzzle = puzzles
			hover = hovers[difficulties.find(puzzles)]
			hook = hooks[difficulties.find(puzzles)]
		else:
			puzzles.queue_free()
	
	result = puzzle.get_children()
	result.pop_at(result.find(hover))
	result.pop_at(result.find(hook))
	
	for org_piece in result:
		shuffle_number.push_back(result.find(org_piece))
		puzzle_pieces.push_back(0)
	
	for shuff_piece in puzzle_pieces:
		var place = randi_range(0,shuffle_number.size()-1)
		puzzle_pieces[puzzle_pieces.find(shuff_piece)] = result[shuffle_number[place]]
		shuffle_number.pop_at(place)
	
	for piece in result:
		match Config.puzzle_image:
			1:
				piece.animation = "puzzle01"
			2:
				piece.animation = "puzzle02"
			3:
				piece.animation = "puzzle03"
		piece.frame = puzzle_pieces.find(piece)
	
	hook.animation = "select"

func _process(_delta: float) -> void:
	if result == puzzle_pieces:
		$"./AudioStreamPlayer3".play()
		get_tree().change_scene_to_file("res://scenes/pieces/victoire.tscn")
	
	if selected_pieces.size() >= 2:
			var piece_switch1 = selected_pieces[0]
			var piece_switch2 = selected_pieces[1]
			
			var i1 = puzzle_pieces.find(piece_switch1)
			var i2 = puzzle_pieces.find(piece_switch2)
			
			puzzle_pieces[i1] = piece_switch2
			puzzle_pieces[i2] = piece_switch1
			
			$"./AudioStreamPlayer2".play()
			
			selected_pieces.clear()
	
	hover.position.x = result[hovered_piece].position.x
	hover.position.y = result[hovered_piece].position.y
	
	if selected_pieces.size() == 0:
		hook.position.x = result[hovered_piece].position.x
		hook.position.y = result[hovered_piece].position.y
	
	for piece in puzzle_pieces:
		piece.frame = puzzle_pieces.find(piece)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Select"):
		$"./AudioStreamPlayer".play()
		selected_pieces.push_back(result[hovered_piece])
	
	if Input.is_action_just_pressed("Left"):
		if hovered_piece > 0:
			hovered_piece -= 1
		else:
			hovered_piece = puzzle_pieces.size()-1
	
	if Input.is_action_just_pressed("Right"):
		if hovered_piece < puzzle_pieces.size()-1:
			hovered_piece += 1
		else:
			hovered_piece = 0
	
	if Input.is_action_just_pressed("Up"):
		hovered_piece -= (difficulty * 4)
		if hovered_piece < 0:
			hovered_piece += (difficulty * 4)^2
	
	if Input.is_action_just_pressed("Down"):
		hovered_piece += (difficulty * 4)
		if hovered_piece > puzzle_pieces.size()-1:
			hovered_piece -= (difficulty * 4)^2

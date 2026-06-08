extends Node2D


const SNAKE_TILE_ID: int = 0
const FIRST_LAYER: int = 0
const SNAKE_BODY_COORDS:Vector2i = Vector2i(0, 0)
const GAME_BOARD: Array[Vector2i] = []
var snake_direction: Vector2i = Vector2i(1, 0)
var snake_body: Array[Vector2i] = [
	Vector2i(5, 10),
	Vector2i(4, 10),
	Vector2i(3, 10),
]


func _on_game_tick_timeout() -> void:
	move_snake()
	draw_snake()


func draw_snake() -> void:
	for cell in snake_body:
		$GameTile.set_cell(
			FIRST_LAYER,
			cell,
			SNAKE_TILE_ID,
			SNAKE_BODY_COORDS
		)


func move_snake() -> void:
	erase_trail()
	var body_copy = snake_body.duplicate()
	body_copy.pop_back()
	var new_head = snake_body.front() + snake_direction
	body_copy.insert(0, new_head)
	snake_body = body_copy
	


func erase_trail() -> void:
	var used_cells = $GameTile.get_used_cells_by_id(
		FIRST_LAYER,
		SNAKE_TILE_ID
	)
	for cell in used_cells:
		var cell_coords: Vector2i = Vector2i(
			cell.x,
			cell.y
		)
		$GameTile.erase_cell(FIRST_LAYER, cell_coords)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		snake_direction = Vector2i(0, -1)
	if Input.is_action_just_pressed("ui_right"):
		snake_direction = Vector2i(1, 0)
	if Input.is_action_just_pressed("ui_down"):
		snake_direction = Vector2i(0, 1)
	if Input.is_action_just_pressed("ui_left"):
		snake_direction = Vector2i(-1, 0)

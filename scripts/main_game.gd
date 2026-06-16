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
var apple_position: Vector2i
enum TileRotation {
	RIGHT = 0,
	DOWN = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	LEFT = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	UP = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V,
}


func _ready() -> void:
	draw_apple()


func _on_game_tick_timeout() -> void:
	move_snake()
	draw_snake()


func draw_snake() -> void:
	for index in snake_body.size():
		if index == 0:
			$GameTile.set_cell(
			FIRST_LAYER,
			snake_body[index],
			SNAKE_TILE_ID,
			Vector2i(1, 0),
			get_head_direction()
		)
		else:
			$GameTile.set_cell(
				FIRST_LAYER,
				snake_body[index],
				SNAKE_TILE_ID,
				SNAKE_BODY_COORDS
			)


func draw_apple() -> void:
	var random_coords := Vector2i(
		randi_range(0, 19),
		randi_range(0, 19)
	)
	if random_coords in snake_body:
		draw_apple()
	apple_position = random_coords
	$GameTile.set_cell(
		FIRST_LAYER,
		random_coords,
		1,
		Vector2i(0, 0)
	)


func move_snake() -> void:
	erase_trail()
	var body_copy = snake_body.duplicate()
	var new_head = snake_body.front() + snake_direction
	if new_head == apple_position:
		draw_apple()
	else:
		body_copy.pop_back()
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


func get_head_direction() -> TileRotation:
	if snake_direction == Vector2i.UP:
		return TileRotation.UP
	elif snake_direction == Vector2i.RIGHT:
		return TileRotation.RIGHT
	elif snake_direction == Vector2i.DOWN:
		return TileRotation.DOWN
	elif snake_direction == Vector2i.LEFT:
		return TileRotation.LEFT
	else:
		return TileRotation.RIGHT


func is_valid_move(new_direction: Vector2i) -> bool:
	if snake_direction.x == -new_direction.x:
		return false
	if snake_direction.y == -new_direction.y:
		return false
	return true


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up") and is_valid_move(Vector2i.UP):
		snake_direction = Vector2i.UP
	if Input.is_action_just_pressed("ui_right") and is_valid_move(Vector2i.RIGHT):
		snake_direction = Vector2i.RIGHT
	if Input.is_action_just_pressed("ui_down") and is_valid_move(Vector2i.DOWN):
		snake_direction = Vector2i.DOWN
	if Input.is_action_just_pressed("ui_left") and is_valid_move(Vector2i.LEFT):
		snake_direction = Vector2i.LEFT

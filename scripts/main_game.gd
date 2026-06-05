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
	draw_snake()
	move_snake()


func draw_snake() -> void:
	for cell in snake_body:
		$GameTile.set_cell(
			FIRST_LAYER,
			cell,
			SNAKE_TILE_ID,
			SNAKE_BODY_COORDS
		)


func erase_trail() -> void:
	pass


func move_snake() -> void:
	var snake_body_copy: Array[Vector2i] = snake_body.slice(1)
	var new_head: Vector2i = snake_body[0] + Vector2i(1, 0)
	snake_body_copy.insert(0, new_head)
	snake_body = snake_body_copy


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		snake_direction = Vector2i(0, -1)
	if Input.is_action_just_pressed("ui_right"):
		snake_direction = Vector2i(1, 0)
	if Input.is_action_just_pressed("ui_down"):
		snake_direction = Vector2i(0, 1)
	if Input.is_action_just_pressed("ui_left"):
		snake_direction = Vector2i(-1, 0)

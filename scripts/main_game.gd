extends Node2D


const SNAKE_TILE_ID: int = 0
const FIRST_LAYER: int = 0
const SNAKE_BODY_COORDS:Vector2i = Vector2i(0, 0)
const GAME_BOARD: Array[Vector2i] = []
const SNAKE_BODY: Array[Vector2i] = [
	Vector2i(5, 10),
	Vector2i(4, 10),
	Vector2i(3, 10),
]


func _on_game_tick_timeout() -> void:
	draw_snake()


func draw_snake() -> void:
	for cell in SNAKE_BODY:
		$GameTile.set_cell(
			FIRST_LAYER,
			cell,
			SNAKE_TILE_ID,
			SNAKE_BODY_COORDS
		)

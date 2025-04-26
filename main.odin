package main

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
WINDOW_PADDING :: 5

main :: proc() {
	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Blockball")
	defer rl.CloseWindow()


	player_pos_x := 360.0

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		if (rl.IsKeyDown(rl.KeyboardKey.A) && player_pos_x >= WINDOW_PADDING) {
			player_pos_x -= 0.01
		}

		if (rl.IsKeyDown(rl.KeyboardKey.D) &&
			   player_pos_x <= WINDOW_WIDTH - PLAYER_BLOCK_WIDHT - WINDOW_PADDING) {
			player_pos_x += 0.01
		}

		draw_player_block(i32(player_pos_x))

		rl.EndDrawing()
	}
}

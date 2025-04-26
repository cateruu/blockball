package main

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

WINDOW_WIDTH :: 800
WINDOW_HEIGHT :: 600
WINDOW_PADDING :: 5
SPEED: f32 : 300

main :: proc() {
	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Blockball")
	defer rl.CloseWindow()
	rl.SetTargetFPS(144)

	player_pos_x: f32 = 360.0
	ball_pos_y: f32 = 0.0

	for !rl.WindowShouldClose() {
		delta := rl.GetFrameTime()
		distance := delta * SPEED

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		if (rl.IsKeyDown(rl.KeyboardKey.A) && player_pos_x >= WINDOW_PADDING) {
			player_pos_x -= distance
		}

		if (rl.IsKeyDown(rl.KeyboardKey.D) &&
			   player_pos_x <= WINDOW_WIDTH - PLAYER_BLOCK_WIDHT - WINDOW_PADDING) {
			player_pos_x += distance
		}

		draw_player_block(i32(player_pos_x))

		draw_ball(10, i32(ball_pos_y))
		ball_pos_y += distance

		rl.DrawLine(0, 590, 800, 590, rl.WHITE)

		if rl.CheckCollisionCircleLine({10, f32(ball_pos_y)}, BALL_RADIUS, {0, 590}, {800, 590}) {
			fmt.println("You lost!")
		}

		rl.EndDrawing()
	}
}

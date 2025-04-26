package main

import "core:fmt"
import vmem "core:mem/virtual"
import "core:strings"
import rl "vendor:raylib"

WINDOW_WIDTH: f32 : 800
WINDOW_HEIGHT: f32 : 600
WINDOW_PADDING: f32 : 5
SPEED: f32 : 300

BALL_MOVEMENT :: enum {
	UP,
	DOWN,
}

main :: proc() {
	rl.InitWindow(i32(WINDOW_WIDTH), i32(WINDOW_HEIGHT), "Blockball")
	defer rl.CloseWindow()
	rl.SetTargetFPS(144)

	player_pos_x: f32 = 360.0
	ball_pos_y: f32 = 0.0
	ball_direction := BALL_MOVEMENT.DOWN

	level_arena: vmem.Arena
	arena_allocator := vmem.arena_allocator(&level_arena)

	targets := generate_targets(10, 10, arena_allocator)

	for !rl.WindowShouldClose() {
		delta := rl.GetFrameTime()
		distance := delta * SPEED

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		draw_targets(targets)

		if (rl.IsKeyDown(rl.KeyboardKey.A) && player_pos_x >= WINDOW_PADDING) {
			player_pos_x -= distance
		}

		if (rl.IsKeyDown(rl.KeyboardKey.D) &&
			   player_pos_x <= WINDOW_WIDTH - PLAYER_BLOCK_WIDHT - WINDOW_PADDING) {
			player_pos_x += distance
		}

		draw_player_block(i32(player_pos_x))

		draw_ball(10, i32(ball_pos_y))

		if ball_direction == .DOWN {
			ball_pos_y += distance
		} else {
			ball_pos_y -= distance
		}

		rl.DrawLine(0, 590, 800, 590, rl.WHITE)

		// End game check
		if rl.CheckCollisionCircleLine({10, f32(ball_pos_y)}, BALL_RADIUS, {0, 590}, {800, 590}) {
			fmt.println("You lost!")
			vmem.arena_free_all(&level_arena)
		}

		// Top border collision
		if rl.CheckCollisionCircleLine({10, f32(ball_pos_y)}, BALL_RADIUS, {0, 0}, {800, 0}) {
			ball_direction = .DOWN
		}

		// Player collision
		if rl.CheckCollisionCircleRec(
			{10, f32(ball_pos_y)},
			BALL_RADIUS,
			{player_pos_x, PLAYER_BLOCK_POS_Y, PLAYER_BLOCK_WIDHT, PLAYER_BLOCK_HEIGHT},
		) {
			ball_direction = .UP
		}

		rl.EndDrawing()
	}
}

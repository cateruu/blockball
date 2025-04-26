package main

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

Target :: struct {
	hit:      bool,
	position: rl.Vector2,
	size:     rl.Vector2,
	color:    rl.Color,
}

TARGET_MARGIN :: 2

generate_targets :: proc(rows, cols: int, allocator := context.allocator) -> [][]Target {
	target_width: f32 = WINDOW_WIDTH / f32(cols) - TARGET_MARGIN
	target_height: f32 = WINDOW_WIDTH / f32(rows) / 3 - TARGET_MARGIN
	targets := make([][]Target, rows, allocator)


	row_start: f32 = 0
	col_start: f32 = 0
	for i in 0 ..< rows {
		targets[i] = make([]Target, cols, allocator)

		if i != 0 {
			row_start += target_height + TARGET_MARGIN
		}

		col_start = 0

		for j in 0 ..< cols {
			if (j != 0) {
				col_start += target_width + TARGET_MARGIN
			}

			targets[i][j] = Target {
				false,
				{col_start, row_start},
				{target_width, target_height},
				{u8(rand.int_max(255)), u8(rand.int_max(255)), u8(rand.int_max(255)), 255},
			}
		}
	}

	return targets
}

draw_targets :: proc(targets: [][]Target) {
	for i in 0 ..< len(targets) {
		for j in 0 ..< len(targets[0]) {
			target := targets[i][j]
			rl.DrawRectangle(
				i32(target.position.x),
				i32(target.position.y),
				i32(target.size.x),
				i32(target.size.y),
				target.color,
			)
		}
	}
}

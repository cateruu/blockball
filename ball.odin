package main

import rl "vendor:raylib"

BALL_RADIUS :: 6

draw_ball :: proc(pos_x, pos_y: i32) {
	rl.DrawCircle(pos_x, pos_y, BALL_RADIUS, rl.RED)
}

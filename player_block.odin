package main

import rl "vendor:raylib"

PLAYER_BLOCK_WIDHT :: 80
PLAYER_BLOCK_HEIGHT :: 15
PLAYER_BLOCK_POS_Y :: 570

draw_player_block :: proc(posX: i32) {
	rl.DrawRectangle(posX, PLAYER_BLOCK_POS_Y, PLAYER_BLOCK_WIDHT, PLAYER_BLOCK_HEIGHT, rl.BLUE)
}

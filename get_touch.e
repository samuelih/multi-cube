

// USAGE: call  get_touch  get_touch_ret
// Return Parameters: touched (bool value, 0 = no touch | 1 = touched),
//		      color_touched (true color value for touched color, if touched == 1)



		
get_touch	//return to home screen if switch is turned off.
		and		gs_switch		0x80000000		gt_one
		cp		gs_is_home		gs_zero
		be		game_select		gs_switch		gt_zero
		
		call		touch_driver		touch_ret
		cp		touched			touch_pressed
		bne		get_touch_end		touch_pressed		vga_one		
		cp		vga_x1			touch_x
		cp		vga_y1			touch_y
		cp		vga_write		vga_zero
		call		vga_driver		vga_ret
		cp		color_touched		vga_color_read


get_touch_end	ret		get_touch_ret


gt_one		1
gt_zero		0

color_touched	0
touched		0

get_touch_ret	0





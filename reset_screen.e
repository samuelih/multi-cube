
//  Resets the VGA monitor to a blank white screen

//  Usage: call  reset_screen  reset_screen_ret
//  Requires VGA driver


reset_screen		cp		vga_x1			vga_x_min
			cp		vga_y1			vga_y_min
			cp		vga_x2			vga_x_max
			cp		vga_y2			vga_y_max
			cp		vga_write		vga_one
			cp		vga_color_write		white
	    		call    	vga_driver    		vga_ret
			ret		reset_screen_ret

reset_screen_ret	0

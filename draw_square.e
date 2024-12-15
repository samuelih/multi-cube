//  Draws square given point and side length




draw_square	div	ds_half			ds_length	ds_two
		sub	ds_x1			ds_x		ds_length
		add	ds_x2			ds_x		ds_length
		sub	ds_y1			ds_y		ds_length
		add	ds_y2			ds_y		ds_length				


		bne	ds_skip_outline		ds_outline	ds_one	

		cp	ds_temp			ds_x1
		sub	ds_temp			ds_temp		ds_thickness
		cp	vga_x1			ds_temp

		cp	ds_temp			ds_y1
		sub	ds_temp			ds_temp		ds_thickness
		cp	vga_y1			ds_temp

		cp	ds_temp			ds_x2
		add	ds_temp			ds_temp		ds_thickness
		cp	vga_x2			ds_temp

		cp	ds_temp			ds_y2
		add	ds_temp			ds_temp		ds_thickness
		cp	vga_y2			ds_temp

		cpdata	vga_write		1
		cp	vga_color_write		black

	    	call    vga_driver    		vga_ret	



ds_skip_outline	cp	vga_x1			ds_x1
		cp	vga_y1			ds_y1
		cp	vga_x2			ds_x2
		cp	vga_y2			ds_y2
		cp	vga_write		ds_one
		cp	vga_color_write		ds_color
	    	call    vga_driver    		vga_ret	
		ret	ds_ret


ds_x		0
ds_y		0
ds_length	0
ds_outline	0
ds_ret		0
ds_color	0


//local vars 
ds_x1		0
ds_x2		0
ds_y1		0
ds_y2		0
ds_half		0

ds_one		1
ds_two		2
ds_thickness	2

ds_temp		0
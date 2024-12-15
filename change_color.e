

//  USAGE: call  change_color  change_color_ret


//  Parameters:    old_color (must be: red, blue, green, purple, yellow, or orange)
//		   dim_or_light (0 = dim | 1 = light | 2 = revert)
//  Return values: new_color (24-bit true color | shades of red, blue, green, purple, yellow, orange)

//  EXAMPLE:
//		cp	dim_or_light	dim
//		call	get_touch	get_touch_ret
//		cp	old_color	color_touched
//		bne	(loop_var)	touched		 vga_one
//		call	change_color	change_color_ret
//		cp	(variable)	new_color



change_color		be	cc_is_red		old_color	red
			be	cc_is_red		old_color	light_red
			be	cc_is_red		old_color	dark_red
			be	cc_is_green		old_color	green
			be	cc_is_green		old_color	light_green
			be	cc_is_green		old_color	dark_green
			be	cc_is_blue		old_color	blue
			be	cc_is_blue		old_color	light_blue
			be	cc_is_blue		old_color	dark_blue
			be	cc_is_purple		old_color	purple
			be	cc_is_purple		old_color	light_purple
			be	cc_is_purple		old_color	dark_purple
			be	cc_is_orange		old_color	orange
			be	cc_is_orange		old_color	light_orange
			be	cc_is_orange		old_color	dark_orange
			be	cc_is_yellow		old_color	yellow
			be	cc_is_yellow		old_color	light_yellow
			be	cc_is_yellow		old_color	dark_yellow
			be	change_color_end	0		0



cc_is_red		cp	ds_x			col_3
			cp	ds_y			row_1
			cpfa	new_color		red_arr		dim_or_light
			be	color_square		0		0

cc_is_green		cp	ds_x			col_2
			cp	ds_y			row_2
			cpfa	new_color		green_arr	dim_or_light
			be	color_square		0		0

cc_is_blue		cp	ds_x			col_2
			cp	ds_y			row_1
			cpfa	new_color		blue_arr	dim_or_light
			be	color_square		0		0

cc_is_purple		cp	ds_x			col_1
			cp	ds_y			row_1
			cpfa	new_color		purple_arr	dim_or_light
			be	color_square		0		0

cc_is_orange		cp	ds_x			col_3
			cp	ds_y			row_2
			cpfa	new_color		orange_arr	dim_or_light
			be	color_square		0		0

cc_is_yellow		cp	ds_x			col_1
			cp	ds_y			row_2
			cpfa	new_color		yellow_arr	dim_or_light
			be	color_square		0		0					



color_square		cp	ds_length		sq_length
			cp	ds_outline		cc_zero
			cp	ds_color		new_color
			call	draw_square		ds_ret

change_color_end	ret	change_color_ret




old_color		0
new_color		0

dim_or_light		0
dim			0
light			1
revert			2

change_color_ret	0

cc_zero			0
cc_one			1
js_game	call 	reset_vars	reset_vars_ret	
js_loop	call 	wait_2 		wait_ret2
	call 	add_new_square 	add_return 	//add new square to pattern array
	call 	show_all_colors show_return 	//light up squares by looping through pattern array
	call 	player_input 	input_return 	//take in player input one at a time, and compare with pattern array at that idx
	be 	js_loop 	js_zero		js_zero		

add_new_square	call	rng		rng_ret				//generate random number 0 to 5
		cpfa	color_to_add	new_color_arr	random_num	//grabs color at random index -> gets random color
		cpta 	color_to_add	arr 		end_idx 	//copy new_color to pattern array at end
		add 	end_idx 	end_idx 	inc 		//increment end_idx by 1
		cp 	0x80000004	end_idx				//show the number of squares they need to guess this round
		ret 	add_return 

show_all_colors cpfa 	current_color 	arr 	start_idx 	//grab the color to light up
		and	gs_switch	0x80000000	gt_one	//these 3 lines check if the "cube" was turned off
		cp	gs_is_home	gs_zero
		be	game_select	gs_switch	gt_zero
		cp	dim_or_light	light			//set color action to brighten the square
		cp 	old_color	current_color		//choose the square (by its color) to perform the brighten action on
		call	change_color	change_color_ret
		call 	wait_1 		wait_ret1		//wait ~1 sec to highlight the squares in the pattern
		cp 	dim_or_light 	revert
		call	change_color	change_color_ret
		call 	wait_1 		wait_ret1		//wait ~1 sec to let the shown square revert to its normal color
		add 	start_idx 	start_idx 	inc 	//increment start_idx by 1
		blt 	show_all_colors start_idx 	end_idx	//loop the previous code until we reach the end of our array
		cp 	start_idx 	js_zero			//reset the start_idx to 0, after the incrementing
		ret 	show_return 

player_input	be 	force_return 	start_idx 	end_idx
		cpfa 	pattern_color 	arr start_idx			//get color that player must remember and select
		cp 	dim_or_light	light				//set color action to brighten the square
wait_touch	call 	get_touch 	get_touch_ret			//check for touch
		bne 	wait_touch	touch_pressed 	js_one		//wait for user response
		cp	old_color	vga_color_read			//choose the square (by its color) to perform the brighten action on
		cp 	player_color 	vga_color_read			//store color that they pressed
		be	wait_touch	player_color	white		//if user didn't touch a square, don't do anything
		be	wait_touch	player_color	black		//same purpose as above comment
		call 	change_color	change_color_ret
		add 	start_idx 	start_idx 	inc		//increment iterating index
		cp 	0x80000003 	start_idx			//show how many colors currently guessed
wait_release	call 	get_touch 	get_touch_ret			//check for touch
		bne 	wait_release	touch_pressed 	js_zero
		call 	wait_1		wait_ret1
		cp 	dim_or_light 	revert
		call	change_color	change_color_ret
		be 	player_input 	pattern_color 	player_color
		bne 	exit_game 	pattern_color 	player_color

force_return	be 	exit_game 	end_idx 	end_game_idx	//end game if they won Jordan Says
		cp 	start_idx 	js_zero				//reset start_idx to 0, after incrementing in player_input
		cp 	0x80000003 	js_zero				//reset the number of colors currently guessed to 0
		ret 	input_return 

wait_2		cp 	time 		0x80000005 			//wait 2 seconds function
		add 	time_comp 	time 		time_inc2
wait_loop2	cp 	time 		0x80000005
		blt 	wait_loop2 	time 		time_comp
		ret 	wait_ret2

wait_1		cp time 0x80000005					//wait ~1 seconds function
		add time_comp time time_inc1
wait_loop1	cp time 0x80000005
		blt wait_loop1 time time_comp
		ret wait_ret1

exit_game	cp 	dim_or_light	dim				//end the game, reset values stored
		call	change_color	change_color_ret		//show the wrong square selected (e.g. failure)
		call 	wait_2		wait_ret2			
		call 	reset_vars	reset_vars_ret	
		ret 	js_ret


js_zero		0
js_one		1

time		0
time_comp	0
time_inc2	13000 	//slightly less then 2 seconds
time_inc1	8000	//1 second


js_ret  	0
add_return  	0
show_return  	0
input_return  	0
wait_ret2	0
wait_ret1	0

color_to_add	0
new_color_arr  	9447672		//purple
		16252928 	//red
		63488 		//green
		248		//blue
		16293888	//orange
		15790120	//yellow

arr		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0
		0



start_idx	0
end_idx 	0
inc		1
end_game_idx	19

x		0
y		0
current_color	0

pattern_color	1111
player_color	2222


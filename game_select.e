

//Game Selection
game_select	//call		play_available_note	play_available_note_ret
		//be		game_select		0			0


		be		skip_draw_home		gs_is_home		gs_one	
		
		call		reset_screen		reset_screen_ret
		
		cpdata		ds_x			320
		cpdata		ds_y			240	
		cpdata		ds_length		75	
		cpdata		ds_outline		1
		cp		ds_color		blue
		call		draw_square		ds_ret

		cpdata		ds_x			130
		cpdata		ds_y			240	
		cpdata		ds_length		75	
		cpdata		ds_outline		1
		cp		ds_color		purple
		call		draw_square		ds_ret

		cpdata		ds_x			510
		cpdata		ds_y			240	
		cpdata		ds_length		75	
		cpdata		ds_outline		1
		cp		ds_color		red
		call		draw_square		ds_ret
		
		cp		gs_is_home		gs_one

skip_draw_home	and		gs_switch		0x80000000		gs_one
		be		game_select		gs_switch		gs_zero
		
		//set random swap index for cb sequence based on current time
		call		rng			rng_ret
		cp		cb_swap1		random_num	
		be		gs_forward1		cb_swap1		cb_five
		add		cb_swap3		cb_swap1		cb_one
		be		gs_forward2		0			0	
gs_forward1	cp		cb_swap3		cb_zero

gs_forward2
		//ligthen home squares
		cpdata		ds_x			320
		cpdata		ds_y			240	
		cpdata		ds_length		75	
		cpdata		ds_outline		0
		cp		ds_color		light_blue
		call		draw_square		ds_ret

		cpdata		ds_x			130
		cp		ds_color		light_purple
		call		draw_square		ds_ret

		cpdata		ds_x			510
		cp		ds_color		light_red
		call		draw_square		ds_ret

wait_select	call		get_touch		get_touch_ret
		bne		wait_select		touched			vga_one
		be		start_js		color_touched		light_purple
		be		start_cb		color_touched		light_blue	
		be		start_mm		color_touched		light_red
		be		wait_select		0			0	


start_js	call		draw_game		draw_game_ret
		cpdata		0x80000004		1
		call		js_game			js_ret
		be		gs_end			0			0
start_cb	call		draw_game		draw_game_ret


		//set random swap index for cb sequence based on current time
		call		rng			rng_ret
		cp		cb_swap2		random_num
		be		gs_back1		cb_swap2		cb_zero
		sub		cb_swap4		cb_swap2		cb_one
		be		gs_back2		0			0
gs_back1	cp		cb_swap4		cb_five
gs_back2
		call		code_breaker		cb_ret

		be		gs_end			0			0
start_mm	call		draw_game		draw_game_ret
		call		music_mayhem		return

		be		gs_end			0			0

loop_select	be		wait_select		0			0



draw_game	call		reset_screen		reset_screen_ret
		call		reset_vars		reset_vars_ret
		
		cp		gs_is_home		gs_zero

		cp		ds_x			col_2
		cp		ds_y			row_1	
		cp		ds_length		sq_length
		cp		ds_outline		ds_one
		cp		ds_color		blue
		call		draw_square		ds_ret

		cp		ds_x			col_1
		cp		ds_y			row_1	
		cp		ds_length		sq_length
		cp		ds_outline		ds_one
		cp		ds_color		purple
		call		draw_square		ds_ret

		cp		ds_x			col_3
		cp		ds_y			row_1	
		cp		ds_length		sq_length
		cp		ds_outline		ds_one
		cp		ds_color		red
		call		draw_square		ds_ret
		
		cp		ds_x			col_1
		cp		ds_y			row_2	
		cp		ds_length		sq_length
		cp		ds_outline		ds_one
		cp		ds_color		yellow
		call		draw_square		ds_ret

		cp		ds_x			col_2
		cp		ds_y			row_2	
		cp		ds_length		sq_length
		cp		ds_outline		ds_one
		cp		ds_color		green
		call		draw_square		ds_ret

		cp		ds_x			col_3
		cp		ds_y			row_2	
		cp		ds_length		sq_length
		cp		ds_outline		ds_one
		cp		ds_color		orange
		call		draw_square		ds_ret

		ret		draw_game_ret		

gs_end		be		game_select		0		0
		//halt
		
gs_halt	halt

gs_ret		0


draw_game_ret	0
		

gs_read_color	0

gs_one		1
gs_zero		0
gs_is_home	0
gs_switch	0
gs_temp1	0
gs_temp2	0

//square info

row_1		150
row_2		330
col_1		130
col_2		320
col_3		510

sq_length	75
var_one		1


#include draw_square.e	
#include colors.e
#include vga_driver.e 
#include reset_screen.e
#include reset_vars.e
#include touch_driver.e
#include get_touch.e
#include change_color.e
#include code_breaker.e
#include JS.e
#include RNG.e
#include music_mayhem.e
#include sd_card_driver.e
#include sd_ram_driver.e
#include speaker_driver.e
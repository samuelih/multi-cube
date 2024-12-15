code_breaker	
				cp		cb_key			cb_zero
			cp		cb_dim_key		cb_zero
			cp		cb_key_revert		cb_zero
			cp		is_dim_bool			cb_zero
			call	cb_swap_seq		cb_swap_ret
cb_start		cpfa		cb_current_color	cb_sequence		cb_key		//copy the sequence of colors
cb_wait			call		get_touch		get_touch_ret				//
			bne		cb_wait			touched			cb_one
			cp		cb_color_pressed	vga_color_read
			call		is_light		cb_store		
			be		cb_wait			is_light_bool		cb_one
			
cb_check		be		cb_right		cb_current_color	cb_color_pressed
cb_wrong		cp		dim_or_light		dim
			cp		old_color		cb_color_pressed
			call		change_color		change_color_ret
			call	is_dim			cb_store
			be		cb_wait		is_dim_bool		cb_one
			cpta		new_color		cb_dim			cb_dim_key
			add		cb_dim_key		cb_dim_key		cb_one
			be		cb_start		cb_dim_key		cb_four
			
			be		cb_loop			cb_zero			cb_zero
cb_right		cp		dim_or_light		light
			cp		old_color		cb_color_pressed
			call		change_color		change_color_ret
			cpfa		cb_temp			cb_dim			cb_zero
			be		increment		cb_temp			cb_random		
			call		revert_all		cb_store
			
increment		be		cb_end			cb_key			cb_five
			add		cb_key			cb_key			cb_one
cb_loop			call		get_touch		get_touch_ret
			bne		cb_loop			touched			cb_zero			
			call		cb_start		cb_store
			
cb_end			be		game_select		cb_zero			cb_zero
			ret		cb_ret

revert_all		cp		cb_dim_key		cb_zero
			cpfa		old_color		cb_dim			cb_key_revert	
			cp		dim_or_light		revert
			call		change_color		change_color_ret				
			cpta		cb_random		cb_dim			cb_key_revert
			add		cb_key_revert		cb_key_revert		cb_one
			bne		revert_all		cb_key_revert		cb_five
			
			cp		cb_key_revert 		cb_zero
rev_all_end		ret		cb_store


is_light		be		is_light_skip		cb_color_pressed		light_red		
			be		is_light_skip		cb_color_pressed		light_blue
			be		is_light_skip		cb_color_pressed		light_green
			be		is_light_skip		cb_color_pressed		light_purple
			be		is_light_skip		cb_color_pressed		light_orange
			be		is_light_skip		cb_color_pressed		light_yellow
			be		is_light_skip		cb_color_pressed		white
			be		is_light_skip		cb_color_pressed		black

			cp		is_light_bool		cb_zero
			ret		cb_store	
is_light_skip		cp		is_light_bool		cb_one
			ret		cb_store

is_light_bool		0
cb_key_revert		0


is_dim		cpfa	col_dimmed		cb_dim		is_dim_key
			be		dim_found		new_color	col_dimmed	
			add		is_dim_key		is_dim_key	cb_one
			be		is_dim_end		is_dim_key	cb_five
			be		is_dim			cb_zero		cb_zero
dim_found	cp		is_dim_key		cb_zero
			cp		is_dim_bool		cb_one
			ret		cb_store
is_dim_end	cp		is_dim_key		cb_zero
			cp		is_dim_bool		cb_zero
			ret		cb_store

is_dim_key	0
is_dim_bool	0	//if one, color is already dimmed
col_dimmed	0


cb_swap_seq		cpfa	cb_temp2	cb_sequence 	cb_swap1
			cpfa	cb_temp3	cb_sequence		cb_swap2
			cpta	cb_temp3	cb_sequence		cb_swap1
			cpta	cb_temp2	cb_sequence		cb_swap2

			cpfa	cb_temp2	cb_sequence 	cb_swap3
			cpfa	cb_temp3	cb_sequence		cb_swap4
			cpta	cb_temp3	cb_sequence		cb_swap3
			cpta	cb_temp2	cb_sequence		cb_swap4


			ret	cb_swap_ret

cb_swap_ret		0

cb_test_halt	halt
cb_swap1	0
cb_swap2	0
cb_swap3	0
cb_swap4	0

cb_sequence		16252928
			63488
			248
			9447672
			16293888
			15790120


cb_dim			12345
			12345
			12345
			12345
			12345
cb_dim_key		0
cb_current_color	111111
cb_color_pressed	888888888
cb_key			0
cb_ret			0
cb_one			1
cb_seven		7
cb_five			5
cb_zero			0
cb_store		0
cb_four			4
cb_random		12345
cb_temp			0
cb_temp2		0
cb_temp3		0
//all functions return to 'return'


//get_open_index : gets the first index in sound_play_end
//incr_curr_play_adr : increments the value pointed to by sound_play_index, i.e getting the next note sample
//get_start_end_adr : gets the start and end addresses for the note at current index



get_open_index		cpfa	mm_temp			sound_play_end		open_index_temp
			be	get_open_index_end	mm_temp			music_zero
			add	open_index_temp		open_index_temp		music_one
			blt	no_open_index		sound_play_end_idx	open_index_temp		
			be	get_open_index		0			0
get_open_index_end	cp	open_index		open_index_temp
			cp	open_index_temp		music_zero
no_open_index		ret	return






get_start_end_adr	cpfa	start_adr		sound_play_start	sound_play_index
			cpfa	end_adr			sound_play_end		sound_play_index
			ret	return	






incr_curr_play_adr	call	get_start_end_adr	return
			add	mm_temp			start_adr		music_one
			blt	erase_note1		end_adr			mm_temp 	//if note's start address + 1 is greater than end address, erase note from arr
			cpta	mm_temp			sound_play_start	sound_play_index
			ret	return1				
erase_note1		cpta	music_zero		sound_play_start	sound_play_index
			cpta	music_zero		sound_play_end		sound_play_index
			cp	erased_note_end_adr	end_adr					//for determining which note finished playing
			call	on_note_erased		on_note_erased_ret
			ret 	return1

erased_note_end_adr	0

on_note_erased		cp	old_color		lit_color
			cp	dim_or_light		revert
			call	change_color		change_color_ret

			ret	on_note_erased_ret	

on_note_erased_ret	0






inc_sound_play_idx	be	index_to_zero1		sound_play_index	sound_play_end_idx
			add	sound_play_index	sound_play_index	music_one
			ret	return1
index_to_zero1		cp	sound_play_index	music_zero
			ret	return1




play_note_at_idx	cp	sd_data_write		music_zero
			cpfa	sd_ram_address		sound_play_start	sound_play_index
			call	sd_ram_driver		return

			//cp	sample			sd_ram_data
			//call	speaker_driver		return


			//less-blocking method

play_note_wait2		bne	play_note_wait2		0x80000041		music_zero	//wait for response = 0
			cp	0x80000042		sd_ram_data				//0x80000042 = speaker input
			cp	0x80000040		music_one				//0x80000040 = speaker command
			cp	speaker_cmd_off		music_zero
			ret	return1






play_available_note	be	skip_resp_check		speaker_cmd_off		music_one
			bne	PAN_end			0x80000041		music_one	//wait for response = 1
			cp	0x80000040		music_zero
			cp	speaker_cmd_off		music_one

skip_resp_check		cp	PAN_check_index		music_zero

			//loop through entire array to find index with available note. else return.
PAN_loop		call	get_start_end_adr	return
			bne	found_note		end_adr			music_zero
			call	inc_sound_play_idx	return1
			be	PAN_end			PAN_check_index		sound_play_end_idx
			add	PAN_check_index		PAN_check_index		music_one
			be	PAN_loop		0			0

found_note		call	play_note_at_idx	return1
			call	incr_curr_play_adr	return1
			call	inc_sound_play_idx	return1
			
PAN_end			ret	play_available_note_ret


play_available_note_ret	0



PAN_check_index		0

speaker_cmd_off		1

return1			0
return2			0
return3			0

open_index_temp		0
open_index		0
mm_temp			0
mm_temp2		0
temp_bool		0
open_index_ret		0
note_to_play		0
end_sample		0
start_adr		0
end_adr			0



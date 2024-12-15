music_mayhem    be      get_sd_data     music_one     music_one
music_start	cp      dim_or_light    light


mwait_touch     call    get_touch       get_touch_ret

speak_loop	//be	mwait_touch		sound_play_index	sound_play_end_idx
		//add	sound_play_index	sound_play_index	music_one

		
                bne     mwait_touch     	touch_pressed   	music_one
		
		//reset currently lit color (if one exists), then light up the new touched color.
		//function on_note_erased (called after a note finishes playing) will reset colors after a note finishes playing
		cp	old_color		lit_color
		cp	dim_or_light		revert
		call	change_color		change_color_ret

		cp	dim_or_light	light
                cp      old_color       vga_color_read
                call    change_color    change_color_ret
		cp	lit_color	color_touched
                cp      music_color_pressed vga_color_read
                be	note1               music_color_pressed        red
		be	note1               music_color_pressed        light_red
                be	note2               music_color_pressed        blue
		be	note2               music_color_pressed        light_blue
                be      note3               music_color_pressed        green
		be      note3               music_color_pressed        light_green
		be	note4               music_color_pressed        purple
		be	note4               music_color_pressed        light_purple
                be	note5               music_color_pressed        yellow
		be	note5               music_color_pressed        light_yellow
                be      note6               music_color_pressed        orange
		be      note6               music_color_pressed        light_orange
		be	mwait_touch	    0  			       0


note1          	cp      note_index      music_zero
               	be 	get_ram_data    note_index                 music_zero


note2          	cp      note_index       music_one 
               	be      get_ram_data     note_index                 music_one 


note3          	cp      note_index       music_two 
               	be      get_ram_data     note_index                 music_two 

note4          	cp      	note_index      music_three
               	be 	get_ram_data   	note_index                 music_three


note5          	cp      note_index       music_four 
               	be      get_ram_data     note_index                 music_four 


note6          	cp      note_index       music_five 
               	be      get_ram_data    	note_index                 music_five 



//loads ram
get_sd_data     cpfa    start_address      sound_start_address     music_zero
                cpfa    end_address        sound_end_address       music_five
                cp      index              start_address
		cp	sd_data_write	   music_one
sd_data_loop    cp      sd_address         index
		cp      sd_ram_address     index
                call    sd_card_driver     return
		call 	sd_ram_driver	   return
                cp      sd_ram_data        sd_data
                add     index              index                   music_one
                bne     sd_data_loop       index                   end_address
                be      music_start        index                   end_address



//loads note
get_ram_data    cpfa    start_address   sound_start_address     note_index
                cpfa    end_address     sound_end_address       note_index


//for playing multiple notes at the same time. (sounds bad)
//		call	get_open_index	return
//		cpta	start_address	sound_play_start	open_index
//		cpta	end_address	sound_play_end		open_index

//play one note at a time, by overwriting whatever note is already being played
		cpta	start_address	sound_play_start	music_zero
		cpta	end_address	sound_play_end		music_zero

		be	music_start	0			0

		

		
		
//		cp	sd_data_write	   music_zero
//                cp      index              start_address
//ram_loop	cp      sd_ram_address     index
//                call    sd_ram_driver     return
//               cp      sample             sd_ram_data
// 		call    speaker_driver     return 
//                add     index              index                   music_one
//                bne     ram_loop	   index                   end_address
//mwait_release	call 	get_touch	get_touch_ret
//		bne	mwait_release	touch_pressed	music_zero
//		cp      dim_or_light        revert
//               call    change_color        change_color_ret
//                be      music_start	   	index                   end_address		


sound_play_start	0
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
			
			
sound_play_end		0
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

sound_play_index	0

sound_play_end_idx	10 //starts at index 0, so max 21 notes at a time

//play_sound		cpfa	sample			sound_start_address	sound_play_index
//			cpfa	end_sample		sound_end_address	sound_play_index
//ps_inc			be	ps_ret			end_sample		music_zero
//			bne	skip_reset_sample	end_sample		sample
//
//			cpta	music_zero		sound_end_address	sound_play_index
//			cpta	music_zero		sound_start_address	sound_play_index
//
//skip_reset_sample	call	speaker_driver		return
//				
//ps_ret			be	index_to_begin		sound_play_index	sound_play_end_idx
//			add	sound_play_index	sound_play_index	music_one
//			cp	ps_start		music_zero
//			ret	return
//index_to_begin		cp	sound_play_index	music_zero
//			cp	ps_start	music_zero
//			ret	return


//ps_start		0	

//drums whole
sound_start_address2     0
			10815
			21630
			32954
			44278
			55602

sound_end_address2       10814
			21629
			32953
			44277
			55601
			64101


//piano whole
sound_start_address1     0
			17957
                        36090
			52110
			67425	
			83094

sound_end_address1       17956
			36089
			52109
			67424
			83093
			98057

//piano partial
sound_start_address    	3600
			21000
                        38000
			53000
			69000	
			87000

sound_end_address      	9500
			27000
			43000
			59000
			75000
			93000

one 1

speaker_index       0
start_address       0
end_address         0
note_index          0 
index		0
sd_address		0
music_zero          0
music_color_pressed 0
music_one           1
music_two           2
music_three         3
music_four	4
music_five	5
music_six	6
sd_size             1310720

lit_color	0


#include music_mayhem_helper.e







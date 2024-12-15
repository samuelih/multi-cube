//  Driver for touch screen
//  Usage: call     touch_driver    touch_ret

//  I/O Registers
//
//  Address		Access   Definition
//  --------------------------------------------------------
//  0x800000e0		write    bit 0:       touch_command 
//  0x800000e1		read     bit 0:       touch_response
//  0x800000e2	  	read     bits 9-0:    touch_x
//  0x800000e3	 	read     bits 8-0:    touch_y
//  0x800000e4		read     bit 0:       touch_pressed
//  --------------------------------------------------------

//  0x80000005		read	bits 31-0:    clock

touch_driver	cp	t_start			0x80000005			
		cp	0x800000e0		t_one			//set command = 1
wait_for_resp	call	play_available_note	play_available_note_ret
		sub	t_elapsed		0x80000005	t_start
		blt	t_loop			t_elapsed	t_max_wait
		cp	0x800000e0          	t_zero
		cp      touch_pressed		t_zero
		ret	touch_ret
t_loop		bne     wait_for_resp       	0x800000e1	t_one   //wait for response = 1


		cp      touch_x             	0x800000e2              //read response param 1
		cp      touch_y             	0x800000e3              //read response param 2
		cp      touch_pressed       	0x800000e4              //read response param 3
		cp      0x800000e0          	t_zero			//set command = 0    
wait_for_seen   bne     wait_for_seen       	0x800000e1      t_zero  //wait for response = 0 	
		ret	touch_ret  

//idle state reached, command = 0 & response = 0             


//response parameters
touch_x         0
touch_y         0
touch_pressed   0

//store return address
touch_ret	0

//comparison variables
t_one		1
t_zero		0

//clock
t_start		0
t_elapsed	0

//maximum wait time for touch input before returning.
//exclusive, time = t_max_wait multiplied by 0.125 miliseconds
//Ex: 80 = 10 miliseconds
t_max_wait	80 

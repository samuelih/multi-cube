//  Driver for Video Graphics Array (VGA) monitor

//  Usage: call     vga_driver    vga_ret
//  Bounds: 640 width/x (0-639), 480 height/y (0-479)
//  Top Left = (0, 0), Bottom Right = (639, 479)

//  I/O Registers
//
//  Address	Access	Definition
//  --------------------------------------------------------
//  0x80000060	write	bit 0:		vga_command
//  0x80000061	read	bit 0:		vga_response
//  0x80000062	write	bit 0:		vga_write
//  0x80000063	write	bits 9-0: 	vga_x1
//  0x80000064	write	bits 9-0: 	vga_y1
//  0x80000065	write	bits 9-0: 	vga_x2
//  0x80000066	write	bits 9-0: 	vga_y2
//  0x80000067	write	bits 23-0:	vga_color_write[23:0]
//  0x80000068	read	bits 23-0:	vga_color_read[23:0]
//  --------------------------------------------------------

vga_driver	cp      0x80000062             	vga_write			//write command param 1
		
//		be	vga_skip1		vga_write	vga_zero	//skip writing if write = 0 

		cp      0x80000063             	vga_x1				//write command param 2
		cp      0x80000064       	vga_y1				//write command param 3
		cp      0x80000065       	vga_x2				//write command param 4
		cp      0x80000066       	vga_y2				//write command param 5
		cp	0x80000067		vga_color_write			//write command param 6				

vga_skip1	cp	0x80000060		vga_one				//set command = 1

vga_wait_resp	bne     vga_wait_resp       	0x80000061	vga_one		//wait for response = 1
		
//		bne	vga_skip2		vga_write	vga_zero	//skip read color if write != 0, read color if write = 0
		cp	vga_color_read		0x80000068		
	
vga_skip2	cp      0x80000060          	vga_zero   			//set command = 0    
vga_wait_read   bne     vga_wait_read       	0x80000061      vga_zero	//wait for response = 0 	
		ret	vga_ret        


//command parameters
vga_write	0
vga_x1		0
vga_y1		0
vga_x2		0
vga_y2		0
vga_color_write	0

//response parameters
vga_color_read	0


//height and width bounds (inclusive)
vga_x_min	0
vga_x_max	639
vga_y_min	0
vga_y_max	479

//store return address
vga_ret		0

//comparison variables
vga_one		1
vga_zero	0
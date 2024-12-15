sd_ram_driver	cp  0x80000032      sd_data_write
		cp  0x80000033      sd_ram_address
		cp  0x80000034	    sd_ram_data
		cp  0x80000030      sdramone
ram_wait1    	cp  ram_response    0x80000031
	        be  ram_wait1    ram_response    sdramzero   
                cp  sd_ram_data     0x80000035              
                cp  0x80000030      sdramzero
ram_wait2       cp  ram_response    0x80000031              
                be  ram_wait2    ram_response    sdramone
                ret return   
   
sdramzero      0
sdramone       1
ram_response   0
sd_ram_data    0
sd_ram_address 0
sd_data_write	0
ram_return	0